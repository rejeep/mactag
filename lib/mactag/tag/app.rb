module Mactag
  module Tag
    class App
      
      attr_reader :files
      
      def initialize(*files)
        @files = files
      end
      
    end
  end
end
