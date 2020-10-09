@Regression
Feature: Get and Validate conversion rates past/future dates conversion rates from Foreign Exchange Rates API
	Description: Validate if API is fit for purpose in the use of past conversion rates for financial reasons

Background: 
	Given Foreign Exchange Rates API is accessible

@UAT @Regression
Scenario: Confirm that API responds with correct base value for currency based on input
	When API is hit with endpoint as "latest", "USD", ""
	Then Response should contain base currency "USD"

@InvalidEndpoint @Regression	
Scenario:  Validate results when incorrect/invalid endpoint is invoked
	When API is hit with endpoint as "latest", "123", ""
	Then API Should respond with status code as "400"
	And Error message should be displayed as "Base '123' is not supported."
	
@PastConversionRate @Regression
Scenario: Validate that API returns data for specific past date
	When API is hit with endpoint as "2010-01-12", "", ""
	Then API Should respond with status code as "200"

@PastConversionRates @Regression
Scenario: Validate that API returns data for specific past date with correct base value
	When API is hit with endpoint as "2010-02-12", "INR", ""
	Then Response should contain base currency "INR"
	
@FutureConversionRates @Regression
Scenario: Validate that API returns data for today when queried for a future date
	When API is hit with endpoint as "2021-05-12", "", ""
	Then API should return the current date rates
	
	