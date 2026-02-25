@hotelRoomBookingApiSuite @bookingDetailsByRoomIdFeature @regression
Feature: Get booking details by room id


  @smoke @positive @validData
  Scenario Outline: Search booking details with valid room id
    Given user search booking details with room id "<roomId>"
    When user search the booking details
    Then user successfully received the booking details with <statusCode>

    Examples:
      | roomId | statusCode |
      | 1      | 200        |


  @negative @idValidation
  Scenario Outline: Search booking details with invalid room id
    Given user search booking details with room id "<roomId>"
    When user search the booking details
    Then user should get the booking details response with <statusCode> and "<errorMessage>"

    Examples:
      | roomId  | statusCode | errorMessage        |
      |         | 400        | Room ID is required |
      | 0       | 400        | Invalid Room ID     |
      | -1      | 400        | Invalid Room ID     |
      | xyz456  | 400        | Invalid Room ID     |
      | xyz     | 400        | Invalid Room ID     |
      | xyz@456 | 400        | Invalid Room ID     |


  @negative @invalidEndpoint
  Scenario: Search booking details with invalid endpoint
    Given user search booking details with room id "1"
    When user search the booking details with "/api/search"
    Then user should get the booking details response with 404


  @negative @unauthorized @security
  Scenario: Search booking details without authentication token
    When user search the booking details without authentication token
    Then user should get the booking response with status code 401
