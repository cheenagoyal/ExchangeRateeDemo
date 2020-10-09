@Acceptance
Feature: GET API for latest Foreign Exchange Rates
  Validate that the API is fit for purpose in the use of the exchange rate for financial reasons 
  

Background:
  Given Exchange Rates API is accessible
  
 @AcceptanceCriteria1
 Scenario Outline: Validate the api's with valid request 
 
     When User hits the API with endpoint with "<endpoint>", "<Base>", "<Symbols>"
     Then Response status code should be 200
     
    

    Examples: 
     |endpoint       |Symbols   |Base       |
     |latest         |          |           | 
     |latest         |GBP       |USD        | 
     |latest         |GBP       |INR        | 
     |latest         |GBP       |           | 
     |latest         |          |USD        | 