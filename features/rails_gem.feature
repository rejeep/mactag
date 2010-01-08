Feature: Tag Rails as a Gem
  In order to create a TAGS file
  As a user
  I want to tag Rails
  
  Background:
    Given a Rails application
    And mactag is installed
    
  Scenario: Tag all packages
    Given rails is installed as a gem
    And a mactag config file with this contents:
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
    Given rails is installed as a gem
    And a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "rails-temp")
      Mactag::Table.generate do
        rails :only => %w[activerecord activesupport]
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
    Given rails is installed as a gem
    And a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "rails-temp")
      Mactag::Table.generate do
        rails :except => %w[actioncontroller actionview]
      end
      """
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
    And a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "rails-temp")
      Mactag::Table.generate do
        rails :version => "3.0.0"
      end
      """
    When I create the tags file
    Then the tags file should contain "3.0.0"
    And the tags file should not contain "2.3.5"

  Scenario: Tag latest version
    Given rails version "3.0.0" is installed as a gem
    And rails version "2.3.5" is installed as a gem
    And rails version "2.3.2" is installed as a gem
    And a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "rails-temp")
      Mactag::Table.generate do
        rails
      end
      """
    When I create the tags file
    Then the tags file should contain "3.0.0"
    And the tags file should not contain "2.3.2"
    And the tags file should not contain "2.3.5"
