@contacts_in_capsule
Feature: User searches for contact
  In order to be able to find contacts without logging into capsule
  As an User
  I want to easily search for a contact by name, phone or email and be given a list

  @wip
  Scenario: Searching for a contact by name
    When I search for "Bob"
    Then I should get 1 contact back

  Scenario: Multiple matches
    When I search for "Jean"
    Then I should get 3 contacts back

  Scenario: Searching by phone number
    When I search for "1962"
    Then I should get 2 contacts back

  Scenario: Searching by email
    When I search for "edendevelopment.co.uk"
    Then I should get 1 contact back
