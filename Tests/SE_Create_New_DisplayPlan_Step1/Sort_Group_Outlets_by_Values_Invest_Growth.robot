*** Settings ***
Resource  C:/FCV/Resources/Common.robot
Resource  C:/FCV/Resources/SignIn.robot
Resource  C:/FCV/Resources/VerifyData.robot
Resource  C:/FCV/Resources/ViewElement.robot


Documentation       Cover function sort and group outlets
...                 base on reference values Invest and Growth
...                 https://docs.google.com/spreadsheets/d/1_W3WEcrJq21LdgyaAJZZdo92WdAHGIH9ZYp5VmlU-3s/edit#gid=463309594
...                 Sap xep va nhom cac hang vao 4 nhom dua theo gia tri dau tu va tang truong
Metadata            Version     1.8
Test Setup          Common.Begin Web Test
Test Teardown       Custom Test Teardown


# How to run this Test Suite
# pybot -d C:/results/Sort_Group_Outlets_by_Values_Invest_Growth -i demo  C:/FCV/tests/SE_Create_New_DisplayPlan_Step1/Sort_Group_Outlets_by_Values_Invest_Growth.robot
# pybot -d C:/results/Sort_Group_Outlets_by_Values_Invest_Growth          C:/FCV/tests/SE_Create_New_DisplayPlan_Step1/Sort_Group_Outlets_by_Values_Invest_Growth.robot


*** Variables ***

*** Keywords ***
Custom Test Teardown
    run keyword if test failed   Mark Bug Ticket    ${TEST DOCUMENTATION}
    Common.End Web Test

Mark Bug Ticket
    [Arguments]  ${testcase_code}
    run keyword if  '${testcase_code}'=='GROUP_OUTLETS_BY_INVEST&GROWTH_01'  set test message  Failure by bug ticket #2792
    ...    ELSE IF  '${testcase_code}'=='GROUP_OUTLETS_BY_INVEST&GROWTH_02'  set test message  Failure by bug ticket #2792
    ...    ELSE IF  '${testcase_code}'=='GROUP_OUTLETS_BY_INVEST&GROWTH_03'  set test message  Failure by bug ticket #2792
    ...    ELSE IF  '${testcase_code}'=='GROUP_OUTLETS_BY_INVEST&GROWTH_04'  set test message  Failure by bug ticket #2792
    ...    ELSE IF  '${testcase_code}'=='GROUP_OUTLETS_BY_INVEST&GROWTH_05'  set test message  Failure by bug ticket #2792

*** Test Cases ***
Check default values Invest and Growth of system
    [Documentation]  DEFAULT_VALUES_INVEST&GROWTH_01
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                ${URL}
    SignIn.Login system                                 ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan        ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify Default Values Invest And Growth  ${INVEST_DEF}       ${GROWTH_DEF}

Check set default for Invest and Growth of system after adjust them
    [Documentation]  DEFAULT_VALUES_INVEST&GROWTH_02
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                ${URL}
    SignIn.Login system                                 ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan        ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Check set default for Invest and Growth  ${INVEST_DEF}       ${GROWTH_DEF}        15       90

Group outlets together by default values Invest and Growth
    [Documentation]  GROUP_OUTLETS_BY_INVEST&GROWTH_01
    [Tags]  Regression  demo
    SignIn.Navigate to web Perfect Store                ${URL}
    SignIn.Login system                                 ${USERNAME}         ${PASSWORD}
#    ViewElement.Submit Creating New Display Plan        ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.View display plan                       ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify ablity group outlets with known values   ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  ${INVEST_DEF}  ${GROWTH_DEF}

Group outlets together by Invest and Growth with different default values threshold
    [Documentation]  GROUP_OUTLETS_BY_INVEST&GROWTH_02
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                ${URL}
    SignIn.Login system                                 ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan        ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify ablity group outlets with known values   ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  19  100

Group outlets together by Invest and Growth with filter as Catgroup DBB
    [Documentation]  GROUP_OUTLETS_BY_INVEST&GROWTH_03
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                ${URL}
    SignIn.Login system                                 ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan        ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup DBB
    VerifyData.Verify ablity group outlets with known values   ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  ${INVEST_DEF}  ${GROWTH_DEF}  DBB

Group outlets together by Invest and Growth with filter as Catgroup IFT
    [Documentation]  GROUP_OUTLETS_BY_INVEST&GROWTH_04
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                ${URL}
    SignIn.Login system                                 ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan        ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup DBB
    VerifyData.Verify ablity group outlets with known values   ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  ${INVEST_DEF}  ${GROWTH_DEF}  IFT

Group outlets together by Invest and Growth with filter as Modelgroup U Ke DBB
    [Documentation]  GROUP_OUTLETS_BY_INVEST&GROWTH_05
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                ${URL}
    SignIn.Login system                                 ${USERNAME}         ${PASSWORD}
#    ViewElement.Submit Creating New Display Plan        ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.View display plan                       03                  ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Modelgroup U KE DBB
    VerifyData.Verify ablity group outlets with known values   ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  ${INVEST_DEF}  ${GROWTH_DEF}  None  Ụ Kệ DBB

