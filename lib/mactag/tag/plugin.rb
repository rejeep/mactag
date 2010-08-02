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
        if exists?
          return File.join(PLUGIN_PATH, @plugin, 'lib', '**', '*.rb')
        else
          Mactag.warn "Plugin #{@plugin} not found"
        end
      end
      
      def exists?
        File.directory?(File.join(PLUGIN_PATH, @plugin))
      end
      
      def self.all
        Dir.glob(File.join(PLUGIN_PATH, '*')).collect { |f| File.basename(f) }
      end
    end
  end
end
