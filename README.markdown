# Mactag

Mactag is a plugin for Rails developers that do their development in
Emacs. Mactag is DSL for creating an
[Emacs TAGS](http://www.gnu.org/software/emacs/manual/html_node/emacs/Tags.html)
file. With Emacs TAGS you can follow tags (of functions, variables,
macros, whatever) to their definitions.

# Installation

Install it as a plugin:

    $ ./script/plugin install git://github.com/rejeep/mactag.git

Generate a basic configuration file:

    $ ./script/generate mactag

This will create the file **config/mactag.rb**, which contains
comments on how to set it up.

You might also want to ignore the plugin and the config file. It's not
really something that should be in the code base.

# Example mactag.rb file
    Mactag::Config.gem_home = "/usr/lib/ruby/gems/1.9/gems"
    Mactag::Config.binary = "etags -o TAGS"

    Mactag::Table.generate do
      app "app/**/*.rb", "lib/*.rb"

      plugins "thinking-sphinx", "formtastic"

      gems "paperclip", "authlogic"
      gem "formtastic", :version => "0.9.7"

      rails :except => :actionmailer
      rails :only => [:activerecord, :active_support]
    end

# Usage

To create the TAGS file. Simpy run:
    rake mactag

# License

Copyright (c) 2010 Johan Andersson, released under the MIT license
