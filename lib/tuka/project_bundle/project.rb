# frozen_string_literal: true

module Tuka
  class Project
    include Xcodeproj::BuildSettings
    include Xcodebuild

    using System
    using CoreExtensions::FileEncoding
    using CoreExtensions::StringPrefix

    attr_reader :name, :category_prefix

    require "pry"
    binding.pry
    TYPE_SEARCH_STRINGS = {
      ObjC: Tuka::PBXProj::SEARCHABLE_OBJC,
      Swift: Tuka::PBXProj::SEARCHABLE_SWIFT,
      Unity: Tuka::PBXProj::SEARCHABLE_UNITY
    }.freeze
    RECEPTOR_SEARCH_STRING = '(_, class_getInstanceMethod(AppDelegate.class, @selector(::)))'
    private_constant :TYPE_SEARCH_STRINGS, :RECEPTOR_SEARCH_STRING

    TYPES = { ObjC: 'objc', Swift: 'swift', Unity: 'unity' }.freeze
    TYPES.values.each do |type|
      define_method("#{type}?".to_sym) do
        @type == type
      end
    end

    def initialize(xcodeproj)
      @xcodeproj = xcodeproj
      @configurator = Xcodeproj::Project.open(xcodeproj)
      @name = File.basename(@xcodeproj, '.*')
      @category_prefix = name.remove_non_letter_chars.generate_prefix.upcase
      @pbxproj_path = File.join(@xcodeproj, PBXProj::BASENAME)
      @swizzling_pattern = /method_exchangeImplementations\(_, class_getInstanceMethod\(.*, @selector\(::\)\)\);/
    end

    def pbxproj
      @pbxproj ||= @pbxproj_path if File.file? @pbxproj_path
    end

    def type
      @type ||= detect_type
    end

    def bundle_id
      @bundle_id ||= get_project_build_setting(PRODUCT_BUNDLE_IDENTIFIER)
    end

    def type_pretty
      TYPES.key(type).to_s
    end

    def new_file_destination_group
      reference = @configurator.files.select { |file| file.path =~ /#{TYPE_SEARCH_STRINGS[TYPES.key(type)]}/ }.first
      return nil if reference.nil?

      reference.parent
    end

    def always_embed_swift_standard_libraries
      @configurator.targets.first.build_configurations.each do |configuration|
        configuration.build_settings[ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES] = INHERITED_FLAG
      end
      save_configuration
    end

    def delete_previous_receptor_files
      return if receptor_files.empty?

      groups_for_deletion(receptor_files).flatten.each do |ref|
        rm(ref.full_path.to_s)
        ref.remove_from_project
      end

      save_configuration
    end

    def add_new_receptor_files(h_file:, m_file:)
      new_file_destination_group.add_new_file(File.basename(h_file))
      m_file_ref = new_file_destination_group.add_new_file(File.basename(m_file))

      @configurator.targets.first.add_file_references([m_file_ref]) if m_file_ref
      save_configuration
    end

    def bridging_header
      @configurator.targets.first.build_configurations.first.build_settings[SWIFT_OBJC_BRIDGING_HEADER]
    end

    def register_bridging_header(bridging_header)
      reference = new_file_destination_group.new_file(File.basename(bridging_header))
      @configurator.targets.first.build_configurations.each do |config|
        config.build_settings[SWIFT_OBJC_BRIDGING_HEADER] = reference.full_path.to_s
      end
      save_configuration
    end

    def info_plist_path
      @info_plist_path ||= get_project_build_setting(INFOPLIST_FILE)
    end

    def push_notifications_enabled?
      !File.read(pbxproj).scan(/com\.apple\.Push = {(\s)*enabled = 1;(\s)*};/m).empty?
    end

    def contains_user_notifications_framework?
      references = @configurator.targets.first.frameworks_build_phase.files_references
      references.any? { |ref| ref.name == Frameworks.user_notifications_framework }
    end

    def add_user_notifications_framework
      frameworks_group = @configurator.groups.select { |group| group.name == Frameworks.group_name }.first
      return if frameworks_group.nil?

      add_user_notification_framework_to_group(frameworks_group)
    end

    private

    def implementation_pattern
      /^@implementation #{implementation_klass} \(.*\)$/
    end

    def implementation_klass
      @implementation_klass ||= begin
        searchable = unity? ? PBXProj::SEARCHABLE_UNITY : PBXProj::SEARCHABLE_OBJC
        File.basename(searchable, '.*')
      end
    end

    def current_receptor_implementation_files
      @current_receptor_implementation_files ||= begin
        utf8_files = @configurator
                     .files
                     .select { |file| file.path =~ /^.*\.m$/ && File.open(file.real_path).utf_8? }
        utf8_files.select do |file|
          content = File.read(file.real_path)
          return false unless content =~ implementation_pattern

          content =~ @swizzling_pattern
        end
      end
    end

    def receptor_files
      headers = current_receptor_implementation_files.map do |file|
        implementation = File.basename(file.real_path, '.*')
        @configurator.files.select { |f| implementation.eql? File.basename(f.real_path, '.h') }
      end
      current_receptor_implementation_files.to_a + headers.flatten.to_a
    end

    def save_configuration
      @configurator.save
    end

    def detect_type
      if app_delegate_paths.include?(PBXProj::SEARCHABLE_UNITY)
        TYPES[:Unity]
      elsif app_delegate_paths.include?(PBXProj::SEARCHABLE_OBJC)
        TYPES[:ObjC]
      elsif app_delegate_paths.include?(PBXProj::SEARCHABLE_SWIFT)
        TYPES[:Swift]
      else
        raise StandardError, 'Unable to detect a valid AppDelegate file'
      end
    end

    def possible_app_delegate_files
      searchables = PBXProj.constants.grep(/SEARCHABLE_*/).map(&PBXProj.method(:const_get))
      @configurator.files.select { |file| searchables.include? File.basename(file.real_path) }
    end

    def app_delegate_paths
      @app_delegate_paths ||= begin
        possible_app_delegate_files
          .map(&:real_path)
          .select(&File.method(:file?))
          .map(&File.method(:basename))
      end
    end

    def groups_for_deletion(refs)
      grouped_file_refs(refs).values.select do |group|
        m_file = group.select { |ref| File.extname(ref.path) == '.m' }.first
        return false if m_file.nil?

        File.read(m_file.full_path.to_s).include? RECEPTOR_SEARCH_STRING
      end
    end

    def grouped_file_refs(refs)
      refs.group_by { |ref| File.basename(ref.path, '.*') }
    end

    def add_user_notification_framework_to_group(group)
      reference = group.new_file(Frameworks.user_notifications_framework_path)
      reference.set_source_tree(Frameworks.source_tree)
      @configurator.targets.first.frameworks_build_phase.add_file_reference(reference)
      save_configuration
    end
  end
end
