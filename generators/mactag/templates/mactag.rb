Mactag::Table.generate do
  app "app/**/*.rb", "lib/*.rb"

  plugins "thinking-sphinx", "formtastic"

  gems "paperclip", "authlogic"
  gem "formtastic", :version => "0.9.7"

  rails :except => :actionmailer
  rails :only => [:activerecord, :active_support]
end
