@hotelRoomBookingApiSuite @listOfRoomsFeature @regression
Feature: List Of Room API


  @smoke @positive @validData
  Scenario: Search list of rooms with valid request
    When user search for the list of rooms
    Then user successfully received the list of rooms with status 200


  @negative @invalidEndpoint
  Scenario: Search list of rooms with invalid endpoint
    When user search for the list of rooms with "/api/roomsList"
    Then user should get the list of rooms response with status 404


  @negative @unauthorized @security
  Scenario: Search list of rooms without authentication token
    When user search the list of rooms without authentication token
    Then user should get the booking response with status code 401
