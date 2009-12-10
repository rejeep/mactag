Feature: Tag application files
  In order to create a TAGS file
  As a user
  I want to tag application files

  Background:
    Given a Rails application
    And mactag is installed
    
  Scenario: Tag single file
    And a javascript function "show" in "whitebox"
    And an app mactag config with the following tags
    | tag                            |
    | public/javascripts/whitebox.js |
    When I create the tags file
    Then the tags file should contain "show"

  Scenario: Tag multiple files
    And a javascript function "hide" in "whitebox"
    And a ruby method "to_s" in the "user" model
    And an app mactag config with the following tags
    | tag                            |
    | public/javascripts/whitebox.js |
    | app/models/user.rb             |
    When I create the tags file
    Then the tags file should contain "hide"
    And the tags file should contain "to_s"

  Scenario: Tag files recursive
    And a ruby method "kill!" in the "user" model
    And an app mactag config with the following tags
    | tag         |
    | app/**/*.rb |
    When I create the tags file
    Then the tags file should contain "kill!"
