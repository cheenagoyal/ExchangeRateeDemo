package stepDefinition;

import base.BaseClass;
import org.testng.Assert;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import io.restassured.RestAssured;

public class AcceptanceCriteriaSteps extends BaseClass {

	// REST API under test
	private static final String BASE_URL = "https://api.ratesapi.io/api";
	private int actualStatusCode;

	/*
	 * Precondition for all scenarios - Will run at start of each scenarios active
	 * for execution
	 */

	@Given("^Foreign Exchange Rates API is accessible$")
	public void i_am_an_authorized_user() throws Throwable {
		System.out.println("--------API UNDER TEST-------" + BASE_URL);

		// Specify URI to test
		RestAssured.baseURI = BASE_URL;
		request = RestAssured.given().log().all().header("Content-Type", "application/json");

	}

	// Method to Hit the EndPoints
	@When("^API is hit with endpoint as \"([^\"]*)\", \"([^\"]*)\", \"([^\"]*)\"$")
	public void hitEndpoints(String endpoint, String base, String symbols) {

		response = request.queryParam("base", base).queryParam("symbols", symbols).pathParam("val", endpoint).when()
				.get("/{val}").then().log().body().extract().response();

	}

	// Validating the response code

	@Then("^API Should respond with status code as \"([^\"]*)\"$")
	public void userShouldGetStatusCode(int expectedStatusCode) {

		// Extracting status code to verify
		actualStatusCode = response.getStatusCode();

		// Checking if value retrieved is expected
		Assert.assertEquals(expectedStatusCode, actualStatusCode);
		System.out.println("--------Response code recieved-------" + expectedStatusCode);

	}

	// Verify the Response base value

	@Then("^Response should contain base currency \"([^\"]*)\"$")
	public void userShouldGetBaseValue(String expectedBaseValue) throws Throwable {
		System.out.println("---------- Assert the base values from Response ----");

		// Retrieve the body of the Response
		body = response.getBody();

		String bodyasString = body.asString();

		// Checking if value retrieved is as expected
		Assert.assertEquals(bodyasString.contains(expectedBaseValue), true);
		System.out.println("Base Value Received : " + expectedBaseValue);

	}

	// * Verify the error message for invalid query parameters

	@Then("^Error message should be displayed as \"([^\"]*)\"$")
	public void verifyErrorMessage(String expectedErrorMessage) throws Throwable {
		System.out.println("-----Verify the error message for incorrect endpoint -------");

		body = response.getBody();

		String responseBody = body.asString();

		// Checking if value retrieved is expected
		Assert.assertEquals(responseBody.contains(expectedErrorMessage), true);

		System.out.println("Error message received : " + expectedErrorMessage);
	}

	@Then("^API should return the current date rates$")
	public void getCurrentDateRates() throws Throwable {
		System.out.println("Verifying current date data should return although the endpoint is of future date");

		// Method for retrieving current date data if the end-point is of future date
		validatingFutureDateResponse();
	}

}
