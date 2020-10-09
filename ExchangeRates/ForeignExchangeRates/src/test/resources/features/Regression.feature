@Regression
Feature: To get past/future dates conversion rates from Foreign Exchange Rates API
	Description: Validate if API is fit for purpose in the use of past conversion rates for financial reasons

Background: 
	Given Exchange Rates API is accessible

@AcceptanceCriteria2
Scenario: Validate the correct response with the Base Value
	When User hits the API with endpoint with "latest", "USD", ""
	Then API should respond with the base value as "USD"

@AcceptanceCriteria3	
Scenario: Validate results on providing incorrect/incomplete URL
	When User hits the API with endpoint with "latest", "123", ""
	Then Response status code should be 400
	And Error message should be displayed as "Base '123' is not supported."
	
@AcceptanceCriteria4
Scenario: Assert the success status of past conversion rates response
	When User hits the API with endpoint with "2010-01-12", "", ""
	Then Response status code should be 200

@AcceptanceCriteria5
Scenario: Assert the success response - content of the past conversion rates response
	When User hits the API with endpoint with "2010-02-12", "INR", ""
	Then API should respond with the base value as "INR"
	
@AcceptanceCriteria6
Scenario: Hit the API with future date and validate current date data should present
	When User hits the API with endpoint with "2021-05-12", "", ""
	Then API should return the current date rates
	
	