# frozen_string_literal: true

module Tuka
  module TukaBundle
    PREVIOUS_DIRNAMES = ['_tuka'].freeze

    DIR = '.tuka'

    def tuka_bundle_dir
      @tuka_bundle_dir ||= Dir[DIR].first
    end

    def tukafile
      @tukafile ||= begin
        path = target_tukafile_path
        Tukafile.new(path) if path && File.file?(path)
      end
    end

    def generated_library
      @generated_library ||= begin
        path = target_library_path
        Library.new(path) if path && File.exist?(path)
      end
    end

    def generated_podfile
      @generated_podfile ||= begin
        path = target_generated_podfile_path
        Podfile.new(path) if path && File.file?(path)
      end
    end

    def receptor
      @receptor ||= begin
        path = target_receptor_path
        Receptor.new(path) if path && File.exist?(path)
      end
    end

    def target_library_path
      @target_library_path ||= File.join(DIR, tukafile.library.name)
    end

    def target_generated_podfile_path
      @target_generated_podfile_path ||= File.join(DIR, Podfile::BASENAME) if tuka_bundle_dir
    end

    def target_receptor_path
      @target_receptor_path ||= File.join(DIR, Receptor::DIRNAME) if tuka_bundle_dir
    end

    private

    def target_tukafile_path
      @target_tukafile_path ||= File.join(DIR, Tukafile::BASENAME) if tuka_bundle_dir
    end
  end
end
