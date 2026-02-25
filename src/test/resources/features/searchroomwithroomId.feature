@hotelRoomBookingApiSuite @roomDetailsByIdFeature @regression
Feature: Get room details by room id API


  @smoke @positive @validData
  Scenario Outline: Search room details with valid room id
    When user search the room details with <roomId>
    Then user successfully received the room details with <statusCode>

    Examples:
      | roomId | statusCode |
      | 1      | 200        |


  @negative @invalidEndpoint
  Scenario: Search room details with invalid endpoint
    When user search the room details with "/api/roomDetails/" and room id 1
    Then user should get the room details response with status 404


  @negative @unauthorized @security
  Scenario: Search rooms without authentication token
    When user search the rooms without authentication token
    Then user should get the booking response with status code 401
