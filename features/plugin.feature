Feature: Tag Plugins
  In order to create a TAGS file
  As a user
  I want to tag plugins

  Scenario: Single plugin
    Given a Rails application
    And mactag is installed
    And the plugin "superduper" is installed
    And an acts as method for the "superduper" plugin
    And a plugin mactag config with the following tags
    | tag        |
    | superduper |
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"

  Scenario: Multiple plugins
    Given a Rails application
    And mactag is installed
    And the plugin "superduper" is installed
    And the plugin "dunder" is installed
    And an acts as method for the "superduper" plugin
    And an acts as method for the "dunder" plugin
    And a plugin mactag config with the following tags
    | tag        |
    | superduper |
    | dunder     |
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    Then the tags file should contain "acts_as_dunder"

  Scenario: All plugins
    Given a Rails application
    And mactag is installed
    And the plugin "superduper" is installed
    And the plugin "dunder" is installed
    And an acts as method for the "superduper" plugin
    And an acts as method for the "dunder" plugin
    And a plugin mactag config with the following tags
    | tag |
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    Then the tags file should contain "acts_as_dunder"
