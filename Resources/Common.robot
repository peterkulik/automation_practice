*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Begin Web Test
    Open Browser    about:blank    ${BROWSER}
    Set Window Size    1200    1024

End Web Test
    Close Browser