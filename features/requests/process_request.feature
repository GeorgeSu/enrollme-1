@javascript
Feature: Manage requests for joining teams
  As a member of a team
  In order to build my team
  I want to be able to accept or reject requests to join my team

 Background: There is a team to join
    Given I clean the database
    Given these users exist
      |   name    |       email                       | team      | major             | sid               | waitlisted  |
      | Tony      |     tony@berkeley.edu             | passcode7 | Slavic Studies    | 823               | true        |
      | An        |    bobjones0@berkeley.edu         | passcode0 | Slavic Studies    | 824               | true        |
      | Hezheng   |    bobjones1@berkeley.edu         | passcode1 | Slavic Studies    | 825               | true        |
      | George    |    bobjones2@berkeley.edu         | passcode1 | Slavic Studies    | 826               | true        |
      | Karl      |    bobjones3@berkeley.edu         | passcode1 | Slavic Studies    | 827               | true        |
      | Ken       |    bobjones4@berkeley.edu         | passcode1 | Slavic Studies    | 828               | true        |
      | Hadi      |    xxx@berkeley.edu               | passcode1 | Slav1c Studies    | 830               | true        |
      | Brandon   |    xx2@berkeley.edu               | passcode1 | Slav1c Studies    | 831               | true        |
      | Sahai     |     sahai@berkeley.edu            | passcode2 | Slavic Studies    | 832               | true        |
      | Hilfinger |     hilf@berkeley.edu             | passcode2 | Slavic Studies    | 833               | true        |
      | PapaD     |     papa@berkeley.edu             | passcode2 | Slavic Studies    | 834               | true        |
      | Fox       |     fox@berkeley.edu              | passcode2 | Slavic Studies    | 835               | true        |
      | Patterson |     pat@berkeley.edu              | passcode2 | Slavic Studies    | 836               | true        |
      | Derek     |   derek@berkeley.edu              | passcode9 | Slavic Studies    | 12345678          | true        |

    And I am on the home page
    And I log in as a user with email "derek@berkeley.edu"
    And I follow "Team List"

  
  @javascript
  Scenario: I send a join request to a team that is not full
    Given I press the "Join Team" button on the same row as "Sahai, Hilfinger, PapaD, Fox, Patterson"
    Then I should see "Request message"
    When I press "Send"
    And I follow "Logout"
    Given I log in as a user with email "sahai@berkeley.edu"
    And I follow "Requests"
    And I should see "Derek"
    
@javascript
  Scenario: I want to accept a request
    And I press the "Join Team" button on the same row as "Sahai, Hilfinger, PapaD, Fox, Patterson"
    When I press "Send"
    And I follow "Logout"
    Given I log in as a user with email "sahai@berkeley.edu"
    And I follow "Requests"
    Then I should see "Derek"
    And I press the "accept" button on the same div as the team with passcode "passcode9"
    Then I should see "Request Approved"
  
@javascript
   Scenario: I want to accept a request, but the request was already accepted
     And I press the "Join Team" button on the same row as "Sahai, Hilfinger, PapaD, Fox, Patterson"
     When I press "Send"
     And I follow "Logout"
     Given I log in as a user with email "sahai@berkeley.edu"
     And I follow "Requests"
     And the request from "Derek" was "accepted"
     When I follow "Accept Request"
     Then I should see "This request was already processed"
     And I should not see "Derek"
     When I follow "Home"
     Then I should see "Derek"

@javascript
   Scenario: I want to accept a request, but the request was already denied/withdrawn
     And I press the "Join Team" button on the same row as "Sahai, Hilfinger, PapaD, Fox, Patterson"
    When I press "Send"
    And I follow "Logout"
     Given I log in as a user with email "sahai@berkeley.edu"
     And I follow "Requests"
     And the request from "Derek" was "denied"
     When I follow "Accept Request"
     Then I should see "This request was already processed"
     And I should not see "Derek"
     When I follow "Home"
     Then I should not see "Derek"

@javascript
   Scenario: I want to deny a request
     And I press the "Join Team" button on the same row as "Sahai, Hilfinger, PapaD, Fox, Patterson"
    When I press "Send"
    And I follow "Logout"
     Given I log in as a user with email "sahai@berkeley.edu"
     And I follow "Requests"
     When I follow "Deny Request"
     Then I should not see "Derek"
     When I follow "Home"
     Then I should not see "Derek"
  
@javascript
   Scenario: I want to deny a request, but the request was already accepted
     And I press the "Join Team" button on the same row as "Sahai, Hilfinger, PapaD, Fox, Patterson"
    When I press "Send"
    And I follow "Logout"
     Given I log in as a user with email "sahai@berkeley.edu"
     And I follow "Requests"
     And the request from "Derek" was "accepted"
     When I follow "Deny Request"
     Then I should see "This request was already processed"
     And I should not see "Derek"
     When I follow "Home"
     Then I should see "Derek"

@javascript
   Scenario: I want to deny a request, but the request was already denied/withdrawn
     And I press the "Join Team" button on the same row as "Sahai, Hilfinger, PapaD, Fox, Patterson"
    When I press "Send"
    And I follow "Logout"
     Given I log in as a user with email "sahai@berkeley.edu"
     And I follow "Requests"
     And the request from "Derek" was "accepted"
     When I follow "Deny Request"
     Then I should see "This request was already processed"
     And I should not see "Derek"
     When I follow "Home"
     Then I should see "Derek"
     
    Scenario: I want to accept more than one request
      And I follow "Logout"
      Given there is a request from "Derek" to the team with "Tony"
      And there is a request from "An" to the team with "Tony"
     Given I log in as a user with email "tony@berkeley.edu"
     And I follow "Requests"
    When I press the "accept" button on the same div as the team with passcode "passcode0"
    And I press the "accept" button on the same div as the team with passcode "passcode9"
    When I follow "Home"
    Then I should see "Derek"
    And I should see "An"
     
    @javascript
    Scenario: I want to accept a request, but my team is now too full
        And I follow "Logout"
        Given I log in as a user with email "sahai@berkeley.edu"
        Given there is a request from "Derek" to the team with "Sahai"
        And there is a request from "An" to the team with "Sahai"
        And I follow "Requests"
        When I press the "accept" button on the same div as the team with passcode "passcode0"
        And I press the "accept" button on the same div as the team with passcode "passcode9"
        Then I should see "no longer valid"
        And I follow "Requests"
        Then I should not see "Derek"
        
    @javascript
    Scenario: I want to accept a request where we send each other a request
        And I press the "Join Team" button on the same row as "Sahai, Hilfinger, PapaD, Fox, Patterson"
        When I press "Send"
        And I follow "Logout"
        Given I log in as a user with email "sahai@berkeley.edu"
        And I follow "Team List"
        And I press the "Join Team" button on the same row as "Derek"
        When I press "Send"
        And I follow "Requests"
        When I press the "accept" button on the same div as the team with passcode "passcode9"
        Then I should not see "Derek"
        When I follow "Home"
        Then I should see "Derek"
        
    @javascript
    Scenario: I want to make sure requests to me are being forwarded, but not being forwarded if they are no longer acceptable
        Given there is a request from "Tony" to the team with "An"
        Given there is a request from "An" to the team with "Derek"
        Given there is a request from "Sahai" to the team with "An"
        When I follow "Requests"
        When I press the "accept" button on the same div as the team with passcode "passcode0"
        And I follow "Logout"
        And I log in as a user with email "tony@berkeley.edu"
        And I follow "Requests"
        Then I should see "Derek"
        And I should see "An"
        And I follow "Logout"
        And I log in as a user with email "sahai@berkeley.edu"
        And I follow "Requests"
        Then I should not see "Derek"
        And I should not see "An"
    
    @javascript
    Scenario: I want to make sure requests from me are being forwarded, but not being forwarded to unacceptable teams
        Given there is a request from "An" to the team with "Derek"
        And there is a request from "An" to the team with "Tony"
        And there is a request from "An" to the team with "Sahai"
        When I follow "Requests"
        When I press the "accept" button on the same div as the team with passcode "passcode0"
        Then I should not see "Sahai"
        And I should see "Tony"
        And I follow "Logout"
        And I log in as a user with email "bobjones0@berkeley.edu"
        And I follow "Requests"
        Then I should not see "Sahai"
        And I should see "Tony"

      