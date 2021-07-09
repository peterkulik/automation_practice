*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${PRODUCT_LIST} =    //ul[contains(@class, "product_list")]

*** Keywords ***
Verify Results Contains Products
    [Arguments]    ${search_term}
    Wait Until Location Contains    search_query=Printed    ${TIMEOUT}
    Wait Until Page Contains Element    ${PRODUCT_LIST}    ${TIMEOUT}
    ${elements} =    Get WebElements    ${PRODUCT_LIST}//a[@class="product-name"]
    ${count} =    Get Length    ${elements}

    Should Be True    ${count} > 0

    FOR    ${element}    IN    @{elements}
        Should Contain    ${element.text}    ${search_term}
    END