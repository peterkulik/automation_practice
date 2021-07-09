*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ./Utils.robot

*** Variables ***
${VISIBLE_MESSAGE} =    //div[@id="layer_cart" and contains(@style, "display: block")]
${PRODUCT_ELEMENTS} =    //ul[@id="homefeatured"]/li
${RIGHT_BLOCK} =    div[@class="right-block"]
${PRODUCT_CONTAINER} =    div[@class="product-container"]

*** Keywords ***
Verify Products Are Available
    ${count} =    Get Element Count    ${PRODUCT_ELEMENTS}
    Should Be True    ${count} > 0
    [Return]    ${count}

Add Product To Cart
    [Arguments]    ${index}
    Utils.Scroll To Element    ${PRODUCT_ELEMENTS}\[${index}\]//${PRODUCT_CONTAINER}
    Mouse Over    ${PRODUCT_ELEMENTS}\[${index}\]//${PRODUCT_CONTAINER}
    Mouse Over    ${PRODUCT_ELEMENTS}\[${index}\]//${RIGHT_BLOCK}
    Click Link    ${PRODUCT_ELEMENTS}\[${index}\]//${RIGHT_BLOCK}//a[@title="Add to cart"]

Verify Successful Message
    Wait Until Page Contains Element    ${VISIBLE_MESSAGE}//h2    ${TIMEOUT}

    ${cart_message_element} =    Get WebElement    ${VISIBLE_MESSAGE}//h2
    ${cart_message} =    Get Text    ${cart_message_element}

    Should Be Equal    ${cart_message}    Product successfully added to your shopping cart

Close Message Dialog
    Click Element    ${VISIBLE_MESSAGE}//span[@title="Continue shopping"]
    Sleep    1s

Read Product Details
    [Arguments]    ${index}
    ${product_name_element} =  Get WebElement    ${PRODUCT_ELEMENTS}\[${index}\]//${RIGHT_BLOCK}//h5[@itemprop="name"]/a
    ${product_price_element} =    Get WebElement    ${PRODUCT_ELEMENTS}\[${index}\]//${RIGHT_BLOCK}//span[@itemprop="price"]

    ${product_name} =    Get Text    ${product_name_element}
    ${product_price} =    Get Text    ${product_price_element}
    ${product_price} =    Remove String    ${product_price}    $
    ${product_price} =   Convert To Number    ${product_price}

    [Return]    ${product_name}    ${product_price}