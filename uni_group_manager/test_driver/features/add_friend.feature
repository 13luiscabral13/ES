
Feature: Add friend

  Scenario: Access Friends Page
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Amigos"
    Then I expect the text "Amigos" to be present

  Scenario: View Student Search
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Amigos"
    And I tap the "AddFriendButton" button
    Then I expect the text "Procura de Estudantes" to be present

  Scenario:  Search For a Student By Code
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Amigos"
    And I tap the "AddFriendButton" button
    And I fill the "CódigoField" field with "up202006464"
    And I tap the "SearchButton" button
    Then I expect the text "Procura de Estudantes" to be present

  Scenario:  Search For a Student By Name
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Amigos"
    And I tap the "AddFriendButton" button
    And I fill the "NameField" field with "Luís Cabral"
    And I tap the "SearchButton" button
    Then I expect the text "Procura de Estudantes" to be present