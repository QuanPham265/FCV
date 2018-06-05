*** Settings ***
Documentation  A simple Amazon.com suite
Library  Selenium2Library

*** Variables ***
# These variables can be overriden on the command line
${BROWSER} =  chrome
${START_URL} =  https://www.amazon.com

# pybot -d results tests/amazon.robot

*** Test Cases ***
Simple Web GUI Test
    [Documentation]  A simple Amazon.com test
    [Tags]  Smoke
    Open Browser  ${START_URL}  ${BROWSER}  remote_url=http://SAUCE-USER-NAME:SAUCE-KEY@ondemand.saucelabs.com:80/wd/hub  desired_capabilities=name:Win8 + Chrome 43,platform:Windows 8.1,browserName:chrome,version:43
    Wait Until Page Contains  Shop by
    Input Text  css=#twotabsearchtextbox  Ferrari 458
    Click Button  css=#nav-search > form > div.nav-right > div > input
    Wait Until Page Contains  results for
    Close Browser

*** Keywords ***
