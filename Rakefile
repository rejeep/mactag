require 'rake'
require 'rake/testtask'
require 'bundler'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'mactag'
    gemspec.summary = 'Ctags for Rails'
    gemspec.description = 'Mactag is DSL in ruby for creating a Ctags-file for Rails projects'
    gemspec.email = 'johan.rejeep@gmail.com'
    gemspec.homepage = 'http://github.com/rejeep/mactag'
    gemspec.authors = ['Johan Andersson']
    gemspec.files = FileList[
                             'lib/**/*.rb',
                             'LICENCE',
                             'README.markdown',
                             'lib/tasks/*.rake',
                             'lib/generators/**/*.rb',
                             'VERSION'
                            ]
    gemspec.test_files = FileList['test/**/*_test.rb']
    
    gemspec.add_runtime_dependency("rails", [">= 3.0.0.beta1"])
    gemspec.add_runtime_dependency("bundler", [">= 0.9.26"])
    
    gemspec.add_development_dependency("shoulda", [">= 2.11.1"])
    gemspec.add_development_dependency("mocha", [">= 0.9.8"])
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :default => :test
