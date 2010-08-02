module Mactag
  module Tag
    ##
    #
    # Tags ruby gems.
    #
    # ==== Examples
    #   Mactag do
    #     # Tag all gems given by *...*
    #     gems
    #
    #     # Tag the whenever gem, latest version
    #     gem 'whenever'
    #
    #     # Tag the thinking-sphinx and formtastic gems, latest versions
    #     gems 'thinking-sphinx', 'formtastic'
    #
    #     # Tag the formtastic gem, version 0.8.2
    #     gem 'formtastic', :version => '0.8.2'
    #   do
    #
    class Gem
      autoload :Bundler, 'bundler'

      def initialize(name, version = nil)
        @name = name
        @version = version
      end

      def tag
        if exists?
          if @version
            gem = splash
          else
            gem = Gem.most_recent(@name)
          end
          File.join(Mactag::Config.gem_home, gem, 'lib', '**', '*.rb')
        else
          Mactag.warn "Gem #{@name} not found"
        end
      end

      ##
      #
      # Returns all application gems.
      #
      def self.all
        Bundler.load.specs.collect { |spec| Gem.new(spec.name, spec.version.to_s) }
      end

      ##
      #
      # Returns the most recent gem with +name+.
      #
      def self.most_recent(name)
        versions = Dir.glob(File.join(Mactag::Config.gem_home, name) + "-*")
        unless versions.empty?
          if versions.size == 1
            gem = versions.first
          else
            gem = versions.sort.last
          end
          File.basename(gem)
        end
      end


      private

      ##
      #
      # Returns true if +gem+ exists, false otherwise.
      #
      def exists?
        if @version
          File.directory?(File.join(Mactag::Config.gem_home, splash))
        else
          Gem.most_recent(@name)
        end
      end

      ##
      #
      # Returns the gem name, dash, version.
      #
      def splash
        "#{@name}-#{@version}"
      end
    end
  end
end
