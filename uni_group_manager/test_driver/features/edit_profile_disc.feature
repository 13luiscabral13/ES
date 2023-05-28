#Feature: Edit Profile Description
#
#  Scenario: Open Profile Description
#    Given I am logged in
#    And I tap the "ProfilePageButton" button
#    Then I expect the text "Descrição" to be absent
#
#  Scenario: Open Edit Page
#    Given I am logged in
#    And I tap the "ProfilePageButton" button
#    And I tap the "EditPageButton" button
#    Then I expect the text "Descrição" to be absent
#
#  Scenario: Edit Description
#    Given I am logged in
#    And I tap the "ProfilePageButton" button
#    And I tap the "EditPageButton" button
#    And I fill the "NewDescriptionField" field with "Something"
#    Then I tap the "UpdateProfileButton" button