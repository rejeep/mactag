Feature: Tag application files
  In order to create a TAGS file
  As a user
  I want to tag application files

  Background:
    Given a Rails application
    And mactag is installed
    
  Scenario: Tag single file
    Given file "public/javascripts/mactag.js" with contents:
      """
      function mactag() {
        // ...
      }
      """
    And this mactag config file:
      """
      Mactag::Table.generate do
        app 'public/javascripts/mactag.js'
      end
      """
    When I create the tags file
    Then "mactag" should be tagged

  Scenario: Tag multiple files different calls
    Given file "public/javascripts/application.js" with contents:
      """
      function app() {
        // ...
      }
      """
    Given file "public/javascripts/base.js" with contents:
      """
      function base() {
        // ...
      }
      """
    And this mactag config file:
      """
      Mactag::Table.generate do
        app 'public/javascripts/application.js'
        app 'public/javascripts/base.js'
      end
      """
    When I create the tags file
    Then "app" should be tagged
    Then "base" should be tagged

  Scenario: Tag multiple files same call
    Given file "public/javascripts/application.js" with contents:
      """
      function app() {
        // ...
      }
      """
    Given file "public/javascripts/base.js" with contents:
      """
      function base() {
        // ...
      }
      """
    And this mactag config file:
      """
      Mactag::Table.generate do
        app 'public/javascripts/application.js', 'public/javascripts/base.js'
      end
      """
    When I create the tags file
    Then "app" should be tagged
    Then "base" should be tagged
    
  Scenario: Tag multiple files using asterix
    Given file "public/javascripts/application.js" with contents:
      """
      function app() {
        // ...
      }
      """
    Given file "public/javascripts/base.js" with contents:
      """
      function base() {
        // ...
      }
      """
    And this mactag config file:
      """
      Mactag::Table.generate do
        app 'public/javascripts/*.js'
      end
      """
    When I create the tags file
    Then "app" should be tagged
    Then "base" should be tagged

  Scenario: Tag files recursive
    Given file "public/javascripts/mactag.js" with contents:
      """
      function mactag() {
        // ...
      }
      """
    And this mactag config file:
      """
      Mactag::Table.generate do
        app 'public/**/*.js'
      end
      """
    When I create the tags file
    Then "mactag" should be tagged
