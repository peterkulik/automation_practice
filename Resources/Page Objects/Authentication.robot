*** Settings ***
Library    SeleniumLibrary
Resource    ./NavigationBar.robot

*** Variables ***
${AUTHENTICATION_EMAIL_CREATE} =    id:email_create
${AUTHENTICATION_SUBMIT_CREATE} =    id:SubmitCreate
${AUTHENTICATION_EMAIL} =    id:email
${AUTHENTICATION_PASSWORD} =    id:passwd
${AUTHENTICATION_SUBMIT_LOGIN} =    id:SubmitLogin

*** Keywords ***
Verify Registration Controls Are Loaded
    Wait Until Page Contains Element    ${AUTHENTICATION_EMAIL_CREATE}    ${TIMEOUT}
    Wait Until Page Contains Element    ${AUTHENTICATION_SUBMIT_CREATE}    ${TIMEOUT}

Fill New "Email Address"
    [Arguments]    ${email}
    Input Text  ${AUTHENTICATION_EMAIL_CREATE}    ${email}

Submit Account Creation Form
    Click Button    ${AUTHENTICATION_SUBMIT_CREATE}

Navigate to Authentication Page
    NavigationBar.Verify Sign In Link Is Loaded
    NavigationBar.Click Sign In Button

Verify Sign In Controls Are Loaded
    Wait Until Page Contains Element    ${AUTHENTICATION_EMAIL}    ${TIMEOUT}
    Wait Until Page Contains Element    ${AUTHENTICATION_PASSWORD}    ${TIMEOUT}
    Wait Until Page Contains Element    ${AUTHENTICATION_SUBMIT_LOGIN}    ${TIMEOUT}

Fill "Email Address"
    [Arguments]    ${email}
    Input Text  ${AUTHENTICATION_EMAIL}    ${email}

Fill "Password"
    [Arguments]    ${password}
    Input Password    ${AUTHENTICATION_PASSWORD}    ${password}

Submit Sign In Form
    Click Button    ${AUTHENTICATION_SUBMIT_LOGIN}
