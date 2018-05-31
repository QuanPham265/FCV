*** Settings ***
Documentation  Make sample test case for project Perfect Store
Resource  ../../Resources/Common.robot
Resource  ../../Resources/SignIn.robot
Resource  ../../Resources/ViewElement.robot
Resource  ../../Resources/VerifyData.robot
Test Setup  Begin Web Test
Test Teardown  End Web Test

# pybot -d results -i DASHBOARD_TABLE_1 tests/dashboard.robot

*** Variables ***
${BROWSER} =  chrome
${URL} =  http://www.banviengroup.com:86/ssologin.html?action=logout
${USERNAME} =  1527
${PASSWORD} =  123456
${DISTRIBUTOR_CODE} =  100150.1

*** Test Cases ***
Verify the number of outlets as total, target, fact of certain month
    [Documentation]  Verify the number of outlets as total, target, fact
    [Tags]  DASHBOARD_TABLE_1
    SignIn.Navigate to web Perfect Store
    SignIn.Login system
    ViewElement.View display plan
    VerifyData.Verify data at table 1 from Dashboard






