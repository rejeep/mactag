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
