# frozen_string_literal: true

module Tuka
  module Messages
    module TukafileErrors
      filename    = Tuka::Tukafile::BASENAME
      days_range  = Tuka::Tukafile::DAYS_RANGE

      INVALID_LIBRARY                     = filename + " `library.digest' was tampered"
      INVALID_PROJECT_INFO_BUNDLE_ID      = filename + " `project_info.bundle_id' is invalid"
      INVALID_PROJECT_INFO_HEADERS        = filename + " `project_info.headers' is invalid"
      INVALID_PROJECT_INFO_PREFIX         = filename + " `project_info.prefix' is invalid"
      INVALID_PROJECT_INFO_RECEPTOR_NAME  = filename + " `project_info.receptor_name' is invalid"
      INVALID_PROJECT_INFO_SWIFT_VERSION  = filename + " `project_info.swift_version' is invalid"
      INVALID_PROJECT_INFO_TYPE           = filename + " `project_info.type' is invalid"
      INVALID_PROJECT_INFO_XCODEPROJ      = filename + " `project_info.xcodeproj' is invalid"
      INVALID_SERVER_INACTIVE_DAYS        = filename + " `server.inactive_days' range: (#{days_range})"
      INVALID_SERVER_PROTOCOL             = filename + " `server.protocol' is invalid"
      INVALID_SERVER_URL                  = filename + " `server.url' is invalid"
      INVALID_SERVER_URL_PATH             = filename + " `server.url_path' is invalid"
      INVALID_SERVER_URL_TYPE             = filename + " `server.url_type' is invalid"
      INVALID_SERVER_USER_AGENT           = filename + " `server.user_agent' is invalid"
    end
  end
end
