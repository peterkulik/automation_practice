*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Navigate To History ("My Order") Page
    Click Link    //footer[@id="footer"]//a[contains(@href, "controller=history")]