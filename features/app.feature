Feature: Tag application files
  In order to create a TAGS file
  As a user
  I want to tag application files

  Background:
    Given a Rails application
    And mactag is installed
    
  Scenario: Tag single file
    Given a javascript function "show" in "whitebox"
    And a mactag config file with this contents:
      """
      Mactag::Table.generate do
        app "public/javascripts/whitebox.js"
      end
      """
    When I create the tags file
    Then the tags file should contain "show"

  Scenario: Tag multiple files
    Given a javascript function "hide" in "whitebox"
    And a ruby method "to_s" in the "user" model
    And a mactag config file with this contents:
      """
      Mactag::Table.generate do
        app "public/javascripts/whitebox.js"
        app "app/models/user.rb"
      end
      """
    When I create the tags file
    Then the tags file should contain "hide"
    And the tags file should contain "to_s"

  Scenario: Tag files recursive
    Given a ruby method "kill!" in the "user" model
    And a mactag config file with this contents:
      """
      Mactag::Table.generate do
        app "app/**/*.rb"
      end
      """
    When I create the tags file
    Then the tags file should contain "kill!"
