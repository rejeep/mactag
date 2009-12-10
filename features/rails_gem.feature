Feature: Tag Rails
  In order to create a TAGS file
  As a user
  I want to tag Rails
  
  Background:
    Given a Rails application
    And mactag is installed
    
  Scenario: Tag all packages
    Given rails is installed as a gem
    And a rails mactag config with the following tags
    | tag |
    When I create the tags file
    Then the tags file should contain "diff"
    And the tags file should contain "get"
    And the tags file should contain "has_many"
    And the tags file should contain "deliver"
    And the tags file should contain "caches_action"
    And the tags file should contain "form_tag"
    
  Scenario: Tag only some packages
    Given rails is installed as a gem
    And a rails mactag config with the following tags
    | only          |
    | activerecord  |
    | activesupport |
    When I create the tags file
    Then the tags file should contain "diff"
    And the tags file should contain "has_many"
    And the tags file should not contain "get"
    And the tags file should not contain "deliver"
    And the tags file should not contain "caches_action"
    And the tags file should not contain "form_tag"

  Scenario: Tag all except some packages
    Given rails is installed as a gem
    And a rails mactag config with the following tags
    | except            |
    | actioncontroller  |
    | actionview        |
    When I create the tags file
    Then the tags file should contain "diff"
    And the tags file should contain "has_many"
    And the tags file should contain "get"
    And the tags file should contain "deliver"
    And the tags file should not contain "caches_action"
    And the tags file should not contain "form_tag"

  Scenario: Tag specific version
    Given rails version "3.0.0" is installed as a gem
    And rails version "2.3.5" is installed as a gem
    And a rails mactag config file with the following tags
    | version |
    |   3.0.0 |
    When I create the tags file
    Then the tags file should contain "3.0.0"
    And the tags file should not contain "2.3.5"

  Scenario: Tag latest version
    Given rails version "3.0.0" is installed as a gem
    And rails version "2.3.5" is installed as a gem
    And rails version "2.3.2" is installed as a gem
    And a rails mactag config file with the following tags
    | tag |
    When I create the tags file
    Then the tags file should contain "3.0.0"
    And the tags file should not contain "2.3.2"
    And the tags file should not contain "2.3.5"
