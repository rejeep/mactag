module Mactag
  module Tag
    class Parser

      def initialize(table)
        @table = table
      end

      def app(*files)
        @table << Mactag::Tag::App.new(*files)
      end

      def plugin(*plugins)
        @table << Mactag::Tag::Plugin.new(*plugins)
      end
      alias_method :plugins, :plugin

      def gem(*gems)
        @table << Mactag::Tag::Gem.new(*gems)
      end
      alias_method :gems, :gem

      def rails(options = {})
        @table << Mactag::Tag::Rails.new(options)
      end

    end
  end
end
