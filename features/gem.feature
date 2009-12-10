Feature: Tag Gems
  In order to create a TAGS file
  As a user
  I want to tag gems

  Background:
    Given a Rails application
    And mactag is installed
  
  Scenario: Tag single gem
    And the gem "superduper" version "1.0.0" is installed
    And an acts as method for the "superduper-1.0.0" gem
    And a gem mactag config with the following tags
    | tag        |
    | superduper |
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"

  Scenario: Tag multiple gems
    And the gem "superduper" version "1.0.0" is installed
    And the gem "dunder" version "1.0.0" is installed
    And an acts as method for the "superduper-1.0.0" gem
    And an acts as method for the "dunder-1.0.0" gem
    And a gem mactag config with the following tags
    | tag        |
    | superduper |
    | dunder     |
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    Then the tags file should contain "acts_as_dunder"

  Scenario: Tag specific version
    And the gem "superduper" version "1.0.0" is installed
    And the gem "superduper" version "1.0.1" is installed
    And an acts as method for the "superduper-1.0.0" gem
    And an acts as method for the "superduper-1.0.1" gem
    And a gem mactag config with the following tags
    | tag        | version |
    | superduper |   1.0.0 |
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    And the tags file should contain "1.0.0"
    And the tags file should not contain "1.0.1"

  Scenario: Tag latest version
    And the gem "superduper" version "1.0.2" is installed
    And the gem "superduper" version "1.0.1" is installed
    And the gem "superduper" version "1.0.0" is installed
    And an acts as method for the "superduper-1.0.2" gem
    And an acts as method for the "superduper-1.0.1" gem
    And an acts as method for the "superduper-1.0.0" gem
    And a gem mactag config with the following tags
    | tag        |
    | superduper |
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    And the tags file should contain "1.0.2"
    And the tags file should not contain "1.0.0"
    And the tags file should not contain "1.0.1"
