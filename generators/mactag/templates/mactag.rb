Mactag::Table.generate do
  # jQuery only
  app "public/javascripts/jquery.js"
  
  # All ruby files in helpers and models
  app "app/helpers/*.rb", "app/models/*.rb"
  
  # All ruby files in app
  app "app/**/*.rb"
end
