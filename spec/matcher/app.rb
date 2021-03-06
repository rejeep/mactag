module Matcher
  class AppIndex
    def initialize(paths)
      @paths = paths
    end

    def matches?(dsl)
      @tags = dsl.builder.tags
      @actual = @tags.map(&:tag)
      @actual - @paths == @paths - @actual && all_apps?
    end

    def failure_message
      "expected '#{@paths.inspect}' but got '#{@actual.inspect}'"
    end

    def negative_failure_message
      "expected something else then '#{@paths.inspect}' but got '#{@actual.inspect}'"
    end


    private

    def all_apps?
      @tags.all? { |tag| tag.is_a?(Mactag::Indexer::App) }
    end
  end

  def have_app_index(*paths)
    AppIndex.new(paths)
  end
end
