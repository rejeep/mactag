task :environment

def load_configuration
  require File.join(Rails.root, 'config', 'mactag')
end

namespace :mactag do
  desc 'Creates a Ctags file'
  task :create => :environment do
    load_configuration

    Mactag::Builder.create
  end

  desc 'Creates a Ctags file'
  task :server => :environment do
    load_configuration

    Mactag::Server.start
  end
end
