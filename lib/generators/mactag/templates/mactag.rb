##
#
# Use RVM gem path. Mactag will automatically find this.
# Defaults to *true*.
#   Mactag::Config.rvm = true
#

##
#
# Path to gems. This options is only interesting if Mactag::Config.rvm
# is false.
#
# Default is */Library/Ruby/Gems/1.8/gems* (standard path on Mac OS).
# 
# Change to whatever your system is using, if not the default.
# Most GNU/Linux systems:
#   Mactag::Config.gem_home = '/usr/lib/ruby/gems/1.8/gems'
#

##
#
# Change the binary option if you are not satisfied with the standard
# command (ctags -o TAGS -e) used to create the TAGS table.
# Default is *ctags -o TAGS -e*
#   Mactag::Config.binary = '/usr/local/Cellar/ctags/5.8/bin/ctags -e -o {OUTPUT} {INPUT}'
#

##
#
# Example configuration. Change according to your application.
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
  # Index all rails packages, version 2.3.5.
  #   rails :version => '2.3.5'
  #
end
