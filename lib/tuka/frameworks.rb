# frozen_string_literal: true

module Tuka
  module Frameworks
    def self.group_name
      'Frameworks'
    end

    def self.source_tree
      'SDKROOT'
    end

    def self.user_notifications_framework
      'UserNotifications.framework'
    end

    def self.user_notifications_framework_path
      'System/Library/Frameworks/' + user_notifications_framework
    end
  end
end
