# frozen_string_literal: true

require 'awesome_print'
require 'colored2'
require 'curb'
require 'date'
require 'thor'
require 'whirly'
require 'xcodeproj'

# TODO: Use Pathname

# TODO: This method should not reference tuka
Kernel.module_eval do
  def require_matched(dir_pattern)
    Dir[dir_pattern]
      .map { |f| f.gsub(%r{.*(?=tuka/)}, '') }
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
  require 'tuka/credentials'
  require 'tuka/git'
  require 'tuka/bundler'
  require 'tuka/request_header'
  require 'tuka/curl'
  require 'tuka/xcodebuild'
  require_matched File.join(gem_lib_tuka, 'project_bundle', '*.rb')
  require_matched File.join(gem_lib_tuka, 'tuka_bundle', '*', '*.rb')
  require_matched File.join(gem_lib_tuka, 'tuka_bundle', '*.rb')
  require_matched File.join(gem_lib_tuka, 'messages', '*')
  require 'tuka/frameworks'
  require 'tuka/modder'
  require 'tuka/project_bundle'
  require 'tuka/tuka_bundle'
  require 'tuka/command'
  require 'tuka/commands'
  require 'tuka/cli'
  require 'tuka/cli_patch'
  require 'tuka/version'
  require_matched File.join(gem_lib_tuka, 'templates', '*', '*.rb')
end
