require 'mactag/config'
require 'mactag/builder'
require 'mactag/dsl'
require 'mactag/indexer'
require 'mactag/ctags'
require 'mactag/bundler'
require 'mactag/errors'

module Mactag
  class << self
    def configure(&block)
      Mactag::Config.configure(&block)
    end

    def rails_app?
      defined?(::Rails)
    end

    def rails_version
      if rails_app?
        ::Rails.version
      end
    end

    def project_root
      if rails_app?
        ::Rails.root
      else
        ENV['PWD']
      end
    end
  end
end

def Mactag(&block)
  Mactag::Builder.generate(&block)
end

if Mactag.rails_app?
  require 'mactag/railtie'
end
