*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ./Utils.robot

*** Variables ***
${SHOPPING_CART} =    //header[@id="header"]//div[@class="shopping_cart"]

*** Keywords ***
Verify Product Is In Cart
    [Arguments]    ${product_name}    ${index}
    ${product_name_in_cart} =    Get Element Attribute    (${SHOPPING_CART}//div[contains(@class, "cart-info")]//a[contains(@class, "cart_block_product_name")])[${index}]    title
    Should Be Equal    ${product_name}    ${product_name_in_cart}


Verify Product Price Is Updated
    [Arguments]    ${total}    ${index}
    ${item_price_in_cart} =    Utils.Get Price From Span    (${SHOPPING_CART}//div[contains(@class, "cart-info")]//span[contains(@class, "price")])[${index}]
    Should Be Equal    ${item_price_in_cart}    ${total}

Navigate To Order Page
    Click Link    ${SHOPPING_CART}//a[@title="View my shopping cart"]

Open Cart
    Utils.Scroll To Element    ${SHOPPING_CART}
    Mouse Over    ${SHOPPING_CART}/a

Remove First Item
    Click Link    (${SHOPPING_CART}//a[contains(@class, "ajax_cart_block_remove_link")])[1]

Get First Item Total
    ${result} =    Utils.Get Price From Span    (${SHOPPING_CART}//span[contains(@class, "price")])[1]
    [Return]    ${result}

Get Total Price Of Cart
    ${total_price_of_cart} =    Utils.Get Price From Span    ${SHOPPING_CART}//span[contains(@class, "cart_block_total")]
    [Return]    ${total_price_of_cart}

Verify Cart Total Price Is Decreased
    [Arguments]    ${prev_total_price_of_cart}    ${item_total}
    ${item_count} =    Get Item Count Of Cart
    ${total_price_of_cart} =    Get Total Price Of Cart
    ${expected_total_price_of_cart} =    Evaluate    round(${prev_total_price_of_cart} - ${item_total}, 2) if ${item_count} > 0 else 0
    Should Be Equal    ${expected_total_price_of_cart}    ${total_price_of_cart}

Get Item Count Of Cart
    ${result} =    Get Element Count    ${SHOPPING_CART}//dl[contains(@class, "products")]/dt
    [Return]    ${result}

Item Count Not Updated
    Fail    Item Count Not Updated In Time

Wait Until Item Count Equals To
    [Arguments]    ${expected_item_count}    ${timeout}
    ${watch_interval} =    Set Variable    0.5
    ${range} =    Evaluate    ${timeout} / ${watch_interval}

    FOR    ${waited}    IN RANGE    ${range}
        Sleep    ${watch_interval}s
        ${item_count} =    Get Item Count Of Cart
        Exit For Loop If    ${expected_item_count} == ${item_count}
    END

    Run Keyword If    ${expected_item_count} != ${item_count}    Item Count Not Updated

Verify Item Count In Cart Is Updated
    [Arguments]    ${expected_item_count}
    Wait Until Item Count Equals To    ${expected_item_count}    30
    ${item_count_in_cart} =    Get Item Count Of Cart
    Should Be Equal    ${expected_item_count}    ${item_count_in_cart}

Verify Cart Is Empty
    Verify Item Count In Cart Is Updated    ${0}