Given /^rails lives in vendor$/ do
  @app.install_rails_vendor

  # Replaces the path to vendor rails. We can not use "rails" here
  # since when running the rake task rails will try to start by using
  # rails in vendor. But by renaming it to "rails-temp", this will not happen.
  mactag = File.join(@app.rails_root, "vendor", "plugins", "mactag")
  vendor = File.join(mactag, "lib", "mactag", "tag", "rails.rb")
  from = 'VENDOR = File.join("vendor", "rails")'
  to = 'VENDOR = File.join("vendor", "rails-temp")'
  @app.gsub(vendor, from, to)
end

Given /^rails is installed as a gem$/ do
  @app.install_rails_gem
end

Given /^rails version "([^\"]*)" is installed as a gem$/ do |version|
  @app.install_rails_gem(version)
end
