module Matcher
  class GemIndex
    def initialize(name, version)
      @name = name
      @version = version
    end

    def matches?(dsl)
      @actual = dsl.builder.tags
      @actual.find do |gem|
        gem.name == @name && gem.version == @version
      end
    end

    def failure_message
      "expected '#{@actual.inspect}' to include '#{@name}/#{@version}' but did not"
    end

    def negative_failure_message
      "expected '#{@actual.inspect}' to not include '#{@name}/#{@version}' but did"
    end
  end

  def have_gem_index(name, version = nil)
    GemIndex.new(name, version)
  end
end
