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

After do
  @app.destroy
end
