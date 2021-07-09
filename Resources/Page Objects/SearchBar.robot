*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SEARCHBAR_SEARCH_INPUT}    id:search_query_top
${SEARCHBAR_SEARCH_FORM}    id:searchbox

*** Keywords ***
Verify Search Controls Are Loaded
    Wait Until Page Contains Element    ${SEARCHBAR_SEARCH_INPUT}    ${TIMEOUT}
    Wait Until Page Contains Element    ${SEARCHBAR_SEARCH_FORM}    ${TIMEOUT}

Search For Products
    [Arguments]    ${search_term}
    Input Text    ${SEARCHBAR_SEARCH_INPUT}   ${search_term}
    Submit Form    ${SEARCHBAR_SEARCH_FORM}
