require 'rake'
require 'yard'
require 'rspec/core/rake_task'

task :default => :spec
task :test => :spec

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
end
