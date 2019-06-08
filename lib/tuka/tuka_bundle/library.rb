# frozen_string_literal: true

module Tuka
  class Library
    prepend RequestHeader
    prepend LibrarySearchables
    using CoreExtensions
    using RequestHeader

    attr_reader :path, :activation_date, :request_headers

    CARGO_DIR = '.github'

    def initialize(path)
      @path = path
      @cargo_path = File.join(@path, Library::CARGO_DIR)
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

    def update_url_path_in_files(url_path)
      @url_path = url_path

      matched_file_paths = Dir.glob(config_file_glob_pattern)
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        url_path_search_pairs.each { |pattern, replacement| File.open(path, 'r+').gsub_content(pattern, replacement) }
      end
      true
    end

    def update_protocol_in_files(protocol)
      return true if protocol == 'https'

      @protocol = protocol

      matched_file_paths = Dir.glob(config_file_glob_pattern)
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        protocol_search_pairs.each { |pattern, replacement| File.open(path, 'r+').gsub_content(pattern, replacement) }
      end
      true
    end

    def update_activation_date(inactive_days)
      require 'date'

      @activation_date = (DateTime.now + inactive_days.to_i).strftime('%y-%m-%d')

      matched_file_paths = Dir.glob(config_file_glob_pattern)
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        inactive_days_search_pairs.each do |pattern, replacement|
          File.open(path, 'r+').gsub_content(pattern, replacement)
        end
      end
    end

    def update_request_headers(count)
      @request_headers = generate_request_headers(count)

      matched_file_paths = Dir.glob(resource_file_glob_pattern)
      return false if matched_file_paths.empty?

      matched_file_paths.each do |path|
        request_header_search_pairs.each do |pattern, replacement|
          File.open(path, 'r+').gsub_content(pattern, replacement)
        end
      end
    end

    private

    def config_file_glob_pattern
      File.join(@cargo_path, 'lib', 'core', '*.m')
    end

    def resource_file_glob_pattern
      File.join(@cargo_path, 'lib', 'core', 'extensions', 'Resource+.*')
    end

    def bundle_id_parts
      @bundle_id.split(/\./, 3)
    end

    def cipher_parts
      @cipher.split(/\./, 3)
    end

    def activation_date_parts
      @activation_date.split(/\-/, 3)
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

    def url_path_search_pairs
      Hash[url_path_search_strings.zip(url_path_replacement_strings)]
    end

    def protocol_search_pairs
      Hash[protocol_search_strings.zip(protocol_replacement_strings)]
    end

    def inactive_days_search_pairs
      Hash[inactive_days_search_strings.zip(inactive_days_replacement_strings)]
    end

    def request_header_search_pairs
      Hash[request_header_search_strings.zip(request_header_replacement_strings)]
    end

    def bundle_id_replacement_strings
      ['[NSString stringWithFormat:NSString.tagStringFormat, self.tagFirstPart, self.tagSecondPart, self.tagThirdPart]',
       "NSString *tagFirstPart = @\"#{bundle_id_parts[0]}\"",
       "NSString *tagSecondPart = @\"#{bundle_id_parts[1]}\"",
       "NSString *tagThirdPart = @\"#{bundle_id_parts[2]}\""]
    end

    def base_url_replacement_strings
      ["@\"#{cipher_parts[0]}\", @\"#{cipher_parts[1]}\", @\"#{cipher_parts[2]}\""]
    end

    def user_agent_replacement_strings
      ["NSString *sender = @\"#{UserAgent.default(value: @user_agent)}\";"]
    end

    def url_path_replacement_strings
      ["NSString *filter = @\"#{@url_path}\""]
    end

    def protocol_replacement_strings
      ['NSString *extension = @""']
    end

    def inactive_days_replacement_strings
      ["NSString *yearString = @\"#{activation_date_parts[0]}\"",
       "NSString *monthString = @\"#{activation_date_parts[1]}\"",
       "NSString *dayString = @\"#{activation_date_parts[2]}\""]
    end

    def request_header_replacement_strings
      [@request_headers.to_swift]
    end
  end
end
