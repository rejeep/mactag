module Mactag
  ##
  #
  # Parser for builder.
  #
  class Parser
    def initialize(builder)
      @builder = builder
    end

    ##
    #
    # @see Mactag::Tag::App
    #
    def app(*tags)
      tags.each do |tag|
        @builder << Mactag::Tag::App.new(tag)
      end
    end

    ##
    #
    # @see Mactag::Tag::Plugin
    #
    def plugin(*plugins)
      if plugins.empty?
        plugins = Mactag::Tag::Plugin.all
      end

      plugins.each do |plugin|
        @builder << Mactag::Tag::Plugin.new(plugin)
      end
    end
    alias_method :plugins, :plugin

    ##
    #
    # @see Mactag::Tag::Gem
    #
    def gem(*gems)
      options = gems.extract_options!

      if gems.empty?
        @builder << Mactag::Tag::Gem.all
      else
        gems.each do |name|
          @builder << Mactag::Tag::Gem.new(name, options[:version])
        end
      end
    end
    alias_method :gems, :gem

    ##
    #
    # @see Mactag::Tag::Rails
    #
    def rails(options = {})
      @builder << Mactag::Tag::Rails.new(options)
    end
  end
end
