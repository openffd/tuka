# frozen_string_literal: true

module CoreExtensions
  refine Dir do
    def Dir.xcodeprojs
      Dir[File.join(Dir.pwd, '*.xcodeproj')]
    end
  end
end
