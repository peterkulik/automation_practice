*** Settings ***
Library    SeleniumLibrary

*** Variables ***
&{ACCOUNT_CREATION}
...    customer_firstname=id:customer_firstname
...    customer_lastname=id:customer_lastname
...    email=id:email
...    password=id:passwd
...    days=id:days
...    months=id:months
...    years=id:years
...    firstname=id:firstname
...    lastname=id:lastname
...    address1=id:address1
...    city=id:city
...    state=id:id_state
...    postcode=id:postcode
...    country=id:id_country
...    phone_mobile=id:phone_mobile
...    alias=id:alias
...    submitAccount=submitAccount

*** Keywords ***
Verify Registration Form Is Loaded
    FOR    ${item}     IN    &{ACCOUNT_CREATION}
        Wait Until Page Contains Element    ${item}[1]    ${TIMEOUT}
    END

Fill "First Name"
    [Arguments]    ${firstname}
    Input Text    ${ACCOUNT_CREATION.customer_firstname}    ${firstname}

Fill "Last Name"
    [Arguments]    ${lastname}
    Input Text    ${ACCOUNT_CREATION.customer_lastname}    ${lastname}

Fill "Email"
    [Arguments]    ${email}
    Input Text    ${ACCOUNT_CREATION.email}    ${email}

Fill "Password"
    [Arguments]    ${password}
    Input Password    ${ACCOUNT_CREATION.password}    ${password}

Select "Date of Birth"
    [Arguments]    ${dob_days}  ${dob_months}   ${dob_years}
    Select From List By Value    ${ACCOUNT_CREATION.days}    ${dob_days}
    Select From List By Value    ${ACCOUNT_CREATION.months}    ${dob_months}
    Select From List By Value    ${ACCOUNT_CREATION.years}    ${dob_years}

Fill Personal Information
    [Arguments]    ${user_data}    ${email}
    Fill "First Name"    ${user_data.firstname}
    Fill "Last Name"    ${user_data.lastname}
    Fill "Email"    ${email}
    Account Creation.Fill "Password"    ${user_data.password}
    Select "Date Of Birth"  ${user_data.dob_days}   ${user_data.dob_months}    ${user_data.dob_year}

Fill "First Name" (Address)
    [Arguments]    ${firstname}
    Input Text    ${ACCOUNT_CREATION.firstname}    ${firstname}

Fill "Last Name" (Address)
    [Arguments]    ${lastname}
    Input Text    ${ACCOUNT_CREATION.lastname}    ${lastname}

Fill "Address"
    [Arguments]    ${address}
    Input Text    ${ACCOUNT_CREATION.address1}    ${address}

Fill "City"
    [Arguments]    ${city}
    Input Text    ${ACCOUNT_CREATION.city}    ${city}

Select "State"
    [Arguments]    ${state}
    Select From List By Label    ${ACCOUNT_CREATION.state}    ${state}

Fill "Zip/Postal Code"
    [Arguments]    ${postcode}
    Input Text    ${ACCOUNT_CREATION.postcode}    ${postcode}

Select "Country"
    [Arguments]    ${country}
    Select From List By Label    ${ACCOUNT_CREATION.country}    ${country}

Fill "Mobile Phone"
    [Arguments]    ${phone}
    Input Text    ${ACCOUNT_CREATION.phone_mobile}    ${phone}

Fill "Address Alias"
    [Arguments]    ${alias}
    Input Text    ${ACCOUNT_CREATION.alias}    ${alias}

Fill Address Details
    [Arguments]     ${user_data}
    Fill "First Name" (Address)    ${user_data.firstname}
    Fill "Last Name" (Address)    ${user_data.lastname}
    Fill "Address"    ${user_data.address}
    Fill "City"    ${user_data.city}
    Select "State"    ${user_data.state}
    Fill "Zip/Postal Code"    ${user_data.postcode}
    Select "Country"    ${user_data.country}
    Fill "Mobile Phone"    ${user_data.phone}
    Fill "Address Alias"    ${user_data.alias}

Submit Account Creation Form
    Click Button    ${ACCOUNT_CREATION.submitAccount}