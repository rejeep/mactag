module Mactag
  module Indexer
    class Gem
      attr_accessor :name
      attr_writer :version

      def initialize(name, version = nil)
        @name = name
        @version = version
      end

      def tag
        if exist?
          File.join(Mactag::Config.gem_home, combo, 'lib', '**', '*.rb')
        else
          raise GemNotFoundError.new(self)
        end
      end

      def exist?
        dirs.size > 0
      end

      def version
        @version || most_recent
      end

      def most_recent
        unless dirs.empty?
          if dirs.size == 1
            gem = dirs.first
          else
            gem = dirs.sort.last
          end
          regex = /#{escaped_name}-([^\/]+)/

          if match = regex.match(gem)
            match[1]
          end
        end
      end

      def dirs
        @dirs ||= Dir.glob(File.join(Mactag::Config.gem_home, "#{name}-*"))
      end

      class << self
        def all
          gems = Mactag::Bundler.gems
          gems.map do |name, version|
            new(name, version)
          end
        end

        def exist?(name)
          new(name).exist?
        end
      end


      private

      def combo
        "#{name}-#{version}"
      end

      def escaped_name
        Regexp.escape(name)
      end
    end
  end
end
