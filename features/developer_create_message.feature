Feature: Developer Adds Message
  Background:
    Given I run `telegram install`

  @announce
  Scenario: Config files are created
    Then the following directories should exist:
      | config/ |
      | telegram/ |
      | telegram/messages |
      | tmp/telegram/acknowledgments |

  Scenario: Creating message without future flag
    Given I run `telegram new "you need to do this"`
    Then I should see a message has been created
    And I run `telegram pending`
    Then I should see "you need to do this" in the message list
    And I should have "1" pending message

  Scenario: Creating message WITH future flag
    Given I run `telegram new "you need to do this" -f 3`
    And I run `telegram pending`
    Then I should have "0" pending message
    And I run `telegram future`
    Then I should have "1" pending message

