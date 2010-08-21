# Mactag

Mactag is a plugin for Rails developers that do their development in
an editor that supports Ctags (Emacs, Vim, TextMate, jEdit, ...). With
Ctags you can follow tags (of functions, variables, macros, whatever)
to their definitions.


# Exuberant Ctags
First off, you must install [Ctags](http://ctags.sourceforge.net/).
Some systems comes with a ctags command already. If you have the ctags
executable, but have problems creating the tags file. Then make sure
that you are using **Exuberant Ctags** and not some other version.


# Installation

## Rails 2.x

### Plugin
Install the plugin:
    $ ./script/plugin install git://github.com/rejeep/mactag.git --revision 'tags/v0.0.5'

### Gem
Install the gem:
    $ gem install mactag --version='0.0.5'
    
Load the gem in **config/environments/development.rb**:
    config.gem 'mactag'
    
Load the rake tasks in **Rakefile**.
    require 'mactag/tasks'


## Rails 3.x

### Plugin
Install the plugin:
    $ rails plugin install git://github.com/rejeep/mactag.git

### Gem
Install the gem:
    $ gem install mactag
    
Load the gem in **Gemfile**:
    group :development do
      gem 'mactag', '0.3.3'
    end


# Configuration
Generate a basic configuration file:

## Rails 2.x
    $ ./script/generate mactag
    
## Rails 3.x
    $ rails generate mactag

This will create the file **config/mactag.rb**, which contains some
examples of how to configure Mactag.

## Options

* **Mactag::Config.rvm:** If true, use RVM gems. Defaults to **true**
* **Mactag::Config.gem_home:** The path where the gems are located. Defaults to **/Library/Ruby/Gems/1.8/gems**
* **Mactag::Config.binary:** The command to run when creating the TAGS-file. Defaults to **ctags -o {OUTPUT} -e {INPUT}**
* **Mactag::Config.tags_file:** Name of output file. Defaults to **TAGS**
* **Mactag::Config.tags_dir:** Name of output directory to store tags files when using FSSM. Defaults to **.tags**

## Example mactag.rb file
    Mactag::Config.rvm = false
    Mactag::Config.gem_home = '/usr/lib/ruby/gems/1.8/gems'
    Mactag::Config.binary = 'etags -o {OUTPUT} {INPUT}'
    Mactag::Config.tags_file = 'TAGS'
    Mactag::Config.tags_dir = '.tags' # See FSSM

    Mactag do # This is "Mactag::Table.generate do" in Rails 2 applications
      app 'app/**/*.rb', 'lib/*.rb'

      plugins 'thinking-sphinx', 'whenever'

      gems 'paperclip', 'authlogic'
      gem 'formtastic', :version => '0.9.7'

      rails :except => :actionmailer, :version => '2.3.5'
    end

# Usage
To create the TAGS file. Simply run:
    $ rake mactag:create


# FSSM
A problem with tags, is that when your project's code changes, your
tags file will not keep up. Mactag can solve this by using FSSM, which
is a tool that notice file system modifications.

To enable FSSM, add the **fssm** gem to your projects Gemfile.

Then start the server that keeps track of changes
    rake mactag:server
    
This creates a couple of tags files in **Mactag::Config.tags_dir**
(one for each source file). This means your editor must support
multiple tags files.

## Editor support

* Emacs - <http://github.com/rejeep/mactag.el>


# License
Copyright (c) 2010 Johan Andersson, released under the MIT license
