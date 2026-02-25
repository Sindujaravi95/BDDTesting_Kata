@hotelRoomBookingApiSuite @bookingReportFeature @regression
Feature: Get Booking Report API


  @smoke @positive  @validData
  Scenario: Search hotel room booking report with valid endpoint
    When user search the booking report
    Then user successfully received the report with status 200


  @negative  @invalidEndpoint
  Scenario: Search booking report with invalid endpoint
    When user search the booking report with "/api/reports"
    Then user should get the booking report response with status 404


  @negative  @invalidHttpMethod
  Scenario: Search booking report with wrong HTTP method
    When user search the booking report with invalid request
    Then user should get the booking report response with status 405


  @negative  @unauthorized @security
  Scenario: Search booking report without authentication token
    When user search the report without authentication token
    Then user should get the booking response with status code 401
