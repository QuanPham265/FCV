*** Settings ***
Library  Selenium2Library
Library  DatabaseLibrary
Library  String
Library  OperatingSystem
Library  Collections
Library  C:/Python27/Lib/site-packages/robot/libraries/DateTime.py

*** Variables ***
${ID_Button_Edit_DisplayPlan} =     /html/body/main/div/div[2]/div[1]/div/table/tbody/tr[3]/td[1]/div/a
${ID_Status_DisplayPlan} =          /html/body/main/div/div[2]/div[1]/div/table/tbody/tr[2]/td[1]/div/span[1]
${ID_Infor_Distributor} =           /html/body/main/div/div[2]/div[1]/div/table/tbody/tr[2]/td[1]/div/span[2]
${ID_Username} =                    /html/body/main/div/div[2]/div[1]/div/table/tbody/tr[1]/td[1]/div

#C:\FCV\Resources\PO\PO_Dashboard.robot
*** Keywords ***
Verify Page Loaded
    wait until page contains element  xpath=//*[@id="dashboard-container"]/div[2]/div/div[1]/div[1]/span
    sleep  2s

Update working window
    select window   title=FrieslandCampina Vietnam - Title
    sleep  2s

View as Catgroup
    click element  xpath=//*[@id="dashboard-container"]/div[2]/div/div[1]/div[2]/div/fieldset[1]/label

View as Modelgroup
    click element  xpath=//*[@id="dashboard-container"]/div[2]/div/div[1]/div[2]/div/fieldset[2]/label

################
## SALE FORCE ##
################
Click button Edit Display Plan
    click element  xpath=${ID_Button_Edit_DisplayPlan}

Click export data
    click element  xpath=//*[@id="dashboard-container"]/div[1]/div/table/tbody/tr[3]/td[1]/div/a[2]

Get distributor code
    ${Infor_Distributor} =  get text  xpath=${ID_Infor_Distributor}
    [Return]  ${Infor_Distributor}

Get User name
    ${Infor_Username} =  get text  xpath=${ID_Username}
    [Return]  ${Infor_Username}

Get status of display plan
    ${Infor_Status} =  get text  xpath=${ID_Status_DisplayPlan}
    [Return]  ${Infor_Status}


###############
##  CHART 1  ##
###############
Get number of outlet in chart 1 include tota, target, reality
    ${total_nb_outlet} =     get text    xpath=//*[@id="dashboard-container"]/div[2]/div/div[4]/div/div/table/tbody/tr[2]/td[2]/span
    ${target_nb_outlet} =    get text    xpath=//*[@id="dashboard-container"]/div[2]/div/div[4]/div/div/table/tbody/tr[2]/td[3]/span
    ${reality_nb_outlet} =   get text    xpath=//*[@id="dashboard-container"]/div[2]/div/div[4]/div/div/table/tbody/tr[2]/td[4]/span
    ${remain_nb_outlet} =    get text    xpath=//*[@id="dashboard-container"]/div[2]/div/div[4]/div/div/table/tbody/tr[2]/td[5]/span
    ${percent_complete} =    get text    xpath=//*[@id="dashboard-container"]/div[2]/div/div[4]/div/div/table/tbody/tr[2]/td[6]

    log many  ${total_nb_outlet}  ${target_nb_outlet}  ${reality_nb_outlet}  ${remain_nb_outlet}  ${percent_complete}



###############
##  CHART 2  ##
###############
Get number outlet target
    ${IFT_target_nb} =  get element attribute  xpath=//*[@id="chart-no-outlet-SE-89683"]/div/div[1]/div/div/table/tbody/tr[1]/td[2]
    ${DBB_target_nb} =  get element attribute  xpath=//*[@id="chart-no-outlet-SE-89683"]/div/div[1]/div/div/table/tbody/tr[1]/td[2]
    ${ALL_target_nb} =  get text  xpath=//*[@id="chart-no-outlet-SE-89683"]/div/div[1]/div/div/table/tbody/tr[1]/td[2]

    log many  ${IFT_target_nb}  ${DBB_target_nb}  ${ALL_target_nb}


###############
##  CHART 3  ##
###############