*** Settings ***
Resource  C:/FCV/Resources/PO/PO_RegistrationHistory.robot
Resource  C:/FCV/Resources/PO/PO_Dashboard.robot
Resource  C:/FCV/Resources/PO/PO_DetailedDisplayPlan_Step1.robot

*** Variables ***


*** Keywords ***
View display plan
    [Arguments]  ${month}  ${year}
    PO_RegistrationHistory.Verify Page Loaded
    PO_RegistrationHistory.View specific month Registration  ${month}  ${year}
    PO_Dashboard.Verify Page Loaded

Search Display Plan
    [Arguments]  ${start_month}  ${end_month}
    PO_RegistrationHistory.Input start month  ${start_month}
    PO_RegistrationHistory.Input end month  ${end_month}
    PO_RegistrationHistory.Click button search
    PO_RegistrationHistory.Verify Page Loaded

Exist Display Plan
    [Arguments]  ${time}
    PO_RegistrationHistory.Verify exist data display plan  ${time}

Not Exist Display Plan
    PO_RegistrationHistory.Verify not exist data display plan

Submit Creating New Display Plan
    [Arguments]  ${epx_mth}  ${epx_yr}
    PO_RegistrationHistory.Create new display plan
    PO_RegistrationHistory.Submit new display plan  ${epx_mth}  ${epx_yr}
    PO_Dashboard.Verify Page Loaded

Cancel Creating New Display Plan
    PO_RegistrationHistory.Create new display plan
    PO_RegistrationHistory.Cancel new display plan
    PO_RegistrationHistory.Verify Page Loaded

Edit Detailed Display Plan
    PO_Dashboard.Click button Edit Display Plan
    PO_DetailedDisplayPlan_Step1.Update working window
    PO_DetailedDisplayPlan_Step1.Verify Page Loaded

Wait table Summary effective Investment loaded
    PO_DetailedDisplayPlan_Step1.Wait table Summary Invest visible

Filter BY Catgroup Default
    PO_DetailedDisplayPlan_Step1.Filter by Catgroup Default

Filter BY Catgroup DBB
    PO_DetailedDisplayPlan_Step1.Filter by Catgroup DBB
    PO_DetailedDisplayPlan_Step1.Verify Page Loaded

Filter BY Catgroup IFT
    PO_DetailedDisplayPlan_Step1.Filter by Catgroup IFT
    PO_DetailedDisplayPlan_Step1.Verify Page Loaded

Filter BY Catgroup DBB&IFT
    PO_DetailedDisplayPlan_Step1.Filter by Catgroup DBB&IFT
    PO_DetailedDisplayPlan_Step1.Verify Page Loaded

Filter BY Modelgroup U KE DBB
    PO_DetailedDisplayPlan_Step1.Filter by Modelgroup U KE DBB
    PO_DetailedDisplayPlan_Step1.Verify Page Loaded

Deselect Filter BY Catgroup DBB
    PO_DetailedDisplayPlan_Step1.Deselect Filter by Catgroup DBB
    PO_DetailedDisplayPlan_Step1.Verify Page Loaded

Deselect Filter BY Catgroup IFT
    PO_DetailedDisplayPlan_Step1.Deselect Filter by Catgroup IFT
    PO_DetailedDisplayPlan_Step1.Verify Page Loaded

Deselect Filter BY Catgroup DBB&IFT
    PO_DetailedDisplayPlan_Step1.Deselect Filter by Catgroup DBB&IFT
    PO_DetailedDisplayPlan_Step1.Verify Page Loaded

Adjust Values Invest And Growth
    [Arguments]  ${invest}  ${growth}
    PO_DetailedDisplayPlan_Step1.adjust value INVEST     ${invest}
    PO_DetailedDisplayPlan_Step1.adjust value GROWTH     ${growth}

Search a outlet code of Group DauTuChuaHieuQua to edit display plan of this outlet
    [Arguments]  ${outlet_code}=None
    PO_DetailedDisplayPlan_Step1.Insert outlet code into box search      ${outlet_code}
    PO_DetailedDisplayPlan_Step1.Click button search outlet
    ${result} =  PO_DetailedDisplayPlan_Step1.Verify outlet code searched present of Group DauTuChuaHieuQua
    should be equal as strings  ${outlet_code}  ${result}
    PO_DetailedDisplayPlan_Step1.Edit outlet and verify window detail display plan of outlet is show Group DauTuChuaHieuQua

Search a outlet code of Group DauTuHieuQua to edit display plan of this outlet
    [Arguments]  ${outlet_code}=None
    PO_DetailedDisplayPlan_Step1.Insert outlet code into box search      ${outlet_code}
    PO_DetailedDisplayPlan_Step1.Click button search outlet
    ${result} =  PO_DetailedDisplayPlan_Step1.Verify outlet code searched present of Group DauTuHieuQua
    should be equal as strings  ${outlet_code}  ${result}
    PO_DetailedDisplayPlan_Step1.Edit outlet and verify window detail display plan of outlet is show Group DauTuHieuQua

Search a outlet code of Group DautTuTangTruong to edit display plan of this outlet
    [Arguments]  ${outlet_code}=None
    PO_DetailedDisplayPlan_Step1.Insert outlet code into box search      ${outlet_code}
    PO_DetailedDisplayPlan_Step1.Click button search outlet
    ${result} =  PO_DetailedDisplayPlan_Step1.Verify outlet code searched present of Group DautTuTangTruong
    should be equal as strings  ${outlet_code}  ${result}
    PO_DetailedDisplayPlan_Step1.Edit outlet and verify window detail display plan of outlet is show Group DautTuTangTruong

Search a outlet code of Group KhongNenDauTu to edit display plan of this outlet
    [Arguments]  ${outlet_code}=None
    PO_DetailedDisplayPlan_Step1.Insert outlet code into box search      ${outlet_code}
    PO_DetailedDisplayPlan_Step1.Click button search outlet

    ${result} =  PO_DetailedDisplayPlan_Step1.Verify outlet code searched present of Group KhongNenDauTu
    should be equal as strings  ${outlet_code}  ${result}
    PO_DetailedDisplayPlan_Step1.Edit outlet and verify window detail display plan of outlet is show Group KhongNenDauTu