Given /^an app mactag config with the following tags$/ do |table|
  tags = table.rows.flatten.collect(&:quote).join(", ")

  @app.puts "config/mactag.rb" do
    <<-eos
      Mactag::Table.generate do
        app #{tags}
      end
    eos
  end
end
