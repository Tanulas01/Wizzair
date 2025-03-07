*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://wizzair.esky.hu/
${BROWSER}    Chrome

*** Test Cases ***
Collect Arrival Cities And Prices
    [Documentation]    Ez a teszteset összegyűjti és azonnal kiírja az érkezési városokat és az árakat a Wizz Air eSky oldaláról
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    3s
    
    ${arrival_cities}    Get WebElements    //div[contains(@class, 'arrival-city')]
    ${prices}    Get WebElements    //span[contains(@class, 'price-amount')]
    
    ${city_count}    Get Length    ${arrival_cities}
    ${price_count}    Get Length    ${prices}
    
    FOR    ${index}    IN RANGE    ${city_count}
        ${city}    Get Text    ${arrival_cities}[${index}]
        ${price}    Run Keyword If    ${index} < ${price_count}    Get Text    ${prices}[${index}]    ELSE    Set Variable    N/A
        Log    ${city}: ${price}
        Log To Console    ${city}: ${price}
    END
    
    Close Browser
