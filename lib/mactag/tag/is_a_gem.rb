module Mactag
  module Tag
    ##
    #
    # Helper module for ruby gems.
    #
    module IsAGem
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
      
      def exists?(gem)
        File.directory?(gem)
      end
    end
  end
end
