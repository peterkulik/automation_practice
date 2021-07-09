*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Verify Order Exists With Order Reference
    [Arguments]    ${order_reference}
    Page Should Contain Element    //table[@id="order-list"]//a[contains(text(),"${order_reference}")]