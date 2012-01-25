module Mactag
  ##
  #
  # Mactag DSL.
  #
  class Dsl
    attr_reader :builder

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
      if args.first == :app
        app_private
      elsif args.first == :gems
        gem_private
      elsif args.first == :rails
        rails_private(*args)
      else
        options = args.last

        if options.is_a?(Hash) && options[:version] && args.size > 2
          raise ArgumentError.new('The :version option is not valid when specifying more than one gem')
        end

        if options.is_a?(Hash) || args.all? { |arg| Mactag::Indexer::Gem.exist?(arg) }
          gem_private(*args)
        else
          app_private(*args)
        end
      end
    end

    ##
    #
    # <b>DEPRECATED:</b> Please use '#index' instead.
    #
    def app(*args)
      $stderr.puts '[DEPRECATION] Please use #index instead of #app.'

      if args.empty?
        index(:app)
      else
        index(*args)
      end
    end

    ##
    #
    # <b>DEPRECATED:</b> Please use '#index' instead.
    #
    def gem(*args)
      $stderr.puts '[DEPRECATION] Please use #index instead of #gems.'

      if args.empty?
        index(:gems)
      else
        index(*args)
      end
    end
    alias :gems :gem

    ##
    #
    # <b>DEPRECATED:</b> Please use '#index' instead.
    #
    def rails(*args)
      $stderr.puts '[DEPRECATION] Please use #index instead of #rails.'

      if args.empty?
        index(:rails)
      else
        index(*args)
      end
    end


    ##
    #
    # <b>DEPRECATED:</b> Please use gems instead.
    #
    # @see Mactag::Indexer::Plugin
    #
    def plugin(*plugins)
      $stderr.puts '[DEPRECATION] Please use gems instead of plugins.'

      plugin_private(*plugins)
    end
    alias :plugins :plugin


    private

    def app_private(*tags)
      if tags.empty?
        @builder << Mactag::Indexer::App.all
      else
        tags.each do |tag|
          @builder << Mactag::Indexer::App.new(tag)
        end
      end
    end

    def gem_private(*args)
      if args.empty?
        @builder << Mactag::Indexer::Gem.all
      else
        options = args.last

        if options.is_a?(Hash) && options[:version]
          @builder << Mactag::Indexer::Gem.new(args.first, options[:version])
        else
          args.each do |arg|
            @builder << Mactag::Indexer::Gem.new(arg)
          end
        end
      end
    end

    def rails_private(*args)
      args.shift

      if args.size.zero?
        options = {}
      else
        options = args.first
      end

      if options[:only] && options[:except]
        raise ArgumentError.new('Can not specify options :only and :except at the same time')
      end

      @builder << Mactag::Indexer::Rails.new(options)
    end

    def plugin_private(*plugins)
      if plugins.empty?
        @builder << Mactag::Indexer::Plugin.all
      else
        plugins.each do |plugin|
          @builder << Mactag::Indexer::Plugin.new(plugin)
        end
      end
    end
  end
end
