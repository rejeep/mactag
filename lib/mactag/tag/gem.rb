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
      attr_accessor :name, :version

      def initialize(name, version = nil)
        @name = name
        @version = version
      end

      def tag
        if exists?
          unless version
            @version = Mactag::Tag::Gem.last(name)
          end

          File.join(Mactag::Config.gem_home, combo, 'lib', '**', '*.rb')
        else
          raise GemNotFoundError.new(self)
        end
      end

      def exists?
        Mactag::Tag::Gem.dirs(name).size > 0
      end

      class << self
        def all
          # Mactag::Bundler.gems
          bundler = Mactag::Bundler.new
          bundler.gems
        end

        def last(name)
          dirs = Mactag::Tag::Gem.dirs(name)
          unless dirs.empty?
            if dirs.size == 1
              gem = dirs.first
            else
              gem = dirs.sort.last
            end
            if /-([^\/]+)$/.match(gem)
              $1
            end
          end
        end

        def dirs(name)
          Dir.glob(File.join(Mactag::Config.gem_home, "#{name}-*"))
        end
      end


      private

      def combo
        "#{name}-#{version}"
      end
    end
  end
end
