*** Settings ***
Documentation  A simple Amazon.com suite
Library  Selenium2Library

*** Variables ***
# These variables can be overriden on the command line
${BROWSER} =  chrome
${START_URL} =  https://www.amazon.com

# pybot -d C:/results tests/trial/amazon.robot

*** Test Cases ***
Simple Web GUI Test
    [Documentation]  A simple Amazon.com test
    [Tags]  Smoke
    Open Browser  ${START_URL}  ${BROWSER}  remote_url=http://quanpham265:2ed14dc9-5c26-4c57-923d-6b9c04aa5160@ondemand.saucelabs.com:80  desired_capabilities=name:Win10 + Chrome 67,platform:Windows 10,browserName:chrome,version:67
    Wait Until Page Contains  Shop by
    Input Text  css=#twotabsearchtextbox  Ferrari 458
    Click Button  css=#nav-search > form > div.nav-right > div > input
    Wait Until Page Contains  results for
    Close Browser

*** Keywords ***
