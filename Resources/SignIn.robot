*** Settings ***
Resource  C:/FCV/Resources/PO/PO_Login.robot
Resource  C:/FCV/Resources/PO/PO_SelectServices.robot

*** Variables ***


*** Keywords ***
Navigate to web Perfect Store
    [Arguments]  ${url}
    PO_Login.Navigate To  ${url}
    PO_Login.Verify Page Loaded

Login system
    [Arguments]  ${username}  ${password}
    PO_Login.Enter UserName  ${username}
    PO_Login.Enter Password  ${password}
    PO_Login.Click button Login
    PO_SelectServices.Verify Page Loaded
    PO_SelectServices.Select Dislpay Registration Program

