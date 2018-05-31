*** Settings ***
Library  Selenium2Library

*** Variables ***


*** Keywords ***
Access Page Registration History
    click element  xpath=//*[@id="monthlyRegister"]
    click element  xpath=//*[@id="sePartialMonthlyRegister"]

Access Page Additional/Cancel Registration
    click element  xpath=//*[@id="monthlyRegister"]
    click element  xpath=//*[@id="asmPartialMonthlyRegister"]

Access Page Report Display Plan
    click element  xpath=//*[@id="dropdownMenu4"]
    click element  xpath=//*[@id="collapseEx2"]/ul/li[2]/div/a[1]

Access Page Report FF, CHDD
    click element  xpath=//*[@id="dropdownMenu4"]
    click element  xpath=//*[@id="collapseEx2"]/ul/li[2]/div/a[2]

Access Page Report Money LocaionCost
    click element  xpath=//*[@id="dropdownMenu4"]
    click element  xpath=//*[@id="collapseEx2"]/ul/li[2]/div/a[3]

