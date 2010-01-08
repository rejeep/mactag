Feature: Tag Rails in vendor
  In order to create a TAGS file
  As a user
  I want to tag Rails
  
  Background:
    Given a Rails application
    And mactag is installed
    And rails lives in vendor

  Scenario: Tag all packages
    Given a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "rails-temp")
      Mactag::Table.generate do
        rails
      end
      """
    When I create the tags file
    Then the tags file should contain "diff"
    And the tags file should contain "get"
    And the tags file should contain "has_many"
    And the tags file should contain "deliver"
    And the tags file should contain "caches_action"
    And the tags file should contain "form_tag"
    
  Scenario: Tag only some packages
    Given a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "rails-temp")
      Mactag::Table.generate do
        rails :only => %w[activerecord active_support]
      end
      """
    When I create the tags file
    Then the tags file should contain "diff"
    And the tags file should contain "has_many"
    And the tags file should not contain "get"
    And the tags file should not contain "deliver"
    And the tags file should not contain "caches_action"
    And the tags file should not contain "form_tag"

  Scenario: Tag all except some packages
    Given a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "rails-temp")
      Mactag::Table.generate do
        rails :except => %w[action_controller actionview]
      end
      """
    When I create the tags file
    Then the tags file should contain "diff"
    And the tags file should contain "has_many"
    And the tags file should contain "get"
    And the tags file should contain "deliver"
    And the tags file should not contain "caches_action"
    And the tags file should not contain "form_tag"
