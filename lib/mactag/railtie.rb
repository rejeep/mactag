module Mactag
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/mactag.rake'
    end
  end
end
