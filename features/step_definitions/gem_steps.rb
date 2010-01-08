Given /^the gem "([^\"]*)" version "([^\"]*)" is installed$/ do |gem, version|
  @app.install_gem(gem, version)
end

Given /^an acts as method for the "([^\"]*)" gem$/ do |gem|
  file = File.join("vendor", "gems", gem, "lib", "#{gem}.rb")
  @app.puts file do
    <<-eos
      module #{gem.camelize}
        def self.included(base)
          base.send :extend, ClassMethods
        end

        module ClassMethods
          def acts_as_#{gem}
            # ...
          end
        end
      end
    eos
  end
end
