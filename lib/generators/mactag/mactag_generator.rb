require 'rails/generators'

class MactagGenerator < Rails::Generators::Base
  def install_mactag
    copy_file 'mactag.rb', 'config/mactag.rb'
  end

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end
end
