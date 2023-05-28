Feature: Create a new event

  Scenario: Access Eventos Page
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Eventos"
    Then I expect the text "Eventos" to be present

  Scenario: View Evento Creation Page
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Eventos"
    And I tap the "EventCreationButton" button
    Then I expect the text "Novo Evento" to be absent

  Scenario: Create Evento With Name and Description
    Given I am logged in
    And I open the drawer
    And I tap the button that contains the text "Eventos"
    And I tap the "EventCreationButton" button
    And I fill the "NomeEventoForm" field with "Nome"
    And I fill the "DescriEventoForm" field with "Something"
    And I tap the "GroupChoiceForm" button
    And I tap the button that contains the text "ES - G01"
    Then I tap the "CreateEventoButton" button