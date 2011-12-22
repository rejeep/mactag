module Mactag
  class Config
    ##
    #
    # The command to run (replacing <tt>{OUTPUT}</tt> with <tt>tags_file</tt>
    # and <tt>{INPUT}</tt> with the input files) when creating the tags file.
    #
    @@binary = 'ctags -o {OUTPUT} -e {INPUT}'
    cattr_accessor :binary

    ##
    #
    # Name of the output tags file.
    #
    @@tags_file = 'TAGS'
    cattr_accessor :tags_file

    ##
    #
    # If using Ruby Version Manager (RVM), setting this option to true
    # will enable Mactag to find out the gem path automatically.
    #
    @@rvm = true
    cattr_accessor :rvm

    ##
    #
    # The system folder where the gems are located.
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
