@Acceptance
Feature: GET and validate conversion rates for latest dates using Foreign Exchange Rates API
  Validate that Foreign Exchange Rates API is fit for consumption for financial reasons 
  

Background:
  Given Foreign Exchange Rates API is accessible
  
 @UAT
 Scenario Outline: Validate the API responds with correct status code when queried with different parameter combinations 
 
     When API is hit with endpoint as "<endpoint>", "<Base>", "<Symbols>"
     Then API Should respond with status code as "200"
     
    

    Examples: 
     |endpoint       |Symbols   |Base       |
     |latest         |          |           | 
     |latest         |GBP       |USD        | 
     |latest         |GBP       |INR        | 
     |latest         |GBP       |           | 
     |latest         |          |USD        | 