# frozen_string_literal: true

require 'colored2'
require 'thor'
require 'xcodeproj'
require 'awesome_print'

module Tuka
  require 'tuka/xcodeproj/overrides'
  require 'tuka/xcodeproj/build_settings'
  require 'tuka/core_ext/dir'
  require 'tuka/core_ext/file'
  require 'tuka/core_ext/open_struct'
  require 'tuka/core_ext/string'
  require 'tuka/git'
  require 'tuka/bundler'
  require 'tuka/request_header'
  require 'tuka/project_bundle/info_plist'
  require 'tuka/project_bundle/podfile'
  require 'tuka/project_bundle/project'
  require 'tuka/project_bundle/gemfile'
  require 'tuka/tuka_bundle/bridging_header'
  require 'tuka/tuka_bundle/library/searchables'
  require 'tuka/tuka_bundle/library'
  require 'tuka/tuka_bundle/receptor'
  require 'tuka/tuka_bundle/tukafile'
  require 'tuka/frameworks'
  require 'tuka/project_bundle'
  require 'tuka/tuka_bundle'
  require 'tuka/command'
  require 'tuka/commands'
  require 'tuka/cli'
  require 'tuka/cli_patch'
  require 'tuka/version'
end
