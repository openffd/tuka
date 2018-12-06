# frozen_string_literal: true

require 'bundler/setup'
require 'tuka'
require 'pry'

RSpec.configure do |config|
  Kernel.srand config.seed
  config.order = :random

  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.profile_examples = 10
  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?
end
