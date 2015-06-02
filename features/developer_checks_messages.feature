@slow_process
Feature: Developer Checkes Message
  Background:
    Given I run `telegram install`
    And there is a message queue

  Scenario: See only NON future pending messages
    Given I run `telegram pending`
    Then I see "remove technical debt" is not in the message list
    Then I should have "3" pending message

  Scenario: See only future message when requested
    Given I run `telegram future`
    Then I should see "remove technical debt" in the message list
    Then I should have "1" pending message

  Scenario: Requests to see all messages
    Given I run `telegram all`
    Then I should see "remove technical debt" in the message list
    Then I should have "4" messages




