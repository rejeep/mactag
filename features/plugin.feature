Feature: Tag Plugins
  In order to create a TAGS file
  As a user
  I want to tag application plugins

  Background:
    Given a Rails application
    And mactag is installed
  
  Scenario: Tag single plugin
    Given the plugin "superduper" is installed
    And file "vendor/plugins/superduper/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def i_really_am
          # ...
        end
      end
      """
    And this mactag config file:
      """
      Mactag::Table.generate do
        plugin 'superduper'
      end
      """
    When I create the tags file
    Then "i_really_am" should be tagged
  
  Scenario: Tag multiple plugins different calls
    Given the plugin "superduper" is installed
    Given the plugin "dunder" is installed
    And file "vendor/plugins/superduper/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def i_really_am
          # ...
        end
      end
      """
    And file "vendor/plugins/dunder/lib/dunder.rb" with contents:
      """
      class Dunder
        def and_brak
          # ...
        end
      end
      """
    And this mactag config file:
      """
      Mactag::Table.generate do
        plugin 'superduper'
        plugin 'dunder'
      end
      """
    When I create the tags file
    Then "i_really_am" should be tagged
    Then "and_brak" should be tagged
  
  Scenario: Tag multiple plugins same call
    Given the plugin "superduper" is installed
    Given the plugin "dunder" is installed
    And file "vendor/plugins/superduper/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def i_really_am
          # ...
        end
      end
      """
    And file "vendor/plugins/dunder/lib/dunder.rb" with contents:
      """
      class Dunder
        def and_brak
          # ...
        end
      end
      """
    And this mactag config file:
      """
      Mactag::Table.generate do
        plugins 'superduper', 'dunder'
      end
      """
    When I create the tags file
    Then "i_really_am" should be tagged
    Then "and_brak" should be tagged
    
  Scenario: Tag all plugins
    Given the plugin "superduper" is installed
    Given the plugin "dunder" is installed
    And file "vendor/plugins/superduper/lib/superduper.rb" with contents:
      """
      class SuperDuper
        def i_really_am
          # ...
        end
      end
      """
    And file "vendor/plugins/dunder/lib/dunder.rb" with contents:
      """
      class Dunder
        def and_brak
          # ...
        end
      end
      """
    And this mactag config file:
      """
      Mactag::Table.generate do
        plugins
      end
      """
    When I create the tags file
    Then "i_really_am" should be tagged
    Then "and_brak" should be tagged
