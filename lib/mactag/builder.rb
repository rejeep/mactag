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

    def tags
      tags = all
      tags.flatten!
      tags.compact!
      tags.collect! { |file| File.expand_path(file) }
      tags.collect! { |file| Dir.glob(file) }
      tags.flatten!
      tags.uniq!
      tags
    end

    def all
      @all_tags ||= @tags.collect!(&:tag)
    end

    def gems?
      all.flatten.compact.any?
    end

    def self.create
      unless gem_home_exists?
        Mactag.warn 'Gem home path does not exist on your system'
      end

      if @builder.gems?
        system "cd #{Rails.root} && #{Mactag::Config.binary} #{@builder.tags.join(' ')}"

        puts "Successfully generated TAGS file"
      else
        Mactag.warn 'You did not specify anything to tag'
      end
    end

    def self.generate(&block)
      @builder = Mactag::Builder.new

      dsl = Mactag::Dsl.new(@builder)
      dsl.instance_eval(&block)
    end

    def self.gem_home_exists?
      File.directory?(Mactag::Config.gem_home)
    end
  end
end
