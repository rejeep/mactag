require 'rails'

module Mactag
  ##
  #
  # Helper class for creating CTags files.
  #
  class Ctags
    def initialize(builder)
      @builder = builder
    end

    ##
    #
    # Creates the tags file. Returns true if anything was tagged,
    # false otherwise.
    #
    def build
      system "cd #{Rails.root} && #{Mactag::Config.binary} #{@builder.tags}"
      @builder.gems?
    end
  end
end
