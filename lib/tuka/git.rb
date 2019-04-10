# frozen_string_literal: true

module Tuka
  module Git
    def self.gitignore_basename
      '.gitignore'
    end

    def git_clone(url, dir = Dir.pwd, cargo_dir = Library.cargo_dir)
      system "git clone #{url} #{dir}/tmp && mv #{dir}/tmp/* #{dir}/tmp/#{cargo_dir} #{dir} && rm -rf #{dir}/tmp"
    end

    def gitignore(pattern)
      require_relative 'templates/gitignore/gitignore_generator'
      GitignoreGenerator.new(pattern).generate unless File.file? Git.gitignore_basename
      text = File.read(Git.gitignore_basename)
      return if text.include? pattern

      File.open(Git.gitignore_basename, 'w+') { |file| file.write("#{pattern}\n#{text}") }
    end
  end
end
