# frozen_string_literal: true

module Tuka
  module Git
    GITIGNORE_BASENAME = '.gitignore'

    def git_clone(url, dir = Dir.pwd, cargo_dir = nil)
      require 'pry'
      binding.pry
      system "git clone #{url} #{dir}/tmp && mv #{dir}/tmp/* #{dir}/tmp/#{cargo_dir} #{dir} && rm -rf #{dir}/tmp"
    end

    def gitignore(pattern)
      require_relative 'templates/gitignore/gitignore_generator'
      GitignoreGenerator.new(pattern).generate unless File.file? GITIGNORE_BASENAME
      text = File.read(GITIGNORE_BASENAME)
      return if text.include? pattern

      File.open(GITIGNORE_BASENAME, 'w+') { |file| file.write("#{pattern}\n#{text}") }
    end
  end
end
