module Mactag
  module Tag
    
    # Tag for the current project plugins.
    #
    # ==== Examples
    #   Mactag::Table.generate do
    #     # Tag the whenever plugin
    #     plugin "whenever"
    #
    #     # Tag the thinking-sphinx and formtastic plugins
    #     plugins "thinking-sphinx", "formtastic"
    #   do
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
