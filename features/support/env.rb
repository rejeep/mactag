require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'active_support/core_ext'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')

require 'mactag'
require 'test/unit/assertions'

World(Test::Unit::Assertions)
