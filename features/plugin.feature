Feature: Tag Plugins
  In order to create a TAGS file
  As a user
  I want to tag plugins

  Background:
    Given a Rails application
    And mactag is installed
  
  Scenario: Tag single plugin
    Given the plugin "superduper" is installed
    And an acts as method for the "superduper" plugin
    And a mactag config file with this contents:
      """
      Mactag::Table.generate do
        plugin "superduper"
      end
      """
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"

  Scenario: Tag multiple plugins
    Given the plugin "superduper" is installed
    And the plugin "dunder" is installed
    And an acts as method for the "superduper" plugin
    And an acts as method for the "dunder" plugin
    And a mactag config file with this contents:
      """
      Mactag::Table.generate do
        plugin "superduper", "dunder"
      end
      """
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    Then the tags file should contain "acts_as_dunder"

  Scenario: Tag all plugins
    Given the plugin "superduper" is installed
    And the plugin "dunder" is installed
    And an acts as method for the "superduper" plugin
    And an acts as method for the "dunder" plugin
    And a mactag config file with this contents:
      """
      Mactag::Table.generate do
        plugins
      end
      """
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    Then the tags file should contain "acts_as_dunder"
