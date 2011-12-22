module Mactag
  module Tag
    class App
      PATTERNS = ['app/**/*.rb', 'lib/**/*.rb']
      
      attr_reader :tag

      def initialize(tag)
        @tag = tag
      end

      def self.all
        PATTERNS.map do |pattern|
          Mactag::Tag::App.new(pattern)
        end
      end
    end
  end
end
