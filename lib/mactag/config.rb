module Mactag
  # Configuration options.
  #
  # ==== Binary
  # The command to run when creating the TAGS-file.
  #   Mactag::Config.binary = "etags -o TAGS"
  #
  # ==== Gem Home
  # The folder where the gems are stored.
  #   Mactag::Config.gem_home = "/Library/Ruby/Gems/1.8/gems"
  class Config

    @@binary = "ctags -o TAGS -e"
    cattr_accessor :binary
    
    @@gem_home = "/Library/Ruby/Gems/1.8/gems"
    cattr_accessor :gem_home

  end
end
