module Mactag
  module Tag
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
