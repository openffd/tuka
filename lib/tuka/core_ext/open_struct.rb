# frozen_string_literal: true

module CoreExtensions
  refine OpenStruct do
    def as_hash(some_hash = {})
      each_pair do |key, value|
        some_hash[key] = value.is_a?(OpenStruct) ? value.as_hash : value
      end
      some_hash
    end
  end
end
