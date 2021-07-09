*** Settings ***
Library    DateTime
Library    String
Resource    ../Resources/Common.robot
Resource    ../Resources/App.robot
Test Setup    Common.Begin Web Test
Test Teardown    Common.End Web Test

*** Variables ***
${BROWSER} =    chrome
${BASE_URL} =   http://automationpractice.com
${TIMEOUT} =    30s
${DEMO_USER_EMAIL} =    john.doe@peterkuliktest.com
${SEARCH_TERM} =    Printed
&{USER_DATA}    firstname=John
...             lastname=Doe
...             password=JohnDoe_1234
...             dob_days=6
...             dob_months=1
...             dob_year=1981
...             address=Yukon Ave N
...             city=Minneapolis
...             state=Minnesota
...             postcode=55404
...             country=United States
...             phone=+1 612 555 6666
...             alias=home

*** Test Cases ***
Should be able to register for new account
    [Tags]    register
    ${current}    Get Current Date    result_format=%Y%m%d%H%M%S%f

    App.Navigate to Home Page
    App.Create New Account    john.doe${current}@johndoe.com    ${USER_DATA}
    App.Verify User Is Signed In    ${USER_DATA}


Should be able to search for products
    [Tags]    search
    App.Navigate to Home Page
    App.Search For Products    ${SEARCH_TERM}
    App.Verify Search Results    ${SEARCH_TERM}

Should be able to add products to cart from Popular tab
    [Tags]    add_products
    App.Navigate to Home Page
    ${cart_items} =    App.Add Products To Cart
    App.Navigate To Order Page
    App.Verify Order List Contains Same Items As In The Cart    ${cart_items}

Should be able delete products from cart
    [Tags]    delete_products
    App.Navigate to Home Page
    App.Add Products To Cart
    App.Delete Products From Cart
    App.Verify Cart Is Empty

Should be able to purchase products with bank wire
    [Tags]    purchase_products
    App.Navigate to Home Page
    App.Sign In    ${DEMO_USER_EMAIL}    ${USER_DATA}
    App.Verify User Is Signed In    ${USER_DATA}
    App.Navigate to Home Page
    App.Add Product To Cart    ${1}
    App.Navigate To Order Page
    App.Complete Order With Bank Wire
    App.Verify "My Order" Page Contains Order Reference
