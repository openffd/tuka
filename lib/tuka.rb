# frozen_string_literal: true

require 'colored2'
require 'thor'
require 'xcodeproj'

module Tuka
  require 'tuka/core_ext/dir'
  require 'tuka/core_ext/file'
  require 'tuka/core_ext/open_struct'
  require 'tuka/core_ext/string'
  require 'tuka/git'
  require 'tuka/project_bundle/info_plist'
  require 'tuka/project_bundle/podfile'
  require 'tuka/project_bundle/project'
  require 'tuka/tuka_bundle/bridging_header'
  require 'tuka/tuka_bundle/library'
  require 'tuka/tuka_bundle/receptor'
  require 'tuka/tuka_bundle/tukafile'
  require 'tuka/project_bundle'
  require 'tuka/tuka_bundle'
  require 'tuka/command'
  require 'tuka/commands'
  require 'tuka/cli'
  require 'tuka/version'
end
