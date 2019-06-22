# frozen_string_literal: true

module Tuka
  class Project
    include Xcodeproj::BuildSettings

    using System
    using CoreExtensions::StringPrefix

    attr_reader :name, :category_prefix
    attr_accessor :project_configurator

    def self.types
      { ObjC: 'objc', Swift: 'swift', Unity: 'unity' }
    end

    def initialize(xcodeproj)
      @xcodeproj = xcodeproj
      @project_configurator = Xcodeproj::Project.open(xcodeproj)
      @name = File.basename(@xcodeproj, '.*')
      @category_prefix = name.remove_non_letter_chars.generate_prefix
      @pbxproj_path = File.join(@xcodeproj, PBXProj::BASENAME)
    end

    def pbxproj
      @pbxproj ||= @pbxproj_path if File.file? @pbxproj_path
    end

    def type
      @type ||= detect_type
    end

    def bundle_id
      @bundle_id ||= grep_project_build_settings(PRODUCT_BUNDLE_IDENTIFIER)
    end

    def type_pretty
      Project.types.key(type).to_s
    end

    def new_file_destination_group
      type_key = Project.types.key(type)
      reference = @project_configurator.files.select { |file| file.path =~ /#{type_search_strings[type_key]}/ }.first
      return nil if reference.nil?

      reference.parent
    end

    def always_embed_swift_standard_libraries
      @project_configurator.targets.first.build_configurations.each do |configuration|
        configuration.build_settings[ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES] = INHERITED_FLAG
      end
      @project_configurator.save
    end

    def delete_previous_receptor_files
      file_references = @project_configurator.files.select { |file| file.path =~ /AppDelegate\+/ }
      return if file_references.empty?

      groups_for_deletion(file_references).flatten.each do |ref|
        rm(ref.full_path.to_s)
        ref.remove_from_project
      end

      @project_configurator.save
    end

    def add_new_receptor_files(h_file:, m_file:)
      new_file_destination_group.add_new_file(File.basename(h_file))
      m_file_ref = new_file_destination_group.add_new_file(File.basename(m_file))

      @project_configurator.targets.first.add_file_references([m_file_ref]) unless m_file_ref
      @project_configurator.save
    end

    def bridging_header
      @project_configurator.targets.first.build_configurations.first.build_settings[SWIFT_OBJC_BRIDGING_HEADER]
    end

    def register_bridging_header(bridging_header)
      reference = new_file_destination_group.new_file(File.basename(bridging_header))
      @project_configurator.targets.first.build_configurations.each do |config|
        config.build_settings[SWIFT_OBJC_BRIDGING_HEADER] = reference.full_path.to_s
      end
      @project_configurator.save
    end

    def info_plist_path
      @info_plist_path ||= grep_project_build_settings(INFOPLIST_FILE)
    end

    def push_notifications_enabled?
      !File.read(pbxproj).scan(/com\.apple\.Push = {(\s)*enabled = 1;(\s)*};/m).empty?
    end

    def contains_user_notifications_framework?
      references = @project_configurator.targets.first.frameworks_build_phase.files_references
      references.any? { |ref| ref.name == Frameworks.user_notifications_framework }
    end

    def add_user_notifications_framework
      frameworks_group = @project_configurator.groups.select { |group| group.name == Frameworks.group_name }.first
      return if frameworks_group.nil?

      add_user_notification_framework_to_group(frameworks_group)
    end

    private

    def detect_type
      if app_delegate_paths.include?(PBXProj::SEARCHABLE_UNITY)
        Project.types[:Unity]
      elsif app_delegate_paths.include?(PBXProj::SEARCHABLE_OBJC)
        Project.types[:ObjC]
      elsif app_delegate_paths.include?(PBXProj::SEARCHABLE_SWIFT)
        Project.types[:Swift]
      end
    end

    def app_delegate_paths
      @app_delegate_paths ||= @project_configurator.files.map(&:path).select do |path|
        PBXProj.constants.grep(/SEARCHABLE_*/).map(&PBXProj.method(:const_get)).include? path
      end
    end

    def receptor_search_string
      '(_, class_getInstanceMethod(AppDelegate.class, @selector(::)))'
    end

    def type_search_strings
      { ObjC: PBXProj::SEARCHABLE_OBJC, Swift: PBXProj::SEARCHABLE_SWIFT, Unity: PBXProj::SEARCHABLE_UNITY }
    end

    def groups_for_deletion(refs)
      grouped_file_refs(refs).values.select do |group|
        m_file = group.select { |ref| File.extname(ref.path) == '.m' }.first
        return false if m_file.nil?

        File.read(m_file.full_path.to_s).include? receptor_search_string
      end
    end

    def grouped_file_refs(refs)
      refs.group_by { |ref| File.basename(ref.path, '.*') }
    end

    def grep_project_build_settings(pattern)
      grep_result = `xcodebuild -project "#{@xcodeproj}" -showBuildSettings | grep #{pattern}`
      return nil if grep_result.empty?

      grep_result.partition("\n").first.partition('= ').last
    end

    def add_user_notification_framework_to_group(group)
      reference = group.new_file(Frameworks.user_notifications_framework_path)
      reference.set_source_tree(Frameworks.source_tree)
      @project_configurator.targets.first.frameworks_build_phase.add_file_reference(reference)
      @project_configurator.save
    end
  end
end
