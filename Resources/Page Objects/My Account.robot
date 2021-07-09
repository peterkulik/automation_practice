*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Verify Actual Page Is "My Account"
    Wait Until Location Is    ${BASEURL}/index.php?controller=my-account    ${TIMEOUT}