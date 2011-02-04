require 'rake'
require 'rake/testtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'mactag'
    gemspec.summary = 'Ctags for Rails'
    gemspec.description = 'Mactag is a Ctags DSL for Rails'
    gemspec.email = 'johan.rejeep@gmail.com'
    gemspec.homepage = 'http://github.com/rejeep/mactag'
    gemspec.authors = ['Johan Andersson']
    gemspec.files = FileList['lib/**/*.rb',
                             'LICENCE',
                             'README.markdown',
                             'lib/tasks/*.rake',
                             'VERSION',
                             'Rakefile',
                             '.gemtest']
    gemspec.test_files = FileList['spec/**/*_spec.rb']

    gemspec.add_runtime_dependency('rails', ['>= 3.0.0.beta1'])
    gemspec.add_development_dependency('rspec', ['>= 2.0.0.beta.19'])
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler not available. Install it with: sudo gem install jeweler'
end

Rake::TestTask.new(:spec) do |t|
  t.libs << 'lib'
  t.libs << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
end

task :default => :spec
task :test => :spec
