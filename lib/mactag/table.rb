module Mactag
  class Table

    @@tags = []

    class << self
      def generate(&block)
        parser = Mactag::Tag::Parser.new(self)
        parser.instance_eval(&block)
      end

      def <<(tag)
        @@tags << tag
      end

      def tags
        @@tags.collect(&:files).flatten.collect { |file| File.expand_path(file) }.join(' ')
      end
    end

  end
end
