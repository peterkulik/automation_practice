*** Settings ***
Library    SeleniumLibrary
Library    String

*** Keywords ***
Get Price From Span
    [Arguments]    ${locator}
    ${price_element} =    Get WebElement    ${locator}
    ${price} =    Get Element Attribute    ${price_element}    innerText
    ${price} =    Remove String    ${price}    $
    ${price} =    Convert To Number    ${price}

    [Return]    ${price}

Scroll To Element
    [Arguments]    ${locator}
    ${x} =    Get Horizontal Position  ${locator}
    ${y} =    Get Vertical Position    ${locator}
    Execute Javascript    window.scrollTo(${x}, ${y})