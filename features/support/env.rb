require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'active_support/core_ext'
require 'test/unit/assertions'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'mactag'

World(Test::Unit::Assertions)

After do
  @app.destroy
end
