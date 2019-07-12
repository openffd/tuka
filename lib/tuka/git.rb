# frozen_string_literal: true

module Tuka
  module Git
    GITIGNORE_BASENAME = '.gitignore'

    def git_clone(url, dir = Dir.pwd)
      rm_tmp_cmd = "rm -rf #{dir}/tmp"
      system "#{rm_tmp_cmd}; git clone #{url} #{dir}/tmp && mv #{dir}/tmp/* #{dir} && #{rm_tmp_cmd}"
    end

    def gitignore_add(pattern = nil)
      GitignoreGenerator.new(pattern.to_s).generate unless File.file? GITIGNORE_BASENAME
      text = File.read(GITIGNORE_BASENAME)
      return if pattern.nil? || text.include?(pattern.to_s)

      File.open(GITIGNORE_BASENAME, 'w+') { |file| file.write("#{pattern}\n#{text}") }
    end
  end
end
