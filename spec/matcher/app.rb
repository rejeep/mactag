module Matcher
  class AppIndex
    def initialize(paths)
      @paths = paths
    end

    def matches?(dsl)
      @actual = dsl.builder.tags.map(&:tag)

      @actual - @paths == @paths - @actual
    end

    def failure_message
      "expected '#{@paths.inspect}' but got '#{@actual.inspect}'"
    end

    def negative_failure_message
      "expected something else then '#{@paths.inspect}' but got '#{@actual.inspect}'"
    end
  end

  def have_app_index(*paths)
    AppIndex.new(paths)
  end
end
