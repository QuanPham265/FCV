*** Settings ***
Resource  C:/FCV/Resources/Common.robot
Resource  C:/FCV/Resources/SignIn.robot
Resource  C:/FCV/Resources/VerifyData.robot
Resource  C:/FCV/Resources/ViewElement.robot
Library  Dialogs

Documentation       Feature save draft after user SE modify display plan
...                 https://docs.google.com/spreadsheets/d/1_W3WEcrJq21LdgyaAJZZdo92WdAHGIH9ZYp5VmlU-3s/edit#gid=463309594
...                 Luu nhap KHTB
Metadata            Version     1.8
Test Setup          Common.Begin Web Test
Test Teardown       Custom Test Teardown

# How to run this Test Suite
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Save_Draft -i demo tests/SE_Create_New_DisplayPlan_Step1/Save_Draft.robot
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Save_Draft         tests/SE_Create_New_DisplayPlan_Step1/Save_Draft.robot


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
    SignIn.Login system                                             1471    123456              #${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    06      2018                #${TEST_MONTH}       ${TEST_YEAR}
#    ViewElement.View display plan                                   04                  ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Search a outlet code of Group DauTuChuaHieuQua to edit display plan of this outlet    C00015818                  #${CODE_KNDT}
    VerifyData.Change specific OutletModel in ModelGroup and check  U_KE_DBB  U_CHUAN_KE
    VerifyData.Save and veriry the change                    U_KE_DBB  U_CHUAN_KE

