module Mactag
  module Tag
    class Gem

      def initialize(*gems)
        @options = gems.extract_options!
        @gems = gems
      end

      def files
        @gems.collect do |gem|
          if version = @options[:version]
            gem = File.join(Mactag::Config.gem_home, "#{gem}-#{version}")
          else
            versions = Dir.glob(File.join(Mactag::Config.gem_home, "#{gem}*"))
            if versions.size == 1
              gem = versions.first
            else
              gem = versions.sort.last
            end
          end

          File.join(gem, "**", "*.rb")
        end
      end

    end
  end
end
