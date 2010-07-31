module Mactag
  class Config
    ##
    #
    # The command to run when creating the TAGS-file.
    #   Mactag::Config.binary = "etags -o TAGS"
    #
    @@binary = "ctags -o TAGS -e"
    cattr_accessor :binary

    ##
    #
    # The system folder where the gems are located.
    #   Mactag::Config.gem_home = "/Library/Ruby/Gems/1.8/gems"
    #
    @@gem_home = "/Library/Ruby/Gems/1.8/gems"
    cattr_accessor :gem_home
  end
end
