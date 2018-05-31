*** Settings ***
Library  Selenium2Library
Library  Dialogs
Test Setup  Begin assignment
Test Teardown  End assignment

*** Variables ***
${URL}       https://sk-web-staging.smartkarma.com/
${BROWSER}   chrome
${USERNAME}  kt+demoproclient@smartkarma.com
${PASSWORD}  sk@12345

*** Keywords ***
Begin assignment
    open browser  about:blank  ${BROWSER}
    maximize browser window

End assignment
    close all browsers

Test Log In    # moi dong the nay la 1 test case nhe, ko phai test step
    go to                           ${URL}
    maximize browser window
    wait until element is visible   xpath=//*[@id="menu-item-1867"]/a
    click element                   xpath=//*[@id="menu-item-1867"]/a
    wait until element is visible   xpath=//*[@id="ember1028"]
    input text                      xpath=//*[@id="ember1028"]  ${USERNAME}
    input password                  xpath=//*[@id="ember1039"]  ${PASSWORD}
    click element                   xpath=//*[@id="ember1004"]/div[1]/button

Test navigate to a list of articles
    pause execution
    wait until element is visible       xpath=//*[@id="ember747"]/div
    click element                       xpath=//*[@id="ember747"]/div
    wait until page contains element    xpath=//*[@id="ember3436"]/h1

Test navigate to a particular article
    click element                        xpath=//*[@id="ember3671"]/div/div[1]

# pybot -d C:/results/ tests/trial/assignment.robot

*** Test Cases ***
Assignment
    Test Log In
    Test navigate to a list of articles
    ghj