*** Settings ***
Resource  C:/FCV/Resources/Common.robot
Resource  C:/FCV/Resources/SignIn.robot
Resource  C:/FCV/Resources/VerifyData.robot
Resource  C:/FCV/Resources/ViewElement.robot


Documentation       Cover function filter by Catgroup
...                 or Outletmodelgroup on monthly Display Plan
...                 https://docs.google.com/spreadsheets/d/1_W3WEcrJq21LdgyaAJZZdo92WdAHGIH9ZYp5VmlU-3s/edit#gid=463309594
...                 Filter theo nganh hang, nhom trung bay
Metadata            Version     1.8
Test Setup          Common.Begin Web Test
Test Teardown       Custom Test Teardown

# How to run this Test Suite
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Filter_Catgroup_Outletmodelgroup -i demo tests/SE_Create_New_DisplayPlan_Step1/Filter_Catgroup_Outletmodelgroup.robot
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Filter_Catgroup_Outletmodelgroup tests/SE_Create_New_DisplayPlan_Step1/Filter_Catgroup_Outletmodelgroup.robot


*** Variables ***

*** Keywords ***
Custom Test Teardown
    run keyword if test failed   Mark Bug Ticket    ${TEST DOCUMENTATION}
    Common.End Web Test

Mark Bug Ticket
    [Arguments]  ${testcase_code}
    run keyword if  '${testcase_code}'=='FILTER_OUTLETMODELGROUP_01'  set test message  Failure by bug ticket #

*** Test Cases ***
Total Number of outlets in Step 1
    [Documentation]  FILTER_TOTAL_OUTLETS
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Submit Creating New Display Plan   ${TEST_MONTH}     ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify total outlets shift to Step 1   ${TEST_MONTH}   ${LAST_MONTH}   ${TEST_YEAR}

Show total outlets have display plan by filter default
    [Documentation]  FILTER_DEFAULT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Submit Creating New Display Plan   ${TEST_MONTH}     ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Filter By Catgroup default and verify shown outlet

Show total outlets have display plan by filter DBB
    [Documentation]  FILTER_CATGROUP_01
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Submit Creating New Display Plan    ${TEST_MONTH}     ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Filter By Catgroup DBB and verify shown outlet  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Show total outlets have display plan by filter IFT
    [Documentation]  FILTER_CATGROUP_02
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Submit Creating New Display Plan    ${TEST_MONTH}     ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Filter By Catgroup IFT and verify shown outlet  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Show total outlets have display plan by filter DBB&IFT
    [Documentation]  FILTER_CATGROUP_03
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Submit Creating New Display Plan    ${TEST_MONTH}     ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Filter By Catgroup DBB&IFT and verify shown outlet  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Show total outlets have display plan by filter U KE DBB
    [Documentation]  FILTER_OUTLETMODELGROUP_01
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Submit Creating New Display Plan    ${TEST_MONTH}     ${TEST_YEAR}
#    ViewElement.View display plan                       03                  ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Filter By ModelGroup U KE DBB and verify shown outlet  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}
