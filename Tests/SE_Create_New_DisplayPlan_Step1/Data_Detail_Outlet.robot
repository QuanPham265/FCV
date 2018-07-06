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
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Data_Detail_Outlet -i demo tests/SE_Create_New_DisplayPlan_Step1/Data_Detail_Outlet.robot
# pybot -d C:/results/SE_Create_New_DisplayPlan_Step1/Data_Detail_Outlet         tests/SE_Create_New_DisplayPlan_Step1/Data_Detail_Outlet.robot


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
Verify Invoice History Table of outlet belong to group DauTuHieuQua
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUHIEUQUA_HISTORY_INVOICE
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
#    ViewElement.View display plan                                   04                  ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Search a outlet code of Group DauTuHieuQua to edit display plan of this outlet   ${CODE_DTHQ}
    VerifyData.Verify history Invoice table     ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTHQ_FULL}

Verify entry display plan of outlet belong to group DauTuHieuQua
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUHIEUQUA_ENTRY_OUTLETMODEL
    [Tags]  Regression  demo
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Search a outlet code of Group DauTuHieuQua to edit display plan of this outlet   ${CODE_DTHQ}
    VerifyData.Verify entry display plan        ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTHQ_FULL}

Verify Invoice History Table of outlet belong to group DautTuTangTruong
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUTANGTRUONG_HISTORY_INVOICE
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Search a outlet code of Group DautTuTangTruong to edit display plan of this outlet   ${CODE_DTTTR}
    VerifyData.Verify history Invoice table     ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTTTR_FULL}

Verify entry display plan of outlet belong to group DautTuTangTruong
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUTANGTRUONG_ENTRY_OUTLETMODEL
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Search a outlet code of Group DautTuTangTruong to edit display plan of this outlet   ${CODE_DTTTR}
    VerifyData.Verify entry display plan        ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTTTR_FULL}

Verify Invoice History Table of outlet belong to group DauTuChuaHieuQua WITH filter DBB
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUCHUAHIEUQUA_HISTORY_INVOICE_FILTER_DBB
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup DBB
    ViewElement.Search a outlet code of Group DauTuChuaHieuQua to edit display plan of this outlet  ${CODE_DTCHQ}
    VerifyData.Verify history Invoice table     ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTCHQ_FULL}

Verify entry display plan of outlet belong to group DauTuChuaHieuQua WITH filter DBB
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUCHUAHIEUQUA_ENTRY_OUTLETMODEL_FILTER_DBB
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup DBB
    ViewElement.Search a outlet code of Group DauTuChuaHieuQua to edit display plan of this outlet  ${CODE_DTCHQ}
    VerifyData.Verify entry display plan        ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTCHQ_FULL}

Verify Invoice History Table of outlet belong to group KhongNenDauTu WITH filter DBB
    [Documentation]  DATA_DETAIL_OUTLET_KHONGNENDAUTU_HISTORY_INVOICE_FILTER_DBB
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup DBB
    ViewElement.Search a outlet code of Group KhongNenDauTu to edit display plan of this outlet  ${CODE_KNDT}
    VerifyData.Verify history Invoice table     ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_KNDT_FULL}

Verify entry display plan of outlet belong to group KhongNenDauTu WITH filter DBB
    [Documentation]  DATA_DETAIL_OUTLET_KHONGNENDAUTU_ENTRY_OUTLETMODEL_FILTER_DBB
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup DBB
    ViewElement.Search a outlet code of Group KhongNenDauTu to edit display plan of this outlet  ${CODE_KNDT}
    VerifyData.Verify entry display plan        ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_KNDT_FULL}

Verify Invoice History Table of outlet belong to group DauTuHieuQua WITH filter IFT
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUHIEUQUA_HISTORY_INVOICE_FILTER_IFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup IFT
    ViewElement.Search a outlet code of Group DauTuHieuQua to edit display plan of this outlet  ${CODE_DTHQ}
    VerifyData.Verify history Invoice table     ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTHQ_FULL}

Verify entry display plan of outlet belong to group DauTuHieuQua WITH filter IFT
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUHIEUQUA_ENTRY_OUTLETMODEL_FILTER_IFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup IFT
    ViewElement.Search a outlet code of Group DauTuHieuQua to edit display plan of this outlet  ${CODE_DTHQ}
    VerifyData.Verify entry display plan        ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTHQ_FULL}

Verify Invoice History Table of outlet belong to group DauTuChuaHieuQua WITH filter IFT
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUCHUAHIEUQUA_HISTORY_INVOICE_FILTER_IFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup IFT
    ViewElement.Search a outlet code of Group DauTuChuaHieuQua to edit display plan of this outlet  ${CODE_DTCHQ}
    VerifyData.Verify history Invoice table     ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTCHQ_FULL}

Verify entry display plan of outlet belong to group DauTuChuaHieuQua WITH filter IFT
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUCHUAHIEUQUA_ENTRY_OUTLETMODEL_FILTER_IFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter BY Catgroup IFT
    ViewElement.Search a outlet code of Group DauTuChuaHieuQua to edit display plan of this outlet  ${CODE_DTCHQ}
    VerifyData.Verify entry display plan        ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTCHQ_FULL}

Verify Invoice History Table of outlet belong to group DauTuChuaHieuQua WITH filter DBBIFT
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUCHUAHIEUQUA_HISTORY_INVOICE_FILTER_DBBIFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter by Catgroup DBB&IFT
    ViewElement.Search a outlet code of Group DauTuChuaHieuQua to edit display plan of this outlet  ${CODE_DTCHQ}
    VerifyData.Verify history Invoice table     ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTCHQ_FULL}

Verify entry display plan of outlet belong to group DauTuChuaHieuQua WITH filter DBBIFT
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUCHUAHIEUQUA_ENTRY_OUTLETMODEL_FILTER_DBBIFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter by Catgroup DBB&IFT
    ViewElement.Search a outlet code of Group DauTuChuaHieuQua to edit display plan of this outlet  ${CODE_DTCHQ}
    VerifyData.Verify entry display plan        ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTCHQ_FULL}

Verify Invoice History Table of outlet belong to group DautTuTangTruong WITH filter DBBIFT
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUCHUATANGTRUONG_HISTORY_INVOICE_FILTER_DBBIFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter by Catgroup DBB&IFT
    ViewElement.Search a outlet code of Group DautTuTangTruong to edit display plan of this outlet  ${CODE_DTTTR}
    VerifyData.Verify history Invoice table     ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTTTR_FULL}

Verify entry display plan of outlet belong to group DautTuTangTruong WITH filter DBBIFT
    [Documentation]  DATA_DETAIL_OUTLET_DAUTUCHUATANGTRUONG_ENTRY_OUTLETMODEL_FILTER_DBBIFT
    [Tags]  Regression
    SignIn.Navigate to web Perfect Store                            ${URL}
    SignIn.Login system                                             ${USERNAME}         ${PASSWORD}
    ViewElement.Submit Creating New Display Plan                    ${TEST_MONTH}       ${TEST_YEAR}
    ViewElement.Edit Detailed Display Plan
    ViewElement.Filter by Catgroup DBB&IFT
    ViewElement.Search a outlet code of Group DautTuTangTruong to edit display plan of this outlet  ${CODE_DTTTR}
    VerifyData.Verify entry display plan        ${LAST_MONTH}       ${TEST_YEAR}   ${CODE_DTTTR_FULL}