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
    # This is the method used to index. Three different things can be
    # indexed: the current project, gems and Rails (which really is a
    # collection of gems).
    #
    # = App
    #
    # App indexes files in the current project.
    #
    # == Examples
    #
    #   Mactag do
    #     # Index single file.
    #     index 'lib/super_duper.rb'
    #
    #     # Index all ruby files in lib, recursive.
    #     index 'lib/**/*.rb'
    #
    #     # Index all helper and model ruby files.
    #     index 'app/helpers/*.rb', 'app/models/*.rb'
    #
    #     # Same as above
    #     index 'app/{models,helpers}/*.rb'
    #   end
    #
    #
    # = Gem
    #
    # Index Ruby gems.
    #
    # == Examples
    #
    #   Mactag do
    #     # Index all gems specified in Gemfile.
    #     index :gems
    #
    #     # Index the gem whenever, latest version.
    #     index 'whenever'
    #
    #     # Index the thinking-sphinx and carrierwave gems, latest versions.
    #     index 'thinking-sphinx', 'carrierwave'
    #
    #     # Index the gem simple_form, version 1.5.2.
    #     index 'simple_form', :version => '1.5.2'
    #   end
    #
    #
    # = Rails
    #
    # Index Rails.
    #
    # == Packages
    #
    # These are the packages that can be indexed. Naming does not
    # matter, so <tt>activerecord</tt> and <tt>active_record</tt> are
    # the same.
    #
    # * actionmailer
    # * actionpack
    # * activemodel
    # * activerecord
    # * activeresource
    # * railties
    # * activesupport
    #
    #
    # == Examples
    #
    #   Mactag do
    #     # Index all packages, same version as application
    #     index :rails
    #
    #     # Index all packages, version 3.1.3
    #     index :rails, :version => '3.1.3'
    #
    #     # Index all packages except activerecord, same version as application
    #     index :rails, :except => :activerecord
    #
    #     # Index only activerecord and actionview, same version as application
    #     index :rails, :only => [:activerecord, :action_view]
    #
    #     # Index all packages except activerecord and actionview,
    #     # same version as application
    #     index :rails, :except => ['activerecord', :action_controller]
    #
    #     # Index all packages except actionmailer, version 3.1.3
    #     index :rails, :except => :actionmailer, :version => '3.1.3'
    #   end
    #
    def index(*args)
      options = args.extract_options!

      if args.first == :app
        app_private
      elsif args.first == :gems
        gem_private
      elsif args.first == :rails
        rails_private(options)
      else
        if options[:version] && args.size > 1
          raise ArgumentError.new('The :version option is not valid when specifying more than one gem')
        end

        args.each do |arg|
          if Mactag::Tag::Gem.exists?(arg)
            gem_private(arg, options)
          else
            app_private(arg)
          end
        end
      end
    end

    ##
    #
    # <b>DEPRECATED:</b> Please use '#index' instead.
    #
    def app(*args)
      $stderr.puts '[DEPRECATION] Please use #index instead of #app.'

      app_private(*args)
    end

    ##
    #
    # <b>DEPRECATED:</b> Please use '#index' instead.
    #
    def gem(*args)
      $stderr.puts '[DEPRECATION] Please use #index instead of #gems.'

      gem_private(*args)
    end
    alias :gems :gem

    ##
    #
    # <b>DEPRECATED:</b> Please use '#index' instead.
    #
    def rails(*args)
      $stderr.puts '[DEPRECATION] Please use #index instead of #rails.'

      rails_private(*args)
    end


    ##
    #
    # <b>DEPRECATED:</b> Please use gems instead.
    #
    # @see Mactag::Tag::Plugin
    #
    def plugin(*plugins)
      $stderr.puts '[DEPRECATION] Please use gems instead of plugins.'

      if plugins.empty?
        @builder << Mactag::Tag::Plugin.all
      else
        plugins.each do |plugin|
          @builder << Mactag::Tag::Plugin.new(plugin)
        end
      end
    end
    alias :plugins :plugin


    private

    def app_private(*tags)
      if tags.empty?
        @builder << Mactag::Tag::App.all
      else
        tags.each do |tag|
          @builder << Mactag::Tag::App.new(tag)
        end
      end
    end

    def gem_private(*gems)
      if gems.empty?
        @builder << Mactag::Tag::Gem.all
      else
        gems.each do |gem|
          @builder << Mactag::Tag::Gem.new(gem)
        end
      end
    end

    def rails_private(options = {})
      if options[:only] && options[:except]
        raise ArgumentError.new('Can not specify options :only and :except at the same time')
      end

      @builder << Mactag::Tag::Rails.new(options)
    end
  end
end
