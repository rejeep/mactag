Given /^a Rails application$/ do
  @app = RailsApp.new
end

Given /^mactag is installed$/ do
  mactag = File.join(@app.root, "vendor", "plugins", "mactag")

  FileUtils.mkdir_p(mactag)

  [ "lib", "Rakefile", "init.rb" ].each do |file|
    file = File.join(File.dirname(__FILE__), "..", "..", file)

    FileUtils.cp_r(file, mactag)
  end
end

Given /^this mactag config file:$/ do |config|
  @app.inject "config/mactag.rb", config
end

When /^I create the tags file$/ do
  @tags = TagsFile.new(@app)
end

Then /^"([^"]*)" should be tagged$/ do |definition|
  assert @tags.include?(definition)
end
Given /^file "([^"]*)" with contents:$/ do |file, contents|
  @app.inject file, contents
end
