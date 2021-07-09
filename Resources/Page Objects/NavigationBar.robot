*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SIGN_IN_LINK} =    link:Sign in
${NAVIGATION_BAR_ACCOUNT} =    xpath=//*[@id="header"]//a[@class='account']

*** Keywords ***
Verify Sign In Link Is Loaded
    Wait Until Page Contains Element    ${SIGN_IN_LINK}    ${TIMEOUT}

Click Sign In Button
    Click Link    ${SIGN_IN_LINK}

Verify User Is Signed In
    [Arguments]    ${firstname}    ${lastname}
    Wait Until Page Contains Element    ${NAVIGATION_BAR_ACCOUNT}    ${TIMEOUT}
    Element Text Should Be    ${NAVIGATION_BAR_ACCOUNT}    ${firstname} ${lastname}