*** Settings ***
Library  Selenium2Library
Library  DatabaseLibrary
Library  String
Library  OperatingSystem
Library  Collections
Library  C:/Python27/Lib/site-packages/robot/libraries/DateTime.py

*** Variables ***
${ID_View_Registration} =       xpath=//*[@id="registration'month'/'year'"]/td[3]
${ID_Registration_042018} =     xpath=//*[@id="registration04/2018"]/td[3]
${ID_Registration_032018} =     xpath=//*[@id="registration03/2018"]/td[3]
${ID_Registration_022018} =     xpath=//*[@id="registration02/2018"]/td[3]
${ID_Registration_012018} =     xpath=//*[@id="registration01/2018"]/td[3]
${ID_Registration_122017} =     xpath=//*[@id="registration12/2017"]/td[3]
${ID_Registration_112017} =     xpath=//*[@id="registration11/2017"]/td[3]
${ID_Registration_102017} =     xpath=//*[@id="registration10/2017"]/td[3]
${ID_Registration_092017} =     xpath=//*[@id="registration09/2017"]/td[3]
${ID_Registration_082017} =     xpath=//*[@id="registration08/2017"]/td[3]
${ID_Registration_072017} =     xpath=//*[@id="registration07/2017"]/td[3]
${ID_Registration_062017} =     xpath=//*[@id="registration06/2017"]/td[3]

${ID_New_DisplayPlan} =         xpath=/html/body/main/form/div[2]/div/a


*** Keywords ***
Update working window
    select window  title=FrieslandCampina Vietnam - Quản lý nhà phân phối

Verify Page Loaded
    wait until page contains element  id=monthlyRegister

View specific month Registration
    [Arguments]  ${month}  ${year}
    ${month} =  run keyword if  ${month} == 1 or ${month} == 2 or ${month} == 3 or ${month} == 4 or ${month} == 5 or ${month} == 6 or ${month} == 7 or ${month} == 8 or ${month} == 9  Modify date  ${month}
    ${view_Registration_xpath} =  replace string  ${ID_View_Registration}  'month'/'year'  ${month}/${year}
    click element  ${view_Registration_xpath}
    sleep  2s

Modify date
    [Arguments]  ${month}
    ${month} =  evaluate  '0' + str(${month})
    [Return]  ${month}

Input start month
    [Arguments]  ${start_month}
    input text  fromDate  ${start_month}

Input end month
    [Arguments]  ${end_month}
    input text  toDate  ${end_month}

Click button search
    click element  btnSearch

Verify not exist data display plan
    wait until page contains  Không có dữ liệu

Verify exist data display plan
    [Arguments]  ${time}
    ${count} =  get matching xpath count  //*[@id="listForm"]/div[3]/table/tbody/tr
    should not be equal as numbers  ${count}  0
    log  ${count}
    ${time_path} =  replace string  ${ID_View_Registration}  'month'/'year'  ${time}
    page should contain element  ${time_path}

Create new display plan
    click element  ${ID_New_DisplayPlan}

Submit new display plan
    [Arguments]  ${epx_month}   ${epx_year}
    # Verify month selected is next month
    ${rsl_month} =   get value           xpath=/html/body/main/form/div/div/div/div[2]/div/div[1]/div/div/input
    ${rsl_month} =   convert to integer  ${rsl_month}
    ${rsl_year} =    get value           xpath=/html/body/main/form/div/div/div/div[2]/div/div[2]/div/div/input
    ${rsl_year} =    convert to integer  ${rsl_year}
    should be equal as integers  ${epx_month}      ${rsl_month}
    should be equal as integers  ${epx_year}       ${rsl_year}
    click element  xpath=//*[@id="submit"]

Cancel new display plan
    click element  xpath=/html/body/main/form/div/div/div/div[3]/a[1]

Get current day
    ${currentday} =  get current date  result_format=datetime
    [Return]  ${currentday}


