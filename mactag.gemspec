Gem::Specification.new do |s|
  s.name = 'mactag'
  s.version = '0.5.4'

  s.authors = ['Johan Andersson']
  s.date = '2011-02-06'
  s.description = 'Mactag is a Ctags DSL for Rails'
  s.email = 'johan.rejeep@gmail.com'
  s.extra_rdoc_files = [
    'README.markdown'
  ]
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
    'lib/mactag/tag.rb',
    'lib/mactag/tag/app.rb',
    'lib/mactag/tag/gem.rb',
    'lib/mactag/tag/plugin.rb',
    'lib/mactag/tag/rails.rb',
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
    'spec/mactag/tag/app_spec.rb',
    'spec/mactag/tag/gem_spec.rb',
    'spec/mactag/tag/plugin_spec.rb',
    'spec/mactag/tag/rails_spec.rb',
    'spec/mactag/tag_spec.rb',
    'spec/mactag_spec.rb',
    'spec/spec_helper.rb'
  ]

  s.add_runtime_dependency('rails', ['>= 3.0.0'])
  s.add_development_dependency('rspec', ['~> 2.7'])
  s.add_development_dependency('yard')
  s.add_development_dependency('redcarpet')
end

