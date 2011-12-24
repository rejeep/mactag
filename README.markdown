# Mactag

Mactag is a plugin for Rails developers that do their development in
an editor that supports Ctags (Emacs, Vim, TextMate, ...). With Ctags
you can follow tags (of functions, variables, macros, whatever) to
their definitions.


# Exuberant Ctags

First off, you must install [Ctags](http://ctags.sourceforge.net/).
Some systems comes with a `ctags` binary already. If you have the
ctags executable, but have problems creating the tags file. Then make
sure that you are using **Exuberant Ctags** and not some other version.


# Installation

Install the gem:

    $ gem install mactag
    
Add `mactag` to the `Gemfile`:

    group :development do
      gem 'mactag'
    end


# Configuration

To generate the configuration file `config/mactag.rb`, use the
`mactag` generator. The generated file contains a basic setup and some
examples of how to configure Mactag.

    $ rails generate mactag

## Example mactag.rb file

    Mactag.configure do |config|
      # Do not use RVM
      config.rvm = false
      config.gem_home = '/usr/lib/ruby/gems/1.8/gems'
      
      # Binary when installing ctags from Homebrew
      config.binary = '/usr/local/Cellar/ctags/5.8/bin/ctags -e -o {OUTPUT} {INPUT}'
      
      # Change name of output file
      config.tags_file = 'DA-TAGS'
    end

    Mactag do
      index 'app/models/*.rb'
      
      index 'carrerwave', 'simple_form'
      index 'redcarpet', :version => '1.17.2'

      index :rails, :except => :actionmailer, :version => '3.1.3'
    end
    
## Configuration Options
The available configuration options are described below.

### rvm
If true, use [Rvm](http://rvm.beginrescueend.com/) when indexing gems.  
Defaults to: `true`

### gem_home
Path to gems. No need to set this when using `rvm`.  
Defaults to: `/Library/Ruby/Gems/1.8/gems`
 
### binary
The command to run when creating the TAGS-file. `{OUTPUT}` will be
replaced with the value of `tags_file` configuration option. `{INPUT}`
will be replaced with all files to index.  
Defaults to: `ctags -o {OUTPUT} -e {INPUT}`

### tags_file
Name of the output tags file.  
Defaults to: `TAGS`


# Usage
To create the TAGS file, simply run:

    $ rake mactag


# License
Copyright (c) 2010-2012 Johan Andersson, released under the MIT license
