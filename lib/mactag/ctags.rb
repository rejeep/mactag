module Mactag
  ##
  #
  # Helper class for creating CTags files.
  #
  class Ctags
    def initialize(builder)
      @builder = builder
    end

    def build
      system "cd #{Rails.root} && #{Mactag::Config.binary} #{@builder.tags.join(' ')}"
      @builder.gems?
    end
  end
end
