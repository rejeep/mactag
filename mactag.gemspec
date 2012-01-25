Gem::Specification.new do |s|
  s.name = 'mactag'
  s.version = '0.6.0'

  s.authors = ['Johan Andersson']
  s.date = '2011-02-06'
  s.description = 'Mactag is a Ctags DSL for Rails'
  s.email = 'johan.rejeep@gmail.com'
  s.extra_rdoc_files = [
    'README.markdown'
  ]
  s.executables = ['mactag']
  s.files = [
    'README.markdown',
    'Rakefile',
    'VERSION',
    'lib/generators/mactag/mactag_generator.rb',
    'lib/generators/mactag/templates/mactag.rb',
    'lib/mactag.rb',
    'lib/mactag/builder.rb',
    'lib/mactag/bundler.rb',
    'lib/mactag/config.rb',
    'lib/mactag/ctags.rb',
    'lib/mactag/dsl.rb',
    'lib/mactag/errors.rb',
    'lib/mactag/railtie.rb',
    'lib/mactag/indexer.rb',
    'lib/mactag/indexer/app.rb',
    'lib/mactag/indexer/gem.rb',
    'lib/mactag/indexer/plugin.rb',
    'lib/mactag/indexer/rails.rb',
    'lib/mactag/indexer/lib.rb',
    'lib/tasks/mactag.rake'
  ]
  s.homepage = 'http://github.com/rejeep/mactag'
  s.require_paths = ['lib']
  s.rubygems_version = '1.5.0'
  s.summary = 'Ctags for Rails'
  s.test_files = [
    'spec/mactag/builder_spec.rb',
    'spec/mactag/bundler_spec.rb',
    'spec/mactag/config_spec.rb',
    'spec/mactag/ctags_spec.rb',
    'spec/mactag/dsl_spec.rb',
    'spec/mactag/indexer/app_spec.rb',
    'spec/mactag/indexer/gem_spec.rb',
    'spec/mactag/indexer/lib_spec.rb',
    'spec/mactag/indexer/plugin_spec.rb',
    'spec/mactag/indexer/rails_spec.rb',
    'spec/mactag_spec.rb',
    'spec/matcher/app.rb',
    'spec/matcher/gem.rb',
    'spec/matcher/lib.rb',
    'spec/matcher/plugin.rb',
    'spec/matcher/rails.rb',
    'spec/matcher.rb',
    'spec/spec_helper.rb'
  ]

  s.add_development_dependency('rspec', ['~> 2.7'])
  s.add_development_dependency('yard')
  s.add_development_dependency('redcarpet')
  s.add_development_dependency('rake')
end

