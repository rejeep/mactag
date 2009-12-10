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

Given /^a gem mactag config with the following tags$/ do |table|
  if version = table.hashes.first["version"]
    tags = "#{table.hashes.first["tag"].quote}, :version => #{version.quote}"
  else
    tags = table.rows.flatten.collect(&:quote).join(", ")
  end

  @app.puts "config/mactag.rb" do
    <<-eos
      Mactag::Config.gem_home = File.join("vendor", "gems")

      Mactag::Table.generate do
        gems #{tags}
      end
    eos
  end
end
