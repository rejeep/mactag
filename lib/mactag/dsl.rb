module Mactag
  ##
  #
  # Mactag DSL.
  #
  class Dsl
    def initialize(builder)
      @builder = builder
    end

    ##
    #
    # @see Mactag::Tag::App
    #
    def app(*tags)
      if tags.empty?
        raise ArgumentError.new('App requires at least one argument')
      end

      tags.each do |tag|
        @builder << Mactag::Tag::App.new(tag)
      end
    end

    ##
    #
    # <b>DEPRECATED:</b> Please use gems instead.
    #
    # @see Mactag::Tag::Plugin
    #
    def plugin(*plugins)
      warn '[DEPRECATION] Please use gem instead of plugins.'

      if plugins.empty?
        plugins = Mactag::Tag::Plugin.all
      end

      plugins.each do |plugin|
        @builder << Mactag::Tag::Plugin.new(plugin)
      end
    end
    alias :plugins :plugin

    ##
    #
    # @see Mactag::Tag::Gem
    #
    def gem(*gems)
      options = gems.extract_options!

      if options[:version] && gems.size > 1
        raise ArgumentError.new('The :version option is not valid when specifying more than one gem')
      end

      if gems.empty?
        @builder << Mactag::Tag::Gem.all
      else
        gems.each do |gem|
          @builder << Mactag::Tag::Gem.new(gem, options[:version])
        end
      end
    end
    alias :gems :gem

    ##
    #
    # @see Mactag::Tag::Rails
    #
    def rails(options = {})
      if options[:only] && options[:except]
        raise ArgumentError.new('Can not specify options :only and :except at the same time')
      end

      @builder << Mactag::Tag::Rails.new(options)
    end
  end
end
