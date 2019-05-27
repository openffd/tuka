# frozen_string_literal: true

module CoreExtensions
  refine Kernel do
    def print_newline
      puts "\n"
    end
  end
end
