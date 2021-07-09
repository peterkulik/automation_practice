*** Settings ***
Library    SeleniumLibrary
Resource   ./Utils.robot

*** Variables ***
${ORDER_CART_SUMMARY} =    //table[@id="cart_summary"]
${ORDER_CHECKOUT_LINK} =    //p[contains(@class,"cart_navigation")]//a[contains(@class, "standard-checkout")]
${ORDER_PROCESS_ADDRESS_BUTTON} =    //form//p[contains(@class, "cart_navigation clearfix")]//button[@name="processAddress"]
${ORDER_AGREEMENT_CHECKBOX} =    id:uniform-cgv
${ORDER_PROCESS_CARRIER_BUTTON} =    //form[@name="carrier_area"]//button[@name="processCarrier"]
${ORDER_PAY_BANK_WIRE_LINK} =    //div[@id="HOOK_PAYMENT"]//a[@title="Pay by bank wire"]
${ORDER_CONFIRM_ORDER_BUTTON} =    //p[@id="cart_navigation"]//button[@type="submit"]
${ORDER_COMPLETED_TEXT} =    //div[@id="center_column"]//div[@class="box"]

*** Keywords ***
Verify Order Page Is Loaded
    Wait Until Page Contains Element    ${ORDER_CART_SUMMARY}    ${TIMEOUT}

Verify Order List Contains Same Items
    [Arguments]    ${cart_item_list}
    FOR    ${cart_item}    IN    @{cart_item_list}
        ${product_name_element} =    Get WebElement    (${ORDER_CART_SUMMARY}//p[contains(@class, "product-name")]/a)[${cart_item.index}]
        ${product_name} =    Get Text    ${product_name_element}
        Should Be Equal    ${cart_item.product_name}    ${product_name}

        ${quantity} =    Get Value    (${ORDER_CART_SUMMARY}//td[contains(@class, "cart_quantity")]/input[contains(@class, "cart_quantity_input")])[${cart_item.index}]
        Should Be Equal    ${cart_item.quantity}    ${quantity}

        ${unit_price} =    Utils.Get Price From Span    (${ORDER_CART_SUMMARY}//td[contains(@class, "cart_unit")]/span/span[1])[${cart_item.index}]
        Should Be Equal    ${cart_item.unit_price}    ${unit_price}

        ${total} =    Utils.Get Price From Span    (${ORDER_CART_SUMMARY}//td[contains(@class, "cart_total")]/span)[${cart_item.index}]
        Should Be Equal    ${cart_item.total}    ${total}
    END

Navigate to Checkout
    Wait Until Page Contains Element    ${ORDER_CHECKOUT_LINK}
    Click Link    ${ORDER_CHECKOUT_LINK}

Process Address
    Wait Until Page Contains Element    ${ORDER_PROCESS_ADDRESS_BUTTON}
    Click Button    ${ORDER_PROCESS_ADDRESS_BUTTON}

Process Carrier
    Wait Until Page Contains Element    ${ORDER_PROCESS_CARRIER_BUTTON}
    Click Element    ${ORDER_AGREEMENT_CHECKBOX}
    Click Button    ${ORDER_PROCESS_CARRIER_BUTTON}

Pay Bank Wire
    Wait Until Page Contains Element    ${ORDER_PAY_BANK_WIRE_LINK}
    Click Link    ${ORDER_PAY_BANK_WIRE_LINK}

Confirm Order
    Wait Until Page Contains Element    ${ORDER_CONFIRM_ORDER_BUTTON}
    Click Button    ${ORDER_CONFIRM_ORDER_BUTTON}

Get Order Refence
    Wait Until Page Contains Element    ${ORDER_COMPLETED_TEXT}
    ${text} =    Get Text    ${ORDER_COMPLETED_TEXT}
    ${order_reference} =    Evaluate    re.search("order reference (.+?) in the subject of your bank wire", """${text}""").group(1)    re
    [Return]    ${order_reference}