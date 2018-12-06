# frozen_string_literal: true

module Tuka
  require 'cfpropertylist'

  class InfoPlist
    attr_reader :path

    APP_TRANSPORT_SECURITY = 'NSAppTransportSecurity'
    ALLOWS_ARBITRARY_LOADS = 'NSAllowsArbitraryLoads'

    def initialize(path)
      @path = path
    end

    def set_allows_arbitrary_loads
      plist_object = CFPropertyList::List.new(file: @path)
      plist_data = CFPropertyList.native_types(plist_object.value)
      settings = plist_data[APP_TRANSPORT_SECURITY]
      return unless settings.nil? || settings[ALLOWS_ARBITRARY_LOADS].nil? || settings[ALLOWS_ARBITRARY_LOADS] == false

      plist_data[APP_TRANSPORT_SECURITY] = { ALLOWS_ARBITRARY_LOADS => true }
      plist_object.value = CFPropertyList.guess(plist_data)
      plist_object.save(@path, CFPropertyList::List::FORMAT_BINARY)
    end
  end
end
