*** Settings ***
Library  Selenium2Library

*** Variables ***
${ID_USER_LOGIN} =  xpath=//*[@id="user_login"]
${ID_USER_PASS} =  xpath=//*[@id="user_pass"]
${ID_BUTTON_SUBMIT} =  xpath=//*[@id="submit"]

*** Keywords ***
Update working window
    select window  title=FCV Retailer™ - Login to system.

Navigate To
    [Arguments]  ${url}
    go to  ${url}

Verify Page Loaded
    wait until page contains element  id=loginform

Enter UserName
    [Arguments]  ${username}
    input text  ${ID_USER_LOGIN}  ${username}

Enter Password
    [Arguments]  ${password}
    input password  ${ID_USER_PASS}  ${password}

Click button Login
    click element  ${ID_BUTTON_SUBMIT}
