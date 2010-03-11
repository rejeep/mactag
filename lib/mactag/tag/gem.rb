require 'mactag/tag/versioned'


module Mactag
  module Tag

    # Tag for gems.
    #
    # ==== Examples
    #   Mactag::Table.generate do
    #     # Tag all gems given by *Rails.configuration.gems*
    #     gems
    #
    #     # Tag the whenever gem, latest version
    #     gem "whenever"
    #
    #     # Tag the thinking-sphinx and formtastic gems, latest versions
    #     gems "thinking-sphinx", "formtastic"
    #
    #     # Tag the formtastic gem version 0.8.2
    #     gem "formtastic", :version => "0.8.2"
    #   do
    class Gem

      include Versioned

      def initialize(*gems)
        @options = gems.extract_options!
        @gems = gems.blank? ? ::Rails.configuration.gems.collect(&:name) : gems
      end

      def files
        result = []
        @gems.each do |gem_name|
          if version = @options[:version]
            gem = File.join(Mactag::Config.gem_home, "#{gem_name}-#{version}")
          else
            gem = latest(gem_name)
          end

          if gem
            result << File.join(gem, "lib", "**", "*.rb")
          else
            $stderr.puts "Gem #{gem_name} not found"
          end
        end
        result
      end

    end
  end
end
