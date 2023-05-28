Feature: Check Notifications

  Scenario: Access Notifications Page
    Given I am logged in
    And I tap the "NotificationsButton" button
    Then I expect the text "Notificações" to be present