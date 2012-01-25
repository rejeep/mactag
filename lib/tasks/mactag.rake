task :environment

desc 'Creates a Ctags file'
task :mactag => :environment do
  require File.join(Mactag.project_root, 'config', 'mactag')

  Mactag::Builder.create
end
