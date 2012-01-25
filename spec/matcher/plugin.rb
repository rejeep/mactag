module Matcher
  class PluginIndex
    def initialize(*plugins)
      @plugins = plugins
    end

    def matches?(dsl)
      @tags = dsl.builder.tags
      @actual = @tags.map(&:name)
      @actual - @plugins == @plugins - @actual && all_plugins?
    end

    def failure_message
      "expected '#{@actual.inspect}' to equal '#{@plugins}' but did not"
    end

    def negative_failure_message
      "expected '#{@actual.inspect}' to not equal '#{@plugins}' but did"
    end
    
    
    private
    
    def all_plugins?
      @tags.all? { |tag| tag.is_a?(Mactag::Indexer::Plugin) }
    end
  end

  def have_plugin_index(*plugins)
    PluginIndex.new(*plugins)
  end
end
