*** Settings ***
Resource  C:/FCV/Resources/Common.robot
Resource  C:/FCV/Resources/SignIn.robot
Resource  C:/FCV/Resources/VerifyData.robot
Resource  C:/FCV/Resources/ViewElement.robot
Library  Dialogs
Library  C:/FCV/Libraries/Csv.py

#Test Setup          Common.Begin Web Test
#Test Teardown       Custom Test Teardown

# How to run this Test Suite
# pybot -d C:/results/trial -i demo tests/trial/Data_Driven.robot
# pybot -d C:/results/trial         tests/trial/Data_Driven.robot

*** Variables ***
${FILE_CSV_PATH} =  C:\\FCV\\Tests\\trial\\User.csv

*** Keywords ***
Custom Test Teardown
    run keyword if test failed   Mark Bug Ticket    ${TEST DOCUMENTATION}
    Common.End Web Test


*** Test Cases ***
Get CSV Data
    ${Data} =  read csv file  ${FILE_CSV_PATH}
    log to console      ${Data}
    log list  ${Data}

