# frozen_string_literal: true

module Tuka
  class Library
    using CoreExtensions

    attr_reader :path

    def self.cargo_dir
      '.github'
    end

    def initialize(path)
      @path = path
      @cargo_path = File.join(@path, Library.cargo_dir)
    end

    def target_bridges_path
      File.join(@cargo_path, 'bridges')
    end

    def target_receptors_path
      File.join(@cargo_path, 'receptors')
    end

    def update_bundle_id_in_files(bundle_id)
      @bundle_id = bundle_id

      matched_file_paths = Dir.glob(config_file_glob_pattern)
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        bundle_id_search_pairs.each { |pattern, replacement| File.open(path, 'r+').gsub_content(pattern, replacement) }
      end
      true
    end

    def update_base_url_in_files(cipher)
      @cipher = cipher

      matched_file_paths = Dir.glob(config_file_glob_pattern)
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        base_url_search_pairs.each { |pattern, replacement| File.open(path, 'r+').gsub_content(pattern, replacement) }
      end
      true
    end

    def update_user_agent_in_files(user_agent)
      @user_agent = user_agent

      matched_file_paths = Dir.glob(config_file_glob_pattern)
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        user_agent_search_pairs.each { |pattern, replacement| File.open(path, 'r+').gsub_content(pattern, replacement) }
      end
      true
    end

    def remove_three_part_tags
      matched_file_paths = Dir.glob(config_file_glob_pattern)
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        File.open(path, 'r+').gsub_content(/\s- \(NSString \*\)tagFirstPart {.*tagThirdPart;\s}\s/m, '')
      end
      true
    end

    private

    def config_file_glob_pattern
      File.join(@cargo_path, 'lib', 'core', '*.m')
    end

    def bundle_id_parts
      @bundle_id.split(/\./, 3)
    end

    def bundle_id_search_pairs
      Hash[bundle_id_search_strings.zip(bundle_id_replacement_strings)]
    end

    def base_url_search_pairs
      Hash[base_url_search_strings.zip(base_url_replacement_strings)]
    end

    def user_agent_search_pairs
      Hash[user_agent_search_strings.zip(user_agent_replacement_strings)]
    end

    def bundle_id_search_strings
      ['[NSString stringWithFormat:@"%@", NSBundle.mainBundle.bundleIdentifier]',
       'NSString *tagFirstPart = nil',
       'NSString *tagSecondPart = nil',
       'NSString *tagThirdPart = nil']
    end

    def base_url_search_strings
      ['NSString *baseURL = nil; //#']
    end

    def user_agent_search_strings
      ['NSString *userAgent = nil; //#']
    end

    def bundle_id_replacement_strings
      ['[NSString stringWithFormat:NSString.tagStringFormat, self.tagFirstPart, self.tagSecondPart, self.tagThirdPart]',
       "NSString *tagFirstPart = @\"#{bundle_id_parts[0]}\"",
       "NSString *tagSecondPart = @\"#{bundle_id_parts[1]}\"",
       "NSString *tagThirdPart = @\"#{bundle_id_parts[2]}\""]
    end

    def base_url_replacement_strings
      ["NSString *baseURL = @\"#{@cipher}\"; //#"]
    end

    def user_agent_replacement_strings
      ["NSString *userAgent = @\"#{@user_agent}\"; //#"]
    end
  end
end
