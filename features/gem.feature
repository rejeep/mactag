Feature: Tag Gems
  In order to create a TAGS file
  As a user
  I want to tag gems

  Background:
    Given a Rails application
    And mactag is installed
  
  Scenario: Tag single gem
    Given the gem "superduper" version "1.0.0" is installed
    And an acts as method for the "superduper-1.0.0" gem
    And a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "gems")
      Mactag::Table.generate do
        gem "superduper"
      end
      """
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"

  Scenario: Tag multiple gems
    Given the gem "superduper" version "1.0.0" is installed
    And the gem "dunder" version "1.0.0" is installed
    And an acts as method for the "superduper-1.0.0" gem
    And an acts as method for the "dunder-1.0.0" gem
    And a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "gems")
      Mactag::Table.generate do
        gems "superduper", "dunder"
      end
      """
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    Then the tags file should contain "acts_as_dunder"

  Scenario: Tag specific version
    Given the gem "superduper" version "1.0.0" is installed
    And the gem "superduper" version "1.0.1" is installed
    And an acts as method for the "superduper-1.0.0" gem
    And an acts as method for the "superduper-1.0.1" gem
    And a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "gems")
      Mactag::Table.generate do
        gem "superduper", :version => "1.0.0"
      end
      """
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    And the tags file should contain "1.0.0"
    And the tags file should not contain "1.0.1"

  Scenario: Tag latest version
    Given the gem "superduper" version "1.0.2" is installed
    And the gem "superduper" version "1.0.1" is installed
    And the gem "superduper" version "1.0.0" is installed
    And an acts as method for the "superduper-1.0.2" gem
    And an acts as method for the "superduper-1.0.1" gem
    And an acts as method for the "superduper-1.0.0" gem
    And a mactag config file with this contents:
      """
      Mactag::Config.gem_home = File.join("vendor", "gems")
      Mactag::Table.generate do
        gem "superduper"
      end
      """
    When I create the tags file
    Then the tags file should contain "acts_as_superduper"
    And the tags file should contain "1.0.2"
    And the tags file should not contain "1.0.0"
    And the tags file should not contain "1.0.1"
