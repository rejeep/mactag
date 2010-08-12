require 'mactag/railtie'
require 'mactag/config'
require 'mactag/builder'
require 'mactag/dsl'
require 'mactag/ctags'
require 'mactag/tag'

module Mactag
  autoload :Bundler, 'bundler'
  autoload :Rails, 'rails'

  def self.warn(message)
    $stderr.puts(message)
  end
end

def Mactag(&block)
  Mactag::Builder.generate(&block)
end
