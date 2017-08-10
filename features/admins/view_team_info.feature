Feature: admin can view more information about teams

  As an administrator
  So that I can decide whether or not to approve a team
  I want to click on team IDs and User names to check out their information
  
  Background:
    Given I clean the database
    Given these users exist
     | name  |       email                    |team_passcode | major           | sid  | waitlisted |
     | Sahai | eecs666@hotmail.com            | penguindrool | EECS            | 000  | Yes |
     | Saha2 | eecs667@hotmail.com            | penguindrool | EECS            | 001  | Yes |
     | Saha3 | eecs668@hotmail.com            | penguindrool | EECS            | 002  | Yes |
     | Saha4 | eecs669@hotmail.com            | penguindrool | EECS            | 003  | Yes |
  	 | Jorge | legueoflegends667@hotmail.com  | penguindrool | Football Player | 999  | Yes |
  	And the following admins exist
  	 | name  | email                  |
  	 | Bob   | supreme_ruler@aol.com  |
    And the following discussions exist
  	 | number  | time         |  capacity |
  	 | 54321   | Tues, 3pm    |  25       |
  	 | 54322   | Mon, 3pm     |  26       |
  	 | 54323   | Thur, 3pm    |  27       |
  	And I am on the login page
    And I log in as an admin with email "supreme_ruler@aol.com"
  	And the team with passcode "penguindrool" is submitted with discussion numbers "54321", "54322", and "54323"
    And I follow "Pending"

  Scenario: An admin accesses a submitted team's page
    Then save the page
  	Given I follow "1"
  	Then I should see "Team has been submitted!"
  	Then I should see "Selected Discussion Sections"
  	
  Scenario: An admin accesses a user's information
    Given I follow "Sahai"
    Then I should see "SID: 000"
    And I should see "Major: EECS"