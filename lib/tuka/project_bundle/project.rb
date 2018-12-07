# frozen_string_literal: true

module Tuka
  class Project
    def self.pbxproj
      'project.pbxproj'
    end

    def self.types
      { ObjC: 'objc', Swift: 'swift', Unity: 'unity' }
    end

    def initialize(xcodeproj)
      @xcodeproj = xcodeproj
      @project_configurator = Xcodeproj::Project.open(xcodeproj)
    end

    def name
      File.basename(@xcodeproj, '.*')
    end

    def pbxproj
      @pbxproj ||= pbxproj_path if File.file? pbxproj_path
    end

    def type
      # TODO: Reimplement this using @project_configurator files selection
      return nil if pbxproj.nil?

      text = File.read(pbxproj)
      return Project.types[:Unity]  if text.include? type_search_strings[:Unity]
      return Project.types[:ObjC]   if text.include? type_search_strings[:ObjC]
      return Project.types[:Swift]  if text.include? type_search_strings[:Swift]

      nil
    end

    def bundle_id
      grep_project_build_settings('PRODUCT_BUNDLE_IDENTIFIER')
    end

    def type_pretty
      return nil if type.nil?

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
        configuration.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'YES'
      end
      @project_configurator.save
    end

    def delete_previous_receptor_files
      file_references = @project_configurator.files.select { |file| file.path =~ /AppDelegate\+/ }
      return if file_references.empty?

      grouped_file_references = file_references.group_by { |ref| File.basename(ref.path, '.*') }
      groups_for_deletion = grouped_file_references.values.select do |group|
        m_file = group.select { |ref| File.extname(ref.path) == '.m' }.first
        return false if m_file.nil?

        File.read(m_file.full_path.to_s).include? receptor_search_string
      end

      groups_for_deletion.flatten.each do |ref|
        system 'rm', ref.full_path.to_s
        ref.remove_from_project
      end

      @project_configurator.save
    end

    def register_new_receptor_h_file(h_file)
      new_file_destination_group.new_file(File.basename(h_file))
      @project_configurator.save
    end

    def register_new_receptor_m_file(m_file)
      m_file_reference = new_file_destination_group.new_file(File.basename(m_file))
      @project_configurator.targets.first.add_file_references([m_file_reference])
      @project_configurator.save
    end

    def bridging_header
      @project_configurator.targets.first.build_configurations.first.build_settings['SWIFT_OBJC_BRIDGING_HEADER']
    end

    def register_bridging_header(bridging_header)
      reference = new_file_destination_group.new_file(File.basename(bridging_header))
      @project_configurator.targets.first.build_configurations.each do |config|
        config.build_settings['SWIFT_OBJC_BRIDGING_HEADER'] = reference.full_path.to_s
      end
      @project_configurator.save
    end

    def info_plist_path
      grep_project_build_settings('INFOPLIST_FILE')
    end

    def push_notifications_enabled?
      !File.read(pbxproj).scan(/com\.apple\.Push = {(\s)*enabled = 1;(\s)*};/m).empty?
    end

    private

    def pbxproj_path
      File.join(@xcodeproj, Project.pbxproj)
    end

    def receptor_search_string
      'class_getInstanceMethod(self, @selector(_application:didFinishLaunchingWithOptions:))'
    end

    def type_search_strings
      { ObjC: 'AppDelegate.h', Swift: 'AppDelegate.swift', Unity: 'UnityAppController.h' }
    end

    def grep_project_build_settings(pattern)
      grep_result = `xcodebuild -project "#{@xcodeproj}" -showBuildSettings | grep #{pattern}`
      return nil if grep_result.empty?

      grep_result.partition("\n").first.partition('= ').last
    end
  end
end
