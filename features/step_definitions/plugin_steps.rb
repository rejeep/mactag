Given /^the plugin "([^\"]*)" is installed$/ do |plugin|
  @app.install_plugin(plugin)
end

Given /^an acts as method for the "([^\"]*)" plugin$/ do |plugin|
  file = File.join("vendor", "plugins", plugin, "lib", "#{plugin}.rb")
  @app.puts file do
    <<-eos
      module #{plugin.camelize}
        def self.included(base)
          base.send :extend, ClassMethods
        end

        module ClassMethods
          def acts_as_#{plugin}
            # ...
          end
        end
      end
    eos
  end
end
