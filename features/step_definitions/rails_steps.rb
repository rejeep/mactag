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

Given /^a rails mactag config with the following tags$/ do |table|
  options = {
    "only"    => [],
    "except"  => [],
    "version" => []
  }

  table.hashes.each do |hash|
    hash.each do |option, value|
      options[option] << value
    end
  end

  if options.values.flatten.empty?
    tags = ""
  else
    tags = []
    options.each do |option, value|
      unless value.empty?
        if value.size == 1
          tags << ":#{option} => #{value.first.quote}"
        else
          values = value.collect(&:quote).join(", ")
          tags << ":#{option} => [#{values}]"
        end
      end
    end

    tags = tags.join(", ")
  end

  @app.puts "config/mactag.rb" do
    <<-eos
      Mactag::Table.generate do
        rails #{tags}
      end
    eos
  end
end

Given /^rails is installed as a gem$/ do
  pending
end

Given /^rails version "([^\"]*)" is installed as a gem$/ do |version|
  pending
end
