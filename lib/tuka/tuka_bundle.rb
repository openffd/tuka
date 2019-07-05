# frozen_string_literal: true

module Tuka
  module TukaBundle
    DIR = '.tuka'
    PREVIOUS_DIRNAMES = ['_tuka'].freeze

    def tuka_bundle_dir
      @tuka_bundle_dir ||= Dir[DIR].first
    end

    def tukafile
      @tukafile ||= Tukafile.new(generated_tukafile_path) if File.file? generated_tukafile_path.to_s
    end

    def generated_library
      @generated_library ||= Library.new(generated_library_path) if File.exist? generated_library_path.to_s
    end

    def generated_podfile
      @generated_podfile ||= Podfile.new(generated_podfile_path) if File.file? generated_podfile_path.to_s
    end

    def receptor_bundle
      @receptor_bundle ||= ReceptorBundle.new(generated_receptor_path) if File.exist? generated_receptor_path.to_s
    end

    def generated_library_path
      @generated_library_path ||= File.join(DIR, tukafile.library.name)
    end

    def generated_podfile_path
      @generated_podfile_path ||= File.join(DIR, Podfile::BASENAME) if tuka_bundle_dir
    end

    def generated_receptor_path
      @generated_receptor_path ||= File.join(DIR, ReceptorBundle::DIR) if tuka_bundle_dir
    end

    def generated_tukafile_path
      @generated_tukafile_path ||= File.join(DIR, Tukafile::BASENAME) if tuka_bundle_dir
    end
  end
end
