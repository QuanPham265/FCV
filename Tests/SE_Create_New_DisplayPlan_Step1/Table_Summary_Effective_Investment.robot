*** Settings ***
Resource  C:/FCV/Resources/Common.robot
Resource  C:/FCV/Resources/SignIn.robot
Resource  C:/FCV/Resources/VerifyData.robot
Resource  C:/FCV/Resources/ViewElement.robot

Documentation       Verify data summary of Investment to measure efficency last month
...                 Get number display at Step 1 from current month and compare with that table at step 4 last month registeration plan
...                 https://docs.google.com/spreadsheets/d/1_W3WEcrJq21LdgyaAJZZdo92WdAHGIH9ZYp5VmlU-3s/edit#gid=463309594
...                 Data Bảng tổng hợp hiệu quả đầu tư của tháng
Metadata            Version     1.8
Test Setup          Common.Begin Web Test
Test Teardown       Custom Test Teardown

# How to run this Test Suite
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Table_Summary_Effective_Investment -i demo tests/SE_Create_New_DisplayPlan_Step1/Table_Summary_Effective_Investment.robot
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Table_Summary_Effective_Investment         tests/SE_Create_New_DisplayPlan_Step1/Table_Summary_Effective_Investment.robot


*** Variables ***

*** Keywords ***
Custom Test Teardown
    run keyword if test failed   Mark Bug Ticket    ${TEST DOCUMENTATION}
    Common.End Web Test

Mark Bug Ticket
    [Arguments]  ${testcase_code}
    run keyword if  '${testcase_code}'=='SUMMARY_EFFECTIVE_INVESTMENT_NUMBER_OUTLETS'    set test message  Failure by bug ticket #2884
#    ...    ELSE IF  '${testcase_code}'=='DATA_DETAIL_OUTLET_DAUTUHIEUQUA_ENTRY_OUTLETMODEL'  set test message  Failure by bug ticket #2860

*** Test Cases ***
Verify target and reality number outlets of DBB,IFT,ALL
    [Documentation]  SUMMARY_EFFECTIVE_INVESTMENT_NUMBER_OUTLETS
    [Tags]  Regression  demo
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
#    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.View display plan                                   04                  ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Wait table Summary effective Investment loaded
    VerifyData.Verify target and reality number outlets in table SUMMARY EFFECTIVE INVESTMENT  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify Invoice Contribute of Whole distributor, register display outlet and percentage Contribution for Catgroup DBB
    [Documentation]  SUMMARY_EFFECTIVE_INVESTMENT_INVOICE_CATGROUP_DBB
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
#    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.View display plan                                   04                  ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Wait table Summary effective Investment loaded
    VerifyData.Verify Invoice distributor, register display outlet and percentage Contribution for Catgroup  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  DBB

Verify Invoice Contribute of Whole distributor, register display outlet and percentage Contribution for Catgroup IFT
    [Documentation]  SUMMARY_EFFECTIVE_INVESTMENT_INVOICE_CATGROUP_IFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Wait table Summary effective Investment loaded
    VerifyData.Verify Invoice distributor, register display outlet and percentage Contribution for Catgroup  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  IFT

Verify Invoice Contribute of Whole distributor, register display outlet and percentage Contribution for ALL Catgroup
    [Documentation]  SUMMARY_EFFECTIVE_INVESTMENT_INVOICE_CATGROUP_ALL
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Wait table Summary effective Investment loaded
    VerifyData.Verify Invoice distributor, register display outlet and percentage Contribution for Catgroup  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  ALL

Verify Location cost, display cost, total invest cost and percentage investment for Catgroup DBB
    [Documentation]  SUMMARY_EFFECTIVE_INVESTMENT_COST_CATGROUP_DBB
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
#    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.View display plan                                   04                  ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Wait table Summary effective Investment loaded
    VerifyData.Verify Location cost, display cost, total invest cost and percentage investment for Catgroup  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  DBB

Verify Location cost, display cost, total invest cost and percentage investment for Catgroup IFT
    [Documentation]  SUMMARY_EFFECTIVE_INVESTMENT_COST_CATGROUP_IFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Wait table Summary effective Investment loaded
    VerifyData.Verify Location cost, display cost, total invest cost and percentage investment for Catgroup  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  IFT

Verify Location cost, display cost, total invest cost and percentage investment for Catgroup ALL
    [Documentation]  SUMMARY_EFFECTIVE_INVESTMENT_COST_CATGROUP_ALL
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Wait table Summary effective Investment loaded
    VerifyData.Verify Location cost, display cost, total invest cost and percentage investment for Catgroup  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  ALL