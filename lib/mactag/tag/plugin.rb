module Mactag
  module Tag
    ##
    #
    # Tags plugins in current Rails application.
    #
    # ==== Examples
    #   Mactag::Table.generate do
    #     # Tag single plugin
    #     plugin 'whenever'
    #
    #     # Tag multiple plugins
    #     plugins 'thinking-sphinx', 'formtastic'
    #
    #     # Tag all plugins
    #     plugins
    #   do
    #
    class Plugin
      PLUGIN_PATH = File.join('vendor', 'plugins')

      def initialize(plugin)
        @plugin = plugin
      end

      def tag
        if File.directory?(File.join(PLUGIN_PATH, @plugin))
          return File.join(PLUGIN_PATH, @plugin, 'lib', '**', '*.rb')
        else
          Mactag.warn "Plugin #{@plugin} not found"
        end
      end
    end
  end
end
