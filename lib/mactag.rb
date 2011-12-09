require 'mactag/railtie'
require 'mactag/config'
require 'mactag/builder'
require 'mactag/dsl'
require 'mactag/tag'
require 'mactag/ctags'
require 'mactag/bundler'
require 'mactag/errors'

module Mactag
  autoload :Bundler, 'bundler'
  autoload :Rails, 'rails'

  class << self
    def configure(&block)
      Mactag::Config.configure(&block)
    end
  end
end

def Mactag(&block)
  Mactag::Builder.generate(&block)
end
