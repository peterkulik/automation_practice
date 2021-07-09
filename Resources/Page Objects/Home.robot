*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Load
    [Arguments]    ${url}
    Go To   ${url}