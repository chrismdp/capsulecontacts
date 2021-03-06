@contacts_in_capsule
Feature: User searches for contact
  In order to be able to find contacts without logging into capsule
  As an User
  I want to easily search for a contact by name, phone or email and be given a list

  Scenario: Searching for a contact by name
    When I search for "Bob"
    Then I should get 1 contact back

  Scenario: Multiple matches
    When I search for "Jean"
    Then I should get 3 contacts back
