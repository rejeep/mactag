module Mactag
  class Table
    @@tags = []

    class << self
      ##
      #
      # Generates the TAGS-table.
      #
      # ==== Example
      #   Mactag::Table.generate do
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
      def generate(&block)
        parser = Mactag::Tag::Parser.new(self)
        parser.instance_eval(&block)
      end

      ##
      #
      # Add +tag+ to list of tags.
      #
      def <<(tag)
        @@tags << tag
      end

      ##
      #
      # Returns a string with all files that should be tagged. The
      # files are separated with a whitespace.
      #
      def tags
        @@tags.collect!(&:tag)
        @@tags.collect! { |file| File.expand_path(file) }
        @@tags.collect! { |file| Dir.glob(file) }
        @@tags.uniq!
        @@tags.join(' ')
      end

      ##
      #
      # Create the TAGS file.
      #
      def create
        unless File.directory?(Mactag::Config.gem_home)
          Mactag.warn 'Gem home path does not exist on your system'
        end

        if @@tags.collect(&:files).flatten.empty?
          Mactag.warn 'You did not specify anything to tag'
        else
          system "cd #{Rails.root} && #{Mactag::Config.binary} #{Mactag::Table.tags}"
          puts "Successfully generated TAGS file"
        end
      end
    end
  end
end
