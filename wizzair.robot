*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://wizzair.esky.hu/
${BROWSER}    Chrome

*** Test Cases ***
Collect Countries And Prices
    [Documentation]    Ez a teszteset összegyűjti és azonnal kiírja az ország-ár párokat a Wizz Air eSky oldaláról
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    3s
    
    ${elements}    Get WebElements    //div[contains(@class, 'destination-list')]//a
    ${price_elements}    Get WebElements    //div[contains(@class, 'price')]//span
    
    ${element_count}    Get Length    ${elements}
    ${price_count}    Get Length    ${price_elements}
    
    FOR    ${index}    IN RANGE    ${element_count}
        ${country}    Get Text    ${elements}[${index}]
        ${price}    Run Keyword If    ${index} < ${price_count}    Get Text    ${price_elements}[${index}]    ELSE    Set Variable    N/A
        Log    ${country}: ${price}
        Log To Console    ${country}: ${price}
    END
    
    Close Browser
