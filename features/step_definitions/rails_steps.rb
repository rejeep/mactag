Given /^rails lives in vendor$/ do
  @app.install_rails
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
