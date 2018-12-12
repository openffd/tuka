# frozen_string_literal: true

module Tuka
  class Library
    using CoreExtensions

    attr_reader :path

    def initialize(path)
      @path = path
    end

    def update_bundle_id_in_files(bundle_id)
      @bundle_id = bundle_id

      matched_file_paths = Dir.glob("#{@path}/_lib/core/*.m")
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        bundle_id_search_pairs.each { |pattern, replacement| File.open(path, 'r+').gsub_content(pattern, replacement) }
      end
      true
    end

    def target_bridges_path
      File.join(@path, '_bridges')
    end

    def target_receptors_path
      File.join(@path, '_receptors')
    end

    def update_base_url_in_files(cipher)
      @cipher = cipher

      matched_file_paths = Dir.glob("#{@path}/_lib/core/*.m")
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        base_url_search_pairs.each { |pattern, replacement| File.open(path, 'r+').gsub_content(pattern, replacement) }
      end
      true
    end

    def update_user_agent_in_files(user_agent)
      @user_agent = user_agent

      matched_file_paths = Dir.glob("#{@path}/_lib/core/*.m")
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        user_agent_search_pairs.each { |pattern, replacement| File.open(path, 'r+').gsub_content(pattern, replacement) }
      end
      true
    end

    private

    def bundle_id_search_pairs
      Hash[bundle_id_search_strings.zip(bundle_id_replacement_strings)]
    end

    def base_url_search_pairs
      Hash[base_url_search_strings.zip(base_url_replacement_strings)]
    end

    def user_agent_search_pairs
      Hash[user_agent_search_strings.zip(user_agent_replacement_strings)]
    end

    # search strings

    def bundle_id_search_strings
      ['NSString *bundleIdentifier = NSBundle.mainBundle.bundleIdentifier; //#']
    end

    def base_url_search_strings
      ['NSString *baseURL = nil; //#']
    end

    def user_agent_search_strings
      ['NSString *userAgent = nil; //#']
    end

    # replacement strings

    def bundle_id_replacement_strings
      ["NSString *bundleIdentifier = @\"#{@bundle_id}\"; //#"]
    end

    def base_url_replacement_strings
      ["NSString *baseURL = @\"#{@cipher}\"; //#"]
    end

    def user_agent_replacement_strings
      ["NSString *userAgent = @\"#{@user_agent}\"; //#"]
    end
  end
end
