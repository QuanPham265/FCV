*** Settings ***
Resource  C:/FCV/Resources/Common.robot
Resource  C:/FCV/Resources/SignIn.robot
Resource  C:/FCV/Resources/VerifyData.robot
Resource  C:/FCV/Resources/ViewElement.robot

Documentation       Cover function search history of
...                 display plan in different time range
...                 https://docs.google.com/spreadsheets/d/1_W3WEcrJq21LdgyaAJZZdo92WdAHGIH9ZYp5VmlU-3s/edit#gid=798767983
Metadata            Version     1.8
Test Setup          Common.Begin Web Test
Test Teardown       Common.End Web Test


# How to run this Test Suite
# pybot -d results/SE_Overview_DisplayPlan tests/SE_Overview_DisplayPlan/SE_Overview_DisplayPlan.robot
# pybot -d results/SE_Overview_DisplayPlan --reporttitle "SE Overview DisplayPlan Report" --logtitle "SE Overview DisplayPlan Log" tests/SE_Overview_DisplayPlan/SE_Overview_DisplayPlan.robot
# pybot -d results/SE_Overview_DisplayPlan -i demo tests/SE_Overview_DisplayPlan/SE_Overview_DisplayPlan.robot

*** Variables ***

*** Keywords ***

*** Test Cases ***
Valid Time Range
    [Documentation]  FUNCIONAL_SEARCH_DISPLAYPLAN_01
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Search Display Plan  10/2017  01/2018
    ViewElement.Exist Display Plan  10/2017
    ViewElement.Exist Display Plan  11/2017
    ViewElement.Exist Display Plan  12/2017
    ViewElement.Exist Display Plan  01/2018

Invalid Time Range
    [Documentation]  FUNCIONAL_SEARCH_DISPLAYPLAN_02
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Search Display Plan  05/2019  08/2019
    ViewElement.Not Exist Display Plan

View Old Display Plan
    [Documentation]  FUNCTIONAL_VIEW_DISPLAYPLAN
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.View display plan  02  2018

Submit Creating New Display Plan
    [Documentation]  FUNCTIONAL_CREATE_NEW_DISPLAYPLAN_01
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Submit Creating New Display Plan    ${TEST_MONTH}     ${TEST_YEAR}

Cancel Creating New Display Plan
    [Documentation]  FUNCTIONAL_CREATE_NEW_DISPLAYPLAN_02
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store  ${URL}
    SignIn.Login system  ${USERNAME}  ${PASSWORD}
    ViewElement.Cancel Creating New Display Plan
