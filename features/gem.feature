Feature: Tag Gems
  In order to create a TAGS file
  As a user
  I want to tag gems

  Background:
    Given a Rails application
    And mactag is installed
  
  Scenario: Tag single gem
    Given the gem "superduper" version "1.0.0" is installed
    And file "vendor/gems/superduper-1.0.0/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def i_really_am
          # ...
        end
      end
      """
    And this mactag config file:
      """
      Mactag::Config.rvm = false
      Mactag::Config.gem_home = File.join('vendor', 'gems')
      Mactag::Table.generate do
        gem 'superduper'
      end
      """
    When I create the tags file
    Then "i_really_am" should be tagged

  Scenario: Tag multiple gems different calls
    Given the gem "superduper" version "1.0.0" is installed
    Given the gem "dunder" version "0.3.2" is installed
    And file "vendor/gems/superduper-1.0.0/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def i_really_am
          # ...
        end
      end
      """
    And file "vendor/gems/dunder-0.3.2/lib/dunder.rb" with contents:
      """
      class Dunder
        def and_brak
          # ...
        end
      end
      """
    And this mactag config file:
      """
      Mactag::Config.rvm = false
      Mactag::Config.gem_home = File.join('vendor', 'gems')
      Mactag::Table.generate do
        gem 'superduper'
        gem 'dunder'
      end
      """
    When I create the tags file
    Then "i_really_am" should be tagged
    Then "and_brak" should be tagged
    
  Scenario: Tag multiple gems same call
    Given the gem "superduper" version "1.0.0" is installed
    Given the gem "dunder" version "0.3.2" is installed
    And file "vendor/gems/superduper-1.0.0/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def i_really_am
          # ...
        end
      end
      """
    And file "vendor/gems/dunder-0.3.2/lib/dunder.rb" with contents:
      """
      class Dunder
        def and_brak
          # ...
        end
      end
      """
    And this mactag config file:
      """
      Mactag::Config.rvm = false
      Mactag::Config.gem_home = File.join('vendor', 'gems')
      Mactag::Table.generate do
        gem 'superduper', 'dunder'
      end
      """
    When I create the tags file
    Then "i_really_am" should be tagged
    Then "and_brak" should be tagged

  Scenario: Tag specific version
    Given the gem "superduper" version "0.0.3" is installed
    And the gem "superduper" version "1.0.0" is installed
    And file "vendor/gems/superduper-0.0.3/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def still_in_beta
          # ...
        end
      end
      """
    And file "vendor/gems/superduper-1.0.0/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def ready_for_production
          # ...
        end
      end
      """
    And this mactag config file:
      """
      Mactag::Config.rvm = false
      Mactag::Config.gem_home = File.join('vendor', 'gems')
      Mactag::Table.generate do
        gem 'superduper', :version => '1.0.0'
      end
      """
    When I create the tags file
    Then "ready_for_production" should be tagged
    And "still_in_beta" should not be tagged

  Scenario: Tag latest version
    Given the gem "superduper" version "0.0.3" is installed
    And the gem "superduper" version "1.0.0" is installed
    And file "vendor/gems/superduper-0.0.3/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def still_in_beta
          # ...
        end
      end
      """
    And file "vendor/gems/superduper-1.0.0/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def ready_for_production
          # ...
        end
      end
      """
    And this mactag config file:
      """
      Mactag::Config.rvm = false
      Mactag::Config.gem_home = File.join('vendor', 'gems')
      Mactag::Table.generate do
        gem 'superduper'
      end
      """
    When I create the tags file
    Then "ready_for_production" should be tagged
    And "still_in_beta" should not be tagged
