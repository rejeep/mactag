module Mactag
  module Tag
    class Gem
      attr_accessor :name
      attr_writer :version

      def initialize(name, version = nil)
        @name = name
        @version = version
      end

      def tag
        if exists?
          File.join(Mactag::Config.gem_home, combo, 'lib', '**', '*.rb')
        else
          raise GemNotFoundError.new(self)
        end
      end

      def exists?
        dirs.size > 0
      end

      def most_recent
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

      def dirs
        @dirs ||= Dir.glob(File.join(Mactag::Config.gem_home, "#{name}-*"))
      end

      def version
        @version || most_recent
      end

      class << self
        def all
          gems = Mactag::Bundler.gems
          gems.map do |name, version|
            Mactag::Tag::Gem.new(name, version)
          end
        end

        def exists?(name)
          new(name).exists?
        end
      end


      private

      def combo
        "#{name}-#{version}"
      end
    end
  end
end
