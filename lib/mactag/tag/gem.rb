module Mactag
  module Tag
    ##
    #
    # Tags ruby gems.
    #
    # ==== Examples
    #   Mactag do
    #     # Tags all gems specified in Gemfile.
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
          Mactag.warn "Gem #{@version ? splash : @name} not found"
        end
      end

      ##
      #
      # Returns all application gems in Bundler default group.
      #
      def self.all
        gems = {}
        Bundler.load.specs.each do |spec|
          gems[spec.name] = spec.version.to_s
        end

        default = Bundler.load.dependencies.select { |dependency| dependency.groups.include?(:default) }.collect(&:name)
        default.delete('rails')
        default.collect { |tmp| Gem.new(tmp, gems[tmp]) }
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
