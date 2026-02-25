@hotelRoomBookingApiSuite @updateBooking @regression
Feature: Update Booking API

  @positive  @validData
  Scenario Outline: Update booking with valid details
    Given user books the hotel room with following details
      | firstname   | lastname   | email   | phone   | checkin   | checkout   | depositpaid   |
      | <firstname> | <lastname> | <email> | <phone> | <checkin> | <checkout> | <depositpaid> |
    And user submit the hotel booking request
    And user should receive the hotel room booking id
    When user update the hotel room with following details
      | firstname  | lastname  | email      | phone      | checkin      | checkout      | depositpaid      |
      | <newFirst> | <newLast> | <newEmail> | <newPhone> | <newCheckin> | <newCheckout> | <newDepositpaid> |
    And user update the booking request
    Then user successfully update the room details with status <statusCode>

    Examples:
      | firstname | lastname | email          | phone       | checkin    | checkout   | depositpaid | newFirst | newLast | newEmail          | newPhone    | newCheckin | newCheckout | newDepositpaid | statusCode |
      | Sinduja   | Ravi     | test@gmail.com | 87955879703 | 2026-05-05 | 2026-05-06 | true        | Sindu    | Kumar   | updated@gmail.com | 87955879704 | 2026-05-07 | 2026-05-08  | false          | 200        |


  @negative  @fieldValidation
  Scenario Outline: Update booking with invalid input
    Given user books the hotel room with following details
      | firstname | lastname | email          | phone       | checkin    | checkout   | depositpaid |
      | Sinduja   | Ravi     | base@gmail.com | 87955879703 | 2026-04-07 | 2026-04-08 | true        |
    And user submit the hotel booking request
    And user should receive the hotel room booking id
    When user update the hotel room with following details
      | firstname | lastname | email   | phone   | checkin   | checkout   | depositpaid   |
      | <fname>   | <lname>  | <email> | <phone> | <checkin> | <checkout> | <depositpaid> |
    And user update the booking request
    Then user should get the update booking response with <statusCode> and "<errorMessage>"

    Examples:
      | fname                           | lname                          | email          | phone       | checkin    | checkout   | depositpaid | statusCode | errorMessage                        |
      |                                 | Ravi                           | test@gmail.com | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | Firstname should not be blank       |
      | Sindu                           |                                | test@gmail.com | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | Lastname should not be blank        |
      | Si                              | Ravi                           | test@gmail.com | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | size must be between 3 and 18       |
      | VeryLongFirstnameExceedingLimit | Ravi                           | test@gmail.com | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | size must be between 3 and 18       |
      | User                            | La                             | test@gmail.com | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | size must be between 3 and 30       |
      | User                            | VeryVeryVeryLongLastNameExceed | test@gmail.com | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | size must be between 3 and 30       |
      | Testing                         | Ravi                           | test           | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | must be a well-formed email address |
      | Sinduja                         | Ravi                           | test@gmail     | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | must be a well-formed email address |
      | Sinduja                         | Ravi                           | @gmail.com     | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | must be a well-formed email address |
      | Sinduja                         | Ravi                           | test@.com      | 87955879703 | 2026-02-03 | 2026-02-04 | true        | 400        | must be a well-formed email address |
      | Sindu                           | Ravi                           | test@gmail.com | 87955       | 2026-02-03 | 2026-02-04 | true        | 400        | size must be between 11 and 21      |
      | Sindu                           | Ravi                           | test@gmail.com | 87955879703 |            | 2026-02-04 | true        | 400        | must not be null                    |
      | User                            | Ravi                           | test@gmail.com | 87955879703 | 2026-02-03 |            | true        | 400        | must not be null                    |
      | Sinduja                         | Ravi                           | test@gmail.com | 87955879703 | 2026-03-32 | 2026-04-02 | true        | 400        | Failed to update booking            |
      | Sinduja                         | Ravi                           | test@gmail.com | 87955879703 | 2026-04-30 | 2026-04-31 | true        | 400        | Failed to update booking            |
      | Sinduja                         | Ravi                           | test@gmail.com | 87955879703 | 2026-05-01 | 2026-05-02 | truee       | 400        | Failed to update booking            |
      | Sinduja                         | Ravi                           | test@gmail.com | 87955879703 | 2026-05-01 | 2026-05-02 | abc         | 400        | Failed to update booking            |
      | Sinduja                         | Ravi                           | test@gmail.com | 87955879703 | 2026-05-01 | 2026-05-02 | 123         | 400        | Failed to update booking            |


  @negative  @invalidEndpoint
  Scenario: Update booking with invalid endpoint
    Given user has a valid booking id
    When user update the booking request "/api/bookings"
    Then user should get the update booking response with 404


  @negative  @invalidBookingId
  Scenario: Update booking with non-existing booking id
    Given user update the hotel room with following details
      | firstname | lastname | email          | phone       | checkin    | checkout   | depositpaid |
      | Sinduja   | Ravi     | test@gmail.com | 87955879703 | 2026-05-05 | 2026-05-06 | true        |
    When user update the booking request with invalid booking id
    Then user should get the update booking response with 404


  @negative  @invalidHttpMethod
  Scenario: Update booking using unsupported HTTP method
    Given user has a valid booking id
    When user sends PUT request instead of PATCH for update
    Then user should get the update booking response with 405


  @negative  @unauthorized
  Scenario: Update booking details without authentication token
    When user update the booking details without authentication token
    Then user should get the booking response with status code 401
