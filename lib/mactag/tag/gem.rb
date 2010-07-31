module Mactag
  module Tag
    ##
    #
    # Tags ruby gems.
    #
    # ==== Examples
    #   Mactag::Table.generate do
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
      def initialize(*gems)
        if gems.blank?
          @gems = all
          @options = {}
        else
          @gems = gems
          @options = gems.extract_options!
        end
      end

      def files
        result = []
        @gems.each do |gem_name|
          if version = @options[:version]
            gem = File.join(Mactag::Config.gem_home, "#{gem_name}-#{version}")
          else
            gem = latest(gem_name)
          end

          if exists?(gem)
            result << File.join(gem, "lib", "**", "*.rb")
          else
            Mactag.warn "Gem #{gem_name} not found"
          end
        end
        result
      end


      private

      ##
      #
      # Returns the latest version of +gem+. If only one gem, that gem
      # is returned.
      #
      def latest(gem)
        versions = Dir.glob(File.join(Mactag::Config.gem_home, gem) + "-*")
        if versions.size == 1
          gem = versions.first
        else
          gem = versions.sort.last
        end
        gem
      end

      ##
      #
      # Returns true if +gem+ exists, false otherwise.
      #
      def exists?(gem)
        gem && File.directory?(gem)
      end

      # TODO: Test
      def all
        # ::Rails.configuration.gems.collect(&:name)
      end
    end
  end
end
