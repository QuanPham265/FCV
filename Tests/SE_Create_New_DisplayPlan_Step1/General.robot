*** Settings ***
Resource  C:/FCV/Resources/Common.robot
Resource  C:/FCV/Resources/SignIn.robot
Resource  C:/FCV/Resources/VerifyData.robot
Resource  C:/FCV/Resources/ViewElement.robot
Library  Dialogs

Documentation       All remain sub functional of feature Create New Display Plan at Step 1
...                 https://docs.google.com/spreadsheets/d/1_W3WEcrJq21LdgyaAJZZdo92WdAHGIH9ZYp5VmlU-3s/edit#gid=463309594
...                 Search Ma CH
Metadata            Version     1.8
Test Setup          Common.Begin Web Test
Test Teardown       Custom Test Teardown

# How to run this Test Suite
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/General -i demo tests/SE_Create_New_DisplayPlan_Step1/General.robot
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/General         tests/SE_Create_New_DisplayPlan_Step1/General.robot

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
Save Draft after edited some model group
    [Documentation]  SAVING_DRAFT_01
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
#    ViewElement.View display plan                                   04                  ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Search a outlet code of Group DautTuTangTruong to edit display plan of this outlet    ${CODE_DTTTR}
    VerifyData.Change specific OutletModel in ModelGroup and check  U_KE_DBB  U_CHUAN_KE
    VerifyData.Veriry the change after editting outlet_model        U_KE_DBB  U_CHUAN_KE  DautTuTangTruong
    VerifyData.Save draft and verify the change again               U_KE_DBB  U_CHUAN_KE  DautTuTangTruong  ${CODE_DTTTR}
