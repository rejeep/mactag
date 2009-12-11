Feature: Tag Rails in vendor
  In order to create a TAGS file
  As a user
  I want to tag Rails
  
  Background:
    Given a Rails application
    And mactag is installed
    And rails lives in vendor

  Scenario: Tag all packages
    Given a rails mactag config with the following tags
    | tag |
    When I create the tags file
    Then the tags file should contain "diff"
    And the tags file should contain "get"
    And the tags file should contain "has_many"
    And the tags file should contain "deliver"
    And the tags file should contain "caches_action"
    And the tags file should contain "form_tag"
    
  Scenario: Tag only some packages
    Given a rails mactag config with the following tags
    | only           |
    | activerecord   |
    | active_support |
    When I create the tags file
    Then the tags file should contain "diff"
    And the tags file should contain "has_many"
    And the tags file should not contain "get"
    And the tags file should not contain "deliver"
    And the tags file should not contain "caches_action"
    And the tags file should not contain "form_tag"

  Scenario: Tag all except some packages
    Given a rails mactag config with the following tags
    | except            |
    | action_controller |
    | actionview        |
    When I create the tags file
    Then the tags file should contain "diff"
    And the tags file should contain "has_many"
    And the tags file should contain "get"
    And the tags file should contain "deliver"
    And the tags file should not contain "caches_action"
    And the tags file should not contain "form_tag"
