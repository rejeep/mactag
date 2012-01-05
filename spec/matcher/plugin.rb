module Matcher
  class PluginIndex
    def initialize(*plugins)
      @plugins = plugins
    end

    def matches?(dsl)
      @actual = dsl.builder.tags.map(&:name)

      @actual - @plugins == @plugins - @actual
    end

    def failure_message
      "expected '#{@actual.inspect}' to equal '#{@plugins}' but did not"
    end

    def negative_failure_message
      "expected '#{@actual.inspect}' to not equal '#{@plugins}' but did"
    end
  end

  def have_plugin_index(*plugins)
    PluginIndex.new(*plugins)
  end
end
