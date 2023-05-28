Feature: Create a new group

  Scenario: Access Groups Page
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Grupos"
    Then I expect the text "Grupos" to be present

  Scenario: View Group Creation Page
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Grupos"
    And I tap the "GroupCreationButton" button
    Then I expect the text "Novo Grupo" to be present

  Scenario: Create Group With Name and Description
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Grupos"
    And I tap the "GroupCreationButton" button
    And I fill the "NomeForm" field with "Nome"
    And I fill the "DiscForm" field with "Something"
    Then I tap the "CreateButton" button