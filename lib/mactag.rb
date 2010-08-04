require 'rails'

require 'mactag/railtie'
require 'mactag/config'
require 'mactag/builder'
require 'mactag/dsl'
require 'mactag/ctags'
require 'mactag/tag'

module Mactag
  def self.warn(message)
    $stderr.puts "Mactag Warning: #{message}"
  end
end

def Mactag(&block)
  Mactag::Builder.generate(&block)
end
