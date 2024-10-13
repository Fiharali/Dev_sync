package com.devsync;


import io.cucumber.junit.CucumberOptions;
import io.cucumber.junit.platform.engine.Cucumber;

@Cucumber
@CucumberOptions(
        features = "src/test/resources",
        glue = "com/devsync"
)
public class CucumberTest {
}
