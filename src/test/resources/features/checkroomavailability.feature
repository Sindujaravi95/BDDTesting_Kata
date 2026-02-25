@hotelRoomBookingApiSuite @checkRoomAvailabilityFeature @regression
Feature: Get available rooms by check in and checkout dates


  @smoke @positive @validData
  Scenario Outline: Check available rooms with valid dates
    Given user check the availability of rooms with checkin "<checkin>" and checkout "<checkout>" dates
    When user search the availability of rooms
    Then user successfully received the available rooms with <statusCode>

    Examples:
      | checkin    | checkout   | statusCode |
      | 2025-07-17 | 2025-07-18 | 200        |


  @negative @invalidEndpoint
  Scenario: Check available rooms with invalid endpoint
    Given user check the availability of rooms with checkin "2025-07-17" and checkout "2025-07-18" dates
    When user checks the availability of room with "api/rooms"
    Then user should get the availability of room response with status 404


  @negative @dateValidation
  Scenario Outline: Check available rooms with invalid dates
    Given user check the availability of rooms with checkin "<checkin>" and checkout "<checkout>" dates
    When user search the availability of rooms
    Then user should get the availability of room response with status <statusCode>

    Examples:
      | checkin    | checkout   | statusCode |
      | 2026-01-02 | 2026-01-01 | 400        |
      | 2026-02-29 | 2026-03-01 | 400        |
      | 2026-01-01 | 2026-01-01 | 400        |
      | 2026/02/29 | 2026/02/29 | 400        |
      | 20-02-2026 | 21-02-2026 | 400        |
      | 2026-13-01 | 2026-13-02 | 400        |
      |            | 2026-02-29 | 400        |
      | 2026-02-29 |            | 400        |
      |            |            | 400        |
      | 2026-02-21 | 2029-02-20 | 400        |


  @negative @unauthorized @security
  Scenario: Check room availability without authentication token
    When user check the availability of rooms without authentication token
    Then user should get the booking response with status code 401
