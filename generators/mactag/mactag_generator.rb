class MactagGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.directory "config"
      m.template "mactag.rb", File.join("config", "mactag.rb")
    end
  end

end
