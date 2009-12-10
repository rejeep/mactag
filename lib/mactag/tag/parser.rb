module Mactag
  module Tag
    class Parser
      
      def initialize(table)
        @table = table
      end
      
      def app(*files)
        @table << Mactag::Tag::App.new(*files)
      end

    end
  end
end
