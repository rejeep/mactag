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

      def initialize(*gems)
        @options = gems.extract_options!
        @gems = gems.blank? ? ::Rails.configuration.gems.collect(&:name) : gems
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

          File.join(gem, "lib", "**", "*.rb")
        end
      end

    end
  end
end
