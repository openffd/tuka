# frozen_string_literal: true

module System
  refine Kernel do
    def rm(path)
      system 'rm', path
    end

    def rm_rf(path)
      system 'rm', '-rf', path
    end
  end
end
