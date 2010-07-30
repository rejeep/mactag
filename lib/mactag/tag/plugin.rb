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

      def initialize(*plugins)
        @plugins = plugins
      end

      def files
        return File.join(PLUGIN_PATH, '*', 'lib', '**', '*.rb') if @plugins.empty?

        result = []
        @plugins.each do |plugin|
          if File.exist?(File.join(PLUGIN_PATH, plugin))
            result << File.join(PLUGIN_PATH, plugin, 'lib', '**', '*.rb')
          else
            Mactag.warn "Plugin #{plugin} not found"
          end
        end
        result
      end
    end
  end
end
