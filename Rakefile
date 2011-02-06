require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.libs << 'lib'
  t.libs << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
end

task :default => :spec
task :test => :spec
