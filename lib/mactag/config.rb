module Mactag
  class Config

    @@binary = "ctags -o TAGS -e"
    cattr_accessor :binary
    
    @@gem_home = "/usr/lib/ruby/gems/1.8/gems"
    cattr_accessor :gem_home

  end
end
