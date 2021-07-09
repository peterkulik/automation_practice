*** Settings ***
Library    Collections
Resource    ./Page Objects/NavigationBar.robot
Resource    ./Page Objects/Home.robot
Resource    ./Page Objects/Authentication.robot
Resource    ./Page Objects/Account Creation.robot
Resource    ./Page Objects/My Account.robot
Resource    ./Page Objects/SearchBar.robot
Resource    ./Page Objects/Search Results.robot
Resource    ./Page Objects/Popular.robot
Resource    ./Page Objects/Cart.robot
Resource    ./Page Objects/Order.robot
Resource    ./Page Objects/Footer.robot
Resource    ./Page Objects/History.robot

*** Keywords ***
Navigate to Home Page
    Home.Load    ${BASE_URL}

Create New Account
    [Arguments]    ${email}    ${user_data}
    Authentication.Navigate to Authentication Page
    Authentication.Verify Registration Controls Are Loaded
    Authentication.Fill New "Email Address"    ${email}
    Authentication.Submit Account Creation Form
    Account Creation.Verify Registration Form Is Loaded
    Account Creation.Fill Personal Information    ${user_data}    ${email}
    Account Creation.Fill Address Details    ${user_data}
    Account Creation.Submit Account Creation Form

Verify User Is Signed In
    [Arguments]    ${user_data}
    My Account.Verify Actual Page Is "My Account"
    NavigationBar.Verify User Is Signed In    ${user_data.firstname}    ${user_data.lastname}

Sign In
    [Arguments]    ${email}    ${user_data}
    Authentication.Navigate to Authentication Page
    Authentication.Verify Sign In Controls Are Loaded
    Authentication.Fill "Email Address"    ${email}
    Authentication.Fill "Password"    ${user_data.password}
    Authentication.Submit Sign In Form

Search For Products
    [Arguments]    ${search_term}
    SearchBar.Verify Search Controls Are Loaded
    SearchBar.Search For Products    ${search_term}

Verify Search Results
    [Arguments]    ${search_term}
    Search Results.Verify Results Contains Products    ${search_term}

Add Product To Cart
    [Arguments]    ${index}
    Popular.Add Product To Cart    ${index}
    Popular.Verify Successful Message
    Popular.Close Message Dialog

Add Products To Cart
    ${count} =    Popular.Verify Products Are Available
    ${quantity} =    Set Variable    2
    ${cart_item_list} =    Create List

    FOR    ${index}     IN RANGE    1    ${count} + 1
        ${product} =    Popular.Read Product Details    ${index}

        FOR    ${counter}    IN RANGE    1    ${quantity} + 1
            App.Add Product To Cart    ${index}
            Cart.Verify Product Is In Cart    ${product}[0]    ${index}
            ${total} =    Evaluate    ${product}[1] * ${counter}
            Cart.Verify Product Price Is Updated    ${total}    ${index}
        END

        &{cart_item} =    Create Dictionary    index=${index}    product_name=${product}[0]    unit_price=${product}[1]    quantity=${quantity}    total=${total}    number_of_products=${counter}
        Append To List    ${cart_item_list}    ${cart_item}
    END

    [Return]    ${cart_item_list}

Navigate To Order Page
    Cart.Navigate To Order Page
    Order.Verify Order Page Is Loaded

Verify Order List Contains Same Items As In The Cart
    [Arguments]    ${cart_item_list}
    Order.Verify Order List Contains Same Items    ${cart_item_list}

Delete Products From Cart
    [Arguments]
    Cart.Open Cart
    ${range} =    Cart.Get Item Count Of Cart

    FOR    ${cart_item}    IN RANGE    ${range}
        ${total_price_of_cart_before_remove} =    Cart.Get Total Price Of Cart
        ${removed_item_total} =    Cart.Get First Item Total
        ${cart_item_count} =    Cart.Get Item Count Of Cart
        ${epxected_count_after_remove} =    Evaluate    ${cart_item_count} - 1
        Cart.Remove First Item
        Cart.Verify Item Count In Cart Is Updated    ${epxected_count_after_remove}
        Cart.Verify Cart Total Price Is Decreased    ${total_price_of_cart_before_remove}    ${removed_item_total}
    END

Verify Cart Is Empty
    Cart.Verify Cart Is Empty

Complete Order With Bank Wire
    Order.Navigate To Checkout
    Order.Process Address
    Order.Process Carrier
    Order.Pay Bank Wire
    Order.Confirm Order

Verify "My Order" Page Contains Order Reference
    ${order_reference} =    Order.Get Order Refence
    Footer.Navigate To History ("My Order") Page
    History.Verify Order Exists With Order Reference    ${order_reference}