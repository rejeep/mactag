module Mactag
  class Config

    @@binary = "ctags -o TAGS -e"
    cattr_accessor :binary

  end
end
