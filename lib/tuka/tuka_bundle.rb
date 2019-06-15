# frozen_string_literal: true

module Tuka
  module TukaBundle
    def self.dir
      '.tuka'
    end

    def self.previous_dir_names
      ['_tuka']
    end

    def self.tukafile
      'Tukafile'
    end

    def tuka_bundle_dir
      @tuka_bundle_dir ||= Dir[TukaBundle.dir].first
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
      @target_library_path ||= File.join(TukaBundle.dir, tukafile.library.name)
    end

    def target_generated_podfile_path
      @target_generated_podfile_path ||= File.join(TukaBundle.dir, Podfile.basename) if tuka_bundle_dir
    end

    def target_receptor_path
      @target_receptor_path ||= File.join(TukaBundle.dir, Receptor.dir) if tuka_bundle_dir
    end

    private

    def target_tukafile_path
      @target_tukafile_path ||= File.join(TukaBundle.dir, Tukafile::BASENAME) if tuka_bundle_dir
    end
  end
end
