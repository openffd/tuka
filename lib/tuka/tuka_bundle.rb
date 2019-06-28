# frozen_string_literal: true

module Tuka
  module TukaBundle
    DIR = '.tuka'
    PREVIOUS_DIRNAMES = ['_tuka'].freeze

    def tuka_bundle_dir
      @tuka_bundle_dir ||= Dir[DIR].first
    end

    def tukafile
      @tukafile ||= Tukafile.new(target_tukafile_path) if File.file? target_tukafile_path.to_s
    end

    def generated_library
      @generated_library ||= Library.new(target_library_path) if File.exist? target_library_path.to_s
    end

    def generated_podfile
      @generated_podfile ||= Podfile.new(target_generated_podfile_path) if File.file? target_generated_podfile_path.to_s
    end

    def receptor_bundle
      @receptor_bundle ||= ReceptorBundle.new(target_receptor_path) if File.exist? target_receptor_path.to_s
    end

    def target_library_path
      @target_library_path ||= File.join(DIR, tukafile.library.name)
    end

    def target_generated_podfile_path
      @target_generated_podfile_path ||= File.join(DIR, Podfile::BASENAME) if tuka_bundle_dir
    end

    def target_receptor_path
      @target_receptor_path ||= File.join(DIR, ReceptorBundle::DIRNAME) if tuka_bundle_dir
    end

    private

    def target_tukafile_path
      @target_tukafile_path ||= File.join(DIR, Tukafile::BASENAME) if tuka_bundle_dir
    end
  end
end
