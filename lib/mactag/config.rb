module Mactag
  class Config
    ##
    #
    # The command to run (replacing {OUTPUT} with Mactag::Config.tags_file
    # and {INPUT} with the input files) when creating the TAGS-file.
    #
    #   Mactag::Config.binary = 'etags -o {OUTPUT} {INPUT}'
    #
    @@binary = 'ctags -o {OUTPUT} -e {INPUT}'
    cattr_accessor :binary

    ##
    #
    # Name of the output tags file.
    #
    # Mactag::Config.tags_file = 'TAGS_FILE'
    #
    @@tags_file = 'TAGS'
    cattr_accessor :tags_file

    ##
    #
    # If using Ruby Version Manager (RVM), setting this option to true
    # will enable Mactag to find out the gem path automatically.
    #
    #   Mactag::Config.rvm = false
    #
    @@rvm = true
    cattr_accessor :rvm

    ##
    #
    # The system folder where the gems are located.
    #
    #   Mactag::Config.gem_home = '/Library/Ruby/Gems/1.8/gems'
    #
    @@gem_home = '/Library/Ruby/Gems/1.8/gems'
    cattr_writer :gem_home

    class << self
      def gem_home
        if rvm
          File.join(ENV['GEM_HOME'], 'gems')
        else
          @@gem_home
        end
      end

      def configure(&block)
        yield self
      end
    end
  end
end
