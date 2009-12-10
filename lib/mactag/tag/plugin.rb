module Mactag
  module Tag
    class Plugin
      
      PLUGIN_PATH = File.join("vendor", "plugins")
      
      def initialize(*plugins)
        @plugins = plugins
      end
      
      def files
        return File.join(PLUGIN_PATH, "*", "**", "*.rb") if @plugins.empty?

        @plugins.collect do |plugin|
          File.join(PLUGIN_PATH, plugin, "**", "*.rb")
        end
      end
      
    end
  end
end
