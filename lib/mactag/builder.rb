module Mactag
  class Builder
    def initialize
      @tags = []
    end

    ##
    #
    # Add +tag+ to list of tags.
    #
    def <<(tags)
      @tags += Array(tags)
    end

    ##
    #
    # Returns a string with all files that should be tagged. The
    # files are separated with a whitespace.
    #
    def tags
      tags = all
      tags.flatten!
      tags.compact!
      tags.collect! { |file| File.expand_path(file) }
      tags.collect! { |file| Dir.glob(file) }
      tags.uniq!
      tags.join(' ')
    end

    def all
      @all_tags ||= @tags.collect!(&:tag)
    end

    def gems?
      all.flatten.compact.any?
    end

    ##
    #
    # Create the TAGS file.
    #
    def self.create
      unless gem_home_exists?
        Mactag.warn 'Gem home path does not exist on your system'
      end

      tags = Mactag::Ctags.new(@builder)
      if tags.build
        puts "Successfully generated TAGS file"
      else
        Mactag.warn 'You did not specify anything to tag'
      end
    end

    ##
    #
    # Generates the TAGS-table.
    #
    # ==== Example
    #   Mactag::Builder.generate do
    #     app 'app/**/*.rb', 'lib/*.rb'
    #
    #     plugins 'thinking-sphinx', 'whenever'
    #
    #     gems 'paperclip', 'authlogic'
    #     gem 'formtastic', :version => '0.9.7'
    #
    #     rails :except => :actionmailer, :version => '2.3.5'
    #   end
    #
    # See documentation for the methods *app*, *plugins*, *gems* and
    # *rails* in respective tag class.
    #
    def self.generate(&block)
      @builder = Mactag::Builder.new

      parser = Mactag::Parser.new(@builder)
      parser.instance_eval(&block)
    end

    ##
    #
    # Returns true if the specified gem home path exists on the
    # system, false otherwise.
    #
    def self.gem_home_exists?
      File.directory?(Mactag::Config.gem_home)
    end
  end
end
