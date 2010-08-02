require 'mactag/config'
require 'mactag/builder'
require 'mactag/parser'
require 'mactag/tag'

module Mactag
  def self.warn(message)
    $stderr.puts "Mactag Warning: #{message}"
  end
end
