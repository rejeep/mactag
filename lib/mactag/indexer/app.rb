module Mactag
  module Indexer
    class App
      attr_reader :tag

      PATTERNS = ['app/**/*.rb', 'lib/**/*.rb']

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
