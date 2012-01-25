module Matcher
  class LibIndex
    def initialize(paths)
      @paths = paths
    end

    def matches?(dsl)
      @tags = dsl.builder.tags
      @actual = @tags.map(&:tag)
      @actual - @paths == @paths - @actual
    end

    def failure_message
      "expected '#{@paths.inspect}' but got '#{@actual.inspect}'"
    end

    def negative_failure_message
      "expected something else then '#{@paths.inspect}' but got '#{@actual.inspect}'"
    end
    
    private

    def all_libs?
      @tags.all? { |tag| tag.is_a?(Mactag::Indexer::Lib) }
    end
  end

  def have_lib_index(*paths)
    LibIndex.new(paths)
  end
end
