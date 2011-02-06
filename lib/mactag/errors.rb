module Mactag
  class MactagError < StandardError
  end

  class PluginNotFoundError < MactagError
    attr_reader :plugin

    def initialize(plugin)
      @plugin = plugin
    end

    def to_s
      "Plugin #{plugin.name} not found"
    end
  end

  class GemNotFoundError < MactagError
    attr_reader :gem

    def initialize(gem)
      @gem = gem
    end

    def to_s
      if gem.version
        "Gem #{gem.name} with version #{gem.version} not found"
      else
        "Gem #{gem.name} not found"
      end
    end
  end
end
