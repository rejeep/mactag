module Mactag
  module Indexer
    class Lib
      attr_reader :tag

      PATTERNS = ['lib/**/*.rb']

      def initialize(tag)
        @tag = tag
      end


      class << self
        def all
          PATTERNS.map do |pattern|
            new(pattern)
          end
        end
      end
    end
  end
end
