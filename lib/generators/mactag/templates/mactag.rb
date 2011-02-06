##
#
# Rvm support or not. Mactag will automatically set path to gems.
#
# Defaults to: true
#
# Example:
#   Mactag::Config.rvm = false
#

##
#
# Path to gems.
#
# Change to whatever your system is using, if not the default. Most
# GNU/Linux systems use: /usr/lib/ruby/gems/1.8/gems
#
# (You don't need to set this when Mactag::Config.rvm is true)
#
# Defaults to: '/Library/Ruby/Gems/1.8/gems'
#
# Example:
#   Mactag::Config.gem_home = '/usr/lib/ruby/gems/1.8/gems'
#

##
#
# Name of tags file.
#
# Defaults to: 'TAGS'
#
# Example:
#   Mactag::Config.tags_file = '.tags'
#

##
#
# This is the command used to create the TAGS table.
#
# The command must specify:
#   {INPUT}  - replaced by the input files to tag
#   {OUTPUT} - replaced by Mactag::Config.tags_file
#
# Defaults to: 'ctags -o {OUTPUT} -e {INPUT}'
#
# Example:
#   Mactag::Config.binary = '/usr/local/Cellar/ctags/5.8/bin/ctags -e -o {OUTPUT} {INPUT}'
#

Mactag do
  ##
  #
  # Index all ruby files in app recursive and all ruby files directly under lib.
  #   app 'app/**/*.rb', 'lib/*.rb'
  #

  ##
  #
  # Index the plugins thinking-sphinx and formtastic.
  #  plugins 'thinking-sphinx', 'formtastic'
  #

  ##
  #
  # Index the gems paperclip and authlogic.
  #   gems 'paperclip', 'authlogic'
  #

  ##
  #
  # Index the gem formtastic version 0.9.7.
  #   gem 'formtastic', :version => '0.9.7'
  #

  ##
  #
  # Index all rails packages, except actionmailer.
  #   rails :except => :actionmailer
  #

  ##
  #
  # Index only rails packages activerecord and activesupport.
  #   rails :only => [:activerecord, :active_support]
  #

  ##
  #
  # Index all rails packages, version 3.0.0.
  #   rails :version => '3.0.0'
  #

  ##
  #
  # Index all rails packages, same version as current application.
  #   rails
  #
end
