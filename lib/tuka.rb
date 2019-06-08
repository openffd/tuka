# frozen_string_literal: true

require 'awesome_print'
require 'colored2'
require 'curb'
require 'thor'
require 'whirly'
require 'xcodeproj'

Kernel.module_eval do
  def require_matched(dir_pattern)
    Dir[dir_pattern]
      .map { |f| f.gsub(/.*(?=tuka\/)/, '') }
      .each { |f| require f }
  end
end

module Tuka
  gem_lib_tuka = File.join(__dir__, 'tuka')

  require 'tuka/xcodeproj/overrides'
  require 'tuka/xcodeproj/build_settings'
  require_matched File.join(gem_lib_tuka, 'core_ext', '*')
  require 'tuka/bash/bash_profile'
  require 'tuka/bash/tukarc'
  require 'tuka/git'
  require 'tuka/bundler'
  require 'tuka/request_header'
  require 'tuka/curl'
  require 'tuka/project_bundle/info_plist'
  require 'tuka/project_bundle/podfile'
  require 'tuka/project_bundle/project'
  require 'tuka/project_bundle/gemfile'
  require 'tuka/tuka_bundle/bridging_header'
  require 'tuka/tuka_bundle/library/searchables'
  require 'tuka/tuka_bundle/library'
  require 'tuka/tuka_bundle/receptor'
  require 'tuka/tuka_bundle/tukafile'
  require_matched File.join(gem_lib_tuka, 'messages', '*')
  require 'tuka/frameworks'
  require 'tuka/project_bundle'
  require 'tuka/tuka_bundle'
  require 'tuka/command'
  require 'tuka/commands'
  require 'tuka/cli'
  require 'tuka/cli_patch'
  require 'tuka/version'
  require_matched File.join(gem_lib_tuka, 'templates', '*', '*.rb')
end
