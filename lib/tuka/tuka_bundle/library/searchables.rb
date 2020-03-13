# frozen_string_literal: true

module Tuka
  module LibrarySearchables
    def bundle_id_search_strings
      # ['[NSString stringWithFormat:@"%@", NSBundle.mainBundle.bundleIdentifier]',
      #  'NSString *tagFirstPart = nil',
      #  'NSString *tagSecondPart = nil',
      #  'NSString *tagThirdPart = nil']
      ['static let defaultIdentifier: NSString = "defaultIdentifier" //']
    end

    def base_url_search_strings
      # ['@"loc0", @"loc1", @"loc2"']
      ['static let cypher: NSString = "cypher" //']
    end

    def user_agent_search_strings
      # [/NSString \*sender = (@")?.*"?;/]
      ['static let defaultUserAgent: HTTP.Header.Field.Value = "defaultUserAgent" //']
    end

    def url_path_search_strings
      # ['NSString *filter = @"index"']
      ['static let defaultPath: URLComponents.Path = "defaultPath" //']
    end

    def protocol_search_strings
      # ['NSString *extension = NSString.defaultProtocolExtension']
      []
    end

    def inactive_days_search_strings
      # ['NSString *yearString = @"00"',
      #  'NSString *monthString = @"00"',
      #  'NSString *dayString = @"00"']
      ['static let appointment: Date.RawValue = "appointment" //']
    end

    def request_header_search_strings
      # ['// REQUEST_HEADERS']
      []
    end
  end
end
