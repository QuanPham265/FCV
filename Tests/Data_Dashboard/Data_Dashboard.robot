*** Settings ***
Resource  C:/FCV/Resources/Common.robot
Resource  C:/FCV/Resources/SignIn.robot
Resource  C:/FCV/Resources/VerifyData.robot
Resource  C:/FCV/Resources/ViewElement.robot

Documentation       This test suite is created to verify data display on dashboard on User SE
...
...                 https://docs.google.com/spreadsheets/d/1_W3WEcrJq21LdgyaAJZZdo92WdAHGIH9ZYp5VmlU-3s/edit#gid=463309594
...                 Data duoc hien thi tai trang Dashboard
Metadata            Version     1.8
Test Setup          Common.Begin Web Test
Test Teardown       Custom Test Teardown

# How to run this Test Suite
# pybot -d C:/results/Data_Dashboard -i demo tests/Data_Dashboard/Data_Dashboard.robot
# pybot -d C:/results/Data_Dashboard         tests/Data_Dashboard/Data_Dashboard.robot

*** Variables ***

*** Keywords ***
Custom Test Teardown
    run keyword if test failed   Mark Bug Ticket    ${TEST DOCUMENTATION}
    Common.End Web Test

Mark Bug Ticket
    [Arguments]  ${testcase_code}
    run keyword if  '${testcase_code}'=='DATA_DETAIL_OUTLET_DAUTUHIEUQUA_HISTORY_INVOICE'    set test message  Failure by bug ticket #1193
#    ...    ELSE IF  '${testcase_code}'=='DATA_DETAIL_OUTLET_DAUTUHIEUQUA_ENTRY_OUTLETMODEL'  set test message  Failure by bug ticket #2860

*** Test Cases ***
Verify data in Chart 1
    [Documentation]  DATA_DASHBOARD_CHART1
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.View display plan                                   01                  ${TEST_YEAR}
    VerifyData.Verify data in table 1
