# Mactag

Mactag is a plugin for Rails developers that do their development in
an editor that supports Ctags (Emacs, Vim, TextMate, jEdit, ...). With
Ctags you can follow tags (of functions, variables, macros, whatever)
to their definitions.


# Exuberant Ctags
First off you must install [Ctags](http://ctags.sourceforge.net/).
Some systems comes with a ctags command already. If you have the ctags
executable, but have problems creating the tags file. Then make sure
that you are using **Exuberant Ctags** and not some other version.


# Installation

## Rails 2.x
Version 0.0.3 is the latest version supporting Rails 2.x.

### Plugin
Install the plugin:
    $ ./script/plugin install git://github.com/rejeep/mactag.git --revision 'tags/v0.0.3'

### Gem
Install the gem:
    $ sudo gem install mactag --version='0.0.3'
    
Load the gem in **config/environments/development.rb**:
    config.gem 'mactag'

## Rails 3.x
Version 0.1.0 is the only version supporting Rails 3.x.

### Plugin
Install the plugin:
    $ rails plugin install git://github.com/rejeep/mactag.git --revision 'tags/v0.1.0'

### Gem
Install the gem:
    $ sudo gem install mactag --version='0.1.0'
    
Load the gem in **Gemfile**:
    group :development do
      gem 'mactag'
    end

## Note when installing as Gem
When you install mactag as a gem you must also include it's rake tasks
in your **Rakefile**.
    require 'mactag/tasks'
    

# Configuration
Generate a basic configuration file:

## Rails 2.x
    $ ./script/generate mactag
    
## Rails 3.x
    $ rails generate mactag

This will create the file **config/mactag.rb**, which contains some
examples of how to configure Mactag.


## Options

* **Mactag::Config.gem_home:** The path where the gems are located. Defaults to **/Library/Ruby/Gems/1.8/gems**
* **Mactag::Config.binary:** The command to run when creating the TAGS-file. Defaults to **ctags -o TAGS -e**

## Example mactag.rb file
    Mactag::Config.gem_home = "/usr/lib/ruby/gems/1.8/gems"
    Mactag::Config.binary = "etags -o TAGS"

    Mactag::Table.generate do
      app "app/**/*.rb", "lib/*.rb"

      plugins "thinking-sphinx", "whenever"

      gems "paperclip", "authlogic"
      gem "formtastic", :version => "0.9.7"

      rails :except => :actionmailer, :version => "2.3.5"
    end


# Usage
To create the TAGS file. Simply run:
    $ rake mactag


# License
Copyright (c) 2010 Johan Andersson, released under the MIT license
