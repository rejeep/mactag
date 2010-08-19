module Mactag
  class Config
    ##
    #
    # The command to run when creating the TAGS-file.
    #   Mactag::Config.binary = 'etags -o TAGS'
    #
    @@binary = 'ctags -o TAGS -e'
    cattr_accessor :binary

    ##
    #
    # The system folder where the gems are located.
    #   Mactag::Config.gem_home = '/Library/Ruby/Gems/1.8/gems'
    #
    @@gem_home = '/Library/Ruby/Gems/1.8/gems'
    cattr_writer :gem_home

    def self.gem_home
      if rvm
        File.join(ENV['GEM_HOME'], 'gems')
      else
        @@gem_home
      end
    end

    ##
    #
    # If using Ruby Version Manager (RVM), setting this option to true
    # will enable Mactag to find out the gem path automatically.
    #   Mactag::Config.rvm = false
    #
    @@rvm = true
    cattr_accessor :rvm

    ##
    #
    # File System State Monitor (FSSM) is a feature that can be
    # enabled with Mactag to automatically update tags when files are
    # updates, added or deleted.
    #
    @@fssm = false
    cattr_writer :fssm

    def self.fssm
      @@fssm === true ? '.tags' : @@fssm
    end
  end
end
