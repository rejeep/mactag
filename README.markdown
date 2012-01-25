# Mactag

Mactag is a Ruby gem for Ruby developers that do their development in
an editor that supports Ctags (Emacs, Vim, TextMate, ...). With Ctags
you can follow tags (of functions, variables, macros, whatever) to
their definitions.

Mactag works with both Ruby projects and Rails applications.


# Exuberant Ctags

Mactag requires a tool called
[Exuberant Ctags](http://ctags.sourceforge.net/), which is used to
create the tags file. Install it if you don't have it already. Some
systems includes a `ctags` exectuable. If you use that and you have
trouble creating the tags file, then install it from your package
manager instead. The package is called `ctags` in Homebrew and
`exuberant-ctags` in Ubuntu.

# Installation

Install the gem:

    $ gem install mactag

Add `mactag` to the `Gemfile`:

    gem 'mactag'

Then run `bundle install`.


# Configuration

You specify what you want to index in the configuration file (default
is `config/mactag.rb`). To generate such as file with a basic setup,
run the command:

     $ mactag new

Or if you want the config file someplace else:

     $ mactag new conf/mactag.rb

That will generate a configuration file looking something like this:

    Mactag.configure do |config|
      # Use RVM to locate project gems.
      # config.rvm = false

      # Path to gems. No need to set this when RVM is used!
      # config.gem_home = '/Library/Ruby/Gems/1.8/gems'

      # Name of tags file to create.
      # config.tags_file = '.tags'

      # Command used to create the tags table. {INPUT} and {OUTPUT} are required!
      # config.binary = '/usr/local/Cellar/ctags/5.8/bin/ctags -e -o {OUTPUT} {INPUT}'
    end

    Mactag do
      # Index current project.
      # index :lib

      # Index current Rails project.
      # index :app

      # Index all models and helpers.
      # index 'app/models/*.rb', 'app/helpers/*.rb'

      # Index the gems carrierwave and redcarpet.
      # index 'carrierwave', 'redcarpet'

      # Index the gem simple_form version 1.5.2.
      # index 'simple_form', :version => '1.5.2'

      # Index rails.
      # index :rails

      # Index rails except action mailer.
      # index :rails, :except => :actionmailer

      # Index only rails packages activerecord and activesupport.
      # index :rails, :only => %w(activerecord activesupport)

      # Index rails, version 3.1.3.
      # index :rails, :version => '3.1.3'
    end


# Usage

When you are done configuring, create the tags file with the command:

    $ mactag
    
Or if the config file is someplace else than `config/mactag.rb`.

    $ mactag conf/mactag.rb

# License

Copyright (c) 2010-2012 Johan Andersson, released under the MIT license
