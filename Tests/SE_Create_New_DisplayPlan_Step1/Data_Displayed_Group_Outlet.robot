*** Settings ***
Resource  C:/FCV/Resources/Common.robot
Resource  C:/FCV/Resources/SignIn.robot
Resource  C:/FCV/Resources/VerifyData.robot
Resource  C:/FCV/Resources/ViewElement.robot

Documentation       After gathering outlets as Invest and Growth into four Group
...                 system will sum all parameter such as Invoice, Paid to have overview. Thia feature is built to valiadate them
...                 https://docs.google.com/spreadsheets/d/1_W3WEcrJq21LdgyaAJZZdo92WdAHGIH9ZYp5VmlU-3s/edit#gid=463309594
...                 Data duoc hien thi tren tung nhom cua hang
Metadata            Version     1.8
Test Setup          Common.Begin Web Test
Test Teardown       Custom Test Teardown

# How to run this Test Suite
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Data_Displayed_Group_Outlet -i demo tests/SE_Create_New_DisplayPlan_Step1/Data_Displayed_Group_Outlet.robot
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Data_Displayed_Group_Outlet         tests/SE_Create_New_DisplayPlan_Step1/Data_Displayed_Group_Outlet.robot


*** Variables ***

*** Keywords ***
Custom Test Teardown
    run keyword if test failed   Mark Bug Ticket    ${TEST DOCUMENTATION}
    Common.End Web Test

Mark Bug Ticket
    [Arguments]  ${testcase_code}
    run keyword if  '${testcase_code}'=='DATA_GROUP_DAUTUHIEUQUA_CTB_MONEY'  set test message  Failrue by bug ticket #2930

*** Test Cases ***
Verify all values by inputting outletcode manually
    [Documentation]  DATA_GROUP_MANUAL
    [Tags]  demo
    ${str_outletcode} =  set variable  '337375C00293935','337375C00295164','337375C00293624'
    Postgres_Server.Connect database
    Postgres_Server.Manual input string outletcode to evaluate many values  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}  ${str_outletcode}
    Postgres_Server.Disconnect database

Verify total contribute money and percentage contribution of group DauTuHieuQua
    [Documentation]  DATA_GROUP_DAUTUHIEUQUA_CTB_MONEY
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
#    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.View display plan                                   ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify total contribute money and percentage contribution each group   DauTuHieuQua  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify growth rate of group DauTuHieuQua
    [Documentation]  DATA_GROUP_DAUTUHIEUQUA_GROWTH_RATE
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify growth rate of each group   DauTuHieuQua  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify total invest money and invest percentage of group DauTuHieuQua
    [Documentation]  DATA_GROUP_DAUTUHIEUQUA_DISPLAYCOST
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify total invest money and invest percentage of each group   DauTuHieuQua  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify total contribute money and percentage contribution of group DautTuTangTruong
    [Documentation]  DATA_GROUP_DAUTUTANGTRUONG_CTB_MONEY
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify total contribute money and percentage contribution each group   DautTuTangTruong  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify growth rate of group DautTuTangTruong
    [Documentation]  DATA_GROUP_DAUTUTANGTRUONG_GROWTH_RATE
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify growth rate of each group   DautTuTangTruong  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify total invest money and invest percentage of group DautTuTangTruong
    [Documentation]  DATA_GROUP_DAUTUTANGTRUONG_DISPLAYCOST
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify total invest money and invest percentage of each group   DautTuTangTruong  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify total contribute money and percentage contribution of group DauTuChuaHieuQua
    [Documentation]  DATA_GROUP_DAUTUCHUAHIEUQUA_CTB_MONEY
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify total contribute money and percentage contribution each group   DauTuChuaHieuQua  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify growth rate of group DauTuChuaHieuQua
    [Documentation]  DATA_GROUP_DAUTUCHUAHIEUQUA_GROWTH_RATE
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify growth rate of each group   DautTuTangTruong  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify total invest money and invest percentage of group DauTuChuaHieuQua
    [Documentation]  DATA_GROUP_DAUTUCHUAHIEUQUA_DISPLAYCOST
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify total invest money and invest percentage of each group   DautTuTangTruong  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify total contribute money and percentage contribution of group KhongNenDauTu
    [Documentation]  DATA_GROUP_KHONGNENDAUTU_CTB_MONEY
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify total contribute money and percentage contribution each group   KhongNenDauTu  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify growth rate of group KhongNenDauTu
    [Documentation]  DATA_GROUP_KHONGNENDAUTU_GROWTH_RATE
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify growth rate of each group   KhongNenDauTu  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}

Verify total invest money and invest percentage of group KhongNenDauTu
    [Documentation]  DATA_GROUP_KHONGNENDAUTU_DISPLAYCOST
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    VerifyData.Verify total invest money and invest percentage of each group   KhongNenDauTu  ${TEST_MONTH}  ${LAST_MONTH}  ${TEST_YEAR}  ${DISTRIBUTOR_CODE}