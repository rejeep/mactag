require 'mactag/railtie'
require 'mactag/config'
require 'mactag/builder'
require 'mactag/dsl'
require 'mactag/tag'
require 'mactag/ctags'

module Mactag
  autoload :Bundler, 'bundler'
  autoload :Rails, 'rails'
  autoload :FSSM, 'fssm'

  def self.warn(message)
    STDERR.puts(message)
  end
end

def Mactag(&block)
  Mactag::Builder.generate(&block)
end
