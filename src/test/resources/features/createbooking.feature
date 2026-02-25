@hotelRoomBookingApiSuite @createBooking
Feature: Create Booking API

  @smoke @positive
  Scenario Outline: Create room booking with valid details
    Given user book the hotel room with following details
      | firstname   | lastname   | email   | phone   | checkin   | checkout   | depositpaid   |
      | <firstname> | <lastname> | <email> | <phone> | <checkin> | <checkout> | <depositpaid> |
    When user submit the booking request
    Then user successfully book the room with status <statusCode>
    And user should receive the booking id

    Examples:
      | firstname          | lastname                       | email               | phone                 | checkin    | checkout   | statusCode | depositpaid |
      | Sinduja            | Ravi                           | test.test@gmail.com | 23525678345           | 2026-04-20 | 2026-04-21 | 201        | true        |
      | Test               | last                           | test.123@gmail.com  | 23545678345           | 2026-05-21 | 2026-05-22 | 201        | false       |
      | Sin                | Ravi                           | test.test@gmail.com | 23525678345           | 2026-04-20 | 2026-04-21 | 201        | true        |
      | Sindujadrdsfsfasda | Ravi                           | test.test@gmail.com | 23525678345           | 2026-04-20 | 2026-04-21 | 201        | true        |
      | Sinduja            | Rav                            | test.test@gmail.com | 23525678345           | 2026-04-20 | 2026-04-21 | 201        | true        |
      | Sinduja            | Raviiwehwiqehwqehwhewhwhewjhwe | test.test@gmail.com | 23525678345           | 2026-04-20 | 2026-04-21 | 201        | true        |
      | Sinduja            | Ravi                           | test.test@gmail.com | 235256783455345678902 | 2026-04-20 | 2026-04-21 | 201        | true        |


  @regression  @negative @fieldValidation
  Scenario Outline: Create booking with invalid input
    Given user book the hotel room with following details
      | firstname   | lastname   | email   | phone   | checkin   | checkout   | depositpaid   |
      | <firstname> | <lastname> | <email> | <phone> | <checkin> | <checkout> | <depositpaid> |
    When user submit the booking request
    Then user should get the booking response with <statusCode> and "<errorMessage>"

    Examples:
      | firstname           | lastname                        | email               | phone                  | checkin    | checkout   | statusCode | errorMessage                        | depositpaid |
      |                     | last                            | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | Firstname should not be blank       | true        |
      | Test@123            | last                            | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | Firstname should not be blank       | true        |
      | Test                | last*1                          | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | Firstname should not be blank       | true        |
      | user                |                                 | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | Lastname should not be blank        | true        |
      | se                  | last                            | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | size must be between 3 and 18       | true        |
      | Sindkfdkfjkdjfdkdfk | last                            | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | size must be between 3 and 18       | true        |
      | user                | ah                              | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | size must be between 3 and 30       | true        |
      | user                | Ravdkfdkfjkdjfdkdfksdjsdsjdsdss | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | size must be between 3 and 30       | true        |
      |                     |                                 | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | Firstname should not be blank       | true        |
      | Sinduja             | Ravi                            | test                | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | must be a well-formed email address | true        |
      | Sinduja             | Ravi                            | test@gmail          | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | must be a well-formed email address | true        |
      | Sinduja             | Ravi                            | @gmail.com          | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | must be a well-formed email address | true        |
      | Sinduja             | Ravi                            | test@.com           | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | must be a well-formed email address | true        |
      | Sinduja             | Ravi                            | test@gmail.com      | 8795587970             | 2026-01-28 | 2026-01-29 | 400        | size must be between 11 and 21      | true        |
      | Sinduja             | Ravi                            | test@gmail.com      | 8795587970343422242445 | 2026-01-28 | 2026-01-29 | 400        | size must be between 11 and 21      | true        |
      | Sinduja             | Ravi                            | user.last@gmail.com | 879558797034           |            | 2026-01-29 | 400        | must not be null                    | true        |
      | Sinduja             | Ravi                            | user.last@gmail.com | 879558797034           | 2026-01-28 |            | 400        | must not be null                    | true        |
      | Sinduja             | Ravi                            | test@gmail.com      | 879558797034           |            |            | 400        | must not be null                    | true        |
      | Sinduja             | Ravi                            | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | Failed to create booking            | truee       |
      | Sinduja             | Ravi                            | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | Failed to create booking            | test        |
      | Sinduja             | Ravi                            | test@gmail.com      | 879558797034           | 2026-01-28 | 2026-01-29 | 400        | Failed to create booking            | 123         |


  @regression  @negative @dateValidation
  Scenario Outline: Create booking with invalid date
    Given user book the hotel room with following details
      | firstname   | lastname   | email   | phone   | checkin   | checkout   | depositpaid   |
      | <firstname> | <lastname> | <email> | <phone> | <checkin> | <checkout> | <depositpaid> |
    When user submit the booking request
    Then user should get the booking response with <statusCode> and "<errorMessage>"

    Examples:
      | firstname | lastname | email          | phone        | checkin    | checkout   | statusCode | errorMessage             | depositpaid |
      | Sindu     | Ravi     | test@gmail.com | 879558797034 | 2026-01-32 | 2026-02-02 | 400        | Failed to create booking | true        |
      | Sindu     | Ravi     | test@gmail.com | 879558797034 | 2026-02-28 | 2026-02-29 | 400        | Failed to create booking | true        |
      | Sindu     | Ravi     | test@gmail.com | 879558797034 | 2026-02-14 | 2026-02-12 | 400        | Failed to create booking | true        |
      | Sindu     | Ravi     | test@gmail.com | 879558797034 | 2026-01-28 | 2026-01-29 | 400        | Failed to create booking | true        |


  @regression  @negative @invalidEndpoint
  Scenario: Create booking with invalid endpoint
    When user submit the booking request "/api/bookings"
    Then user should get the booking response with status code 404


  @regression  @negative @rest @invalidHttpMethod
  Scenario: Create booking with unsupported HTTP method
    When user submit the invalid booking request
    Then user should get the booking response with status code 405


  @regression  @negative @duplicate @businessValidation
  Scenario Outline: Create duplicate booking with same details
    Given user book the hotel room with following details
      | firstname   | lastname   | email   | phone   | checkin   | checkout   | depositpaid   |
      | <firstname> | <lastname> | <email> | <phone> | <checkin> | <checkout> | <depositpaid> |
    When user submit the booking request
    And user book the hotel room with same details again
    Then user should get the booking response with status code 409

    Examples:
      | firstname | lastname | email               | phone       | checkin    | checkout   | depositpaid |
      | Sinduja   | Ravi     | test.test@gmail.com | 23525678345 | 2026-01-28 | 2026-01-29 | true        |


  @regression @negative @@unauthorized @security
  Scenario: Create booking without authentication token
    When user submit the booking request without authentication token
    Then user should get the booking response with status code 401
