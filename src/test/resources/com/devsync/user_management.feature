Feature: User Management

  Scenario: Find all users
    Given the system has users
    When I retrieve all users
    Then I should get a list of users with size 1

  Scenario: Save a new user
    Given I have a new user
    When I save the user
    Then the user should be saved and returned

  Scenario: Find a user by ID
    Given the system has a user with id 1
    When I search for the user by id
    Then I should get the user with username "user3"

  Scenario: Delete a user
    Given the system has a user with id 1
    When I delete the user
    Then the user should be removed from the system









