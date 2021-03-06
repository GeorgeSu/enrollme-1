Feature: Student creates a new account
  As a student
  In order to enroll for CS169 and submit a team
  I want to create an account on EnrollMe
  
  Background:
    Given I am on the new_user page

  Scenario: User successfully creates an account and logs in
    When I fill in "Name" with "David"
    And I fill in "Email" with "david@berkeley.edu"
    And I fill in "Sid" with "12345678"
    And I select "DECLARED CS/EECS Major" from "major"
    And I choose "user_waitlisted_true"
    And I press "Sign Up"
    Then I should see "My Team"
    Then I should receive a confirmation email at "david@berkeley.edu"
    
  Scenario: User fails to create an account
    And I press "Sign Up"
    Then I should see "Form is invalid"
    
  Scenario: An admin cannot sign up as a user
    Given the following admins exist
     | name  | email                  |
  	 | Bob   | supreme_ruler@aol.com  |
  	And I fill in "Name" with "Bob"
  	And I fill in "Email" with "supreme_ruler@aol.com"
    And I fill in "Sid" with "98745632"
    And I select "Other Major" from "major"
    And I choose "user_waitlisted_true"
    And I press "Sign Up"
    Then I should see "Form is invalid"

