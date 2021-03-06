require 'mactag/config'
require 'mactag/builder'
require 'mactag/dsl'
require 'mactag/indexer'
require 'mactag/ctags'
require 'mactag/bundler'
require 'mactag/errors'

module Mactag
  autoload :Bundler, 'bundler'

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

    def project_name
      File.basename(project_root)
    end
  end
end

def Mactag(&block)
  Mactag::Builder.generate(&block)
end
