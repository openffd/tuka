# frozen_string_literal: true

module Tuka
  class Entitlements
    attr_reader :path

    APS_ENVIRONMENT = 'aps-environment'
    APS_ENVIRONMENT_VALUE = 'development'

    def initialize(path)
      @path = path
      @plist = CFPropertyList::List.new(file: @path)
    end

    def aps_environment_setup?
      @plist.value.value[APS_ENVIRONMENT].to_s.eql? APS_ENVIRONMENT_VALUE
    end
  end
end
