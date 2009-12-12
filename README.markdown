# Mactag

Mactag is a plugin for Rails developers that do their development in
an editor that supports Ctags (Emacs, Vim, jEdit, ...). With Ctags
you can follow tags (of functions, variables, macros, whatever) to
their definitions.

# Exuberant Ctags
First off you must install [Ctags](http://ctags.sourceforge.net/).
Some systems comes with a ctags command already. If you have the ctags
executable, but have problems creating the tags file. Then make sure
that you are using **Exuberant Ctags** and not some other version.

# Installation

Install it as a plugin:

    $ ./script/plugin install git://github.com/rejeep/mactag.git

Generate a basic configuration file:

    $ ./script/generate mactag

This will create the file **config/mactag.rb**, which contains
some examples of how to set it up.

You might also want to ignore the plugin and the config file. It's not
really something that should be in the code base.

# Configuration
* **Mactag::Config.gem_home:** The path where the gems are located. Defaults to **/usr/lib/ruby/gems/1.8/gems**
* **Mactag::Config.binary:** The command to run when creating the TAGS-file. Defaults to **ctags -o TAGS -e**

# Example mactag.rb file
    Mactag::Config.gem_home = "/usr/lib/ruby/gems/1.9/gems"
    Mactag::Config.binary = "etags -o TAGS"

    Mactag::Table.generate do
      app "app/**/*.rb", "lib/*.rb"

      plugins "thinking-sphinx", "whenever"

      gems "paperclip", "authlogic"
      gem "formtastic", :version => "0.9.7"

      rails :except => :actionmailer, :version => "2.3.5"
    end

# Usage

To create the TAGS file. Simpy run:
    $ rake mactag

# License

Copyright (c) 2010 Johan Andersson, released under the MIT license
