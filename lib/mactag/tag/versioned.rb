module Mactag
  module Tag

    # Helper module for Gems (which all have a version).
    module Versioned

      # Returns the latest version of +gem+. If only one gem, that is
      # returned.
      def latest(gem)
        versions = Dir.glob(File.join(Mactag::Config.gem_home, gem) + "-*")
        if versions.size == 1
          gem = versions.first
        else
          gem = versions.sort.last
        end
        gem
      end

    end

  end
end
