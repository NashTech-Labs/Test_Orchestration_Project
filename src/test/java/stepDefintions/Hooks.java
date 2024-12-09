package stepDefintions;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import Utility.ExtentManager;
import com.aventstack.extentreports.Status;

public class Hooks {

    @Before
    public void setUp(Scenario scenario) {
        // Start the test in Extent Report
        ExtentManager.test = ExtentManager.setupExtentReport().createTest(scenario.getName());
    }

    @After
    public void tearDown(Scenario scenario) {
        // Log the result of the scenario
        if (scenario.isFailed()) {
            ExtentManager.test.log(Status.FAIL, "Scenario Failed: " + scenario.getName());
        } else {
            ExtentManager.test.log(Status.PASS, "Scenario Passed: " + scenario.getName());
        }

        // Flush the report
        ExtentManager.flushReport();
    }
}
