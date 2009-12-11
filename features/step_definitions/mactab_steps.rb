Given /^a Rails application$/ do
  @app = RailsApp.new
end

Given /^mactag is installed$/ do
  mactag = File.join(@app.rails_root, "vendor", "plugins", "mactag")

  FileUtils.mkdir_p(mactag)

  [ "lib", "tasks", "Rakefile", "init.rb" ].each do |name|
    file = File.join(File.dirname(__FILE__), "..", "..", name)

    FileUtils.cp_r(file, mactag)
  end
  
  # Replaces the path to vendor rails. We can not use "rails" here
  # since when running the rake task rails will try to start by using
  # rails in vendor. But by renaming it to "rails-temp", this will not happen.
  vendor = File.join(mactag, "lib", "mactag", "tag", "rails.rb")
  from = 'VENDOR = File.join("vendor", "rails")'
  to = 'VENDOR = File.join("vendor", "rails-temp")'
  @app.gsub(vendor, from, to)
end

Given /^a javascript function "([^\"]*)" in "([^\"]*)"$/ do |function, file|
  @app.puts "public/javascripts/#{file}.js" do
    <<-eos
      function #{function}() {
        // ...
      }
    eos
  end
end

Given /^a ruby method "([^\"]*)" in the "([^\"]*)" model$/ do |method, model|
  @app.puts "app/models/#{model}.rb" do
    <<-eos
      class #{model.camelize}
        def #{method}
          # ...
        end
      end
    eos
  end
end

When /^I create the tags file$/ do
  @tags = TagsFile.new(@app)
end

Then /^the tags file should contain "([^\"]*)"$/ do |tag|
  assert @tags.contain?(tag)
end
  
Then /^the tags file should not contain "([^\"]*)"$/ do |tag|
  assert !@tags.contain?(tag)
end

After do
  @app.destroy
end
