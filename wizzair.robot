*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://wizzair.esky.hu
${DEPARTURE_SECTION}  xpath=//div[contains(@class, 'departure-flights')]
${COUNTRY_ELEMENT}  xpath=//div[contains(@class, 'country-name')]
${PRICE_ELEMENT}  xpath=//div[contains(@class, 'flight-price')]

*** Test Cases ***
List Departing Flights and Prices
    Open Browser  ${URL}  Chrome
    Maximize Browser Window
    Wait Until Element Is Visible  ${DEPARTURE_SECTION}  10
    ${countries}  Get WebElements  ${COUNTRY_ELEMENT}
    ${prices}  Get WebElements  ${PRICE_ELEMENT}
    
    # Ellenőrizzük, hogy az adatok összepárosíthatók-e
    Run Keyword If  ${countries.__len__()} == ${prices.__len__()}  Log Flight Data  ${countries}  ${prices}
    Close Browser

*** Keywords ***
Log Flight Data
    [Arguments]  ${countries}  ${prices}
    FOR  ${i}  IN RANGE  ${countries.__len__()}
        ${country} =  Get Text  ${countries}[${i}]
        ${price} =  Get Text  ${prices}[${i}]
        Log  Flight to ${country}: ${price} HUF
    END