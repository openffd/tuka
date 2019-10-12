# frozen_string_literal: true

module CoreExtensions
  module SubCommand
    refine Array do
      def as_same_keyval_hash
        Hash[map(&:to_sym).zip(self)]
      end
    end
  end
end
