module Mactag
  ##
  #
  # Tag builder.
  #
  class Builder
    def initialize
      @tags = []
    end

    def <<(tags)
      @tags += Array(tags)
    end

    def files
      tags = all
      tags.flatten!
      tags.compact!
      tags.collect! { |file| File.expand_path(file) }
      tags.collect! { |file| Dir.glob(file) }
      tags.flatten!
      tags.uniq!
      tags.reject! { |file| File.directory?(file) }
      tags
    end

    def directories
      files.collect { |file| File.dirname(file) }.uniq
    end

    def all
      @all ||= @tags.collect!(&:tag)
    end

    def has_gems?
      all.flatten.compact.any?
    end

    class << self
      def create
        unless gem_home_exists?
          raise Mactag::MactagError.new("Specified gem home directory does not exist: #{Mactag::Config.gem_home}")
        end

        if builder.has_gems?
          Mactag::Ctags.new(@builder.files, Mactag::Config.tags_file).create

          puts "Successfully generated #{Mactag::Config.tags_file} file"
        else
          raise Mactag::MactagError.new('Nothing to tag')
        end
      end

      def generate(&block)
        @builder = Mactag::Builder.new

        dsl = Mactag::Dsl.new(@builder)
        dsl.instance_eval(&block)
      end

      def gem_home_exists?
        File.directory?(Mactag::Config.gem_home)
      end

      def builder
        @builder
      end
    end
  end
end
