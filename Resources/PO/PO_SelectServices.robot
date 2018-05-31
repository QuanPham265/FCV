*** Settings ***
Library  Selenium2Library

*** Variables ***

*** Keywords ***
Verify Page Loaded
    wait until page contains element  xpath=//*[@id="collapseEx2"]/ul/li[1]/a

Select Dislpay Registration Program
    click element  xpath=/html/body/main/div/a[1]/div/div/div[2]/p

Update working window
    select window  title=FrieslandCampina Vietnam™ -
