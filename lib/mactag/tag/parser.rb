module Mactag
  module Tag
    class Parser
      def initialize(table)
        @table = table
      end

      ##
      #
      # @see Mactag::Tag::App
      #
      def app(*files)
        files.each do |file|
          @table << Mactag::Tag::App.new(file)
        end
      end

      ##
      #
      # @see Mactag::Tag::Plugin
      #
      def plugin(*plugins)
        @table << Mactag::Tag::Plugin.new(*plugins)
      end
      alias_method :plugins, :plugin

      ##
      #
      # @see Mactag::Tag::Gem
      #
      def gem(*gems)
        @table << Mactag::Tag::Gem.new(*gems)
      end
      alias_method :gems, :gem

      ##
      #
      # @see Mactag::Tag::Rails
      #
      def rails(options = {})
        @table << Mactag::Tag::Rails.new(options)
      end
    end
  end
end
