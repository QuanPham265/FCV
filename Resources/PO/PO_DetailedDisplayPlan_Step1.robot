*** Settings ***
Library  Selenium2Library
Library  DatabaseLibrary
Library  String
Library  OperatingSystem
Library  Collections
Library  Dialogs
Library  C:/Python27/Lib/site-packages/robot/libraries/DateTime.py

*** Variables ***
${Step1_title} =                FrieslandCampina Vietnam - Perfect Store - Step 1 Xây dựng kế hoạch trưng bày
${Step2_title} =                FrieslandCampina Vietnam - Perfect Store - Step 2 Xây dựng kế hoạch trưng bày
${Step3_title} =                FrieslandCampina Vietnam - Perfect Store - Step 3 Xây dựng kế hoạch trưng bày
${Step4_title} =                FrieslandCampina Vietnam - Perfect Store - Step 4 Xây dựng kế hoạch trưng bày
${ID_preloader} =               xpath=//*[@id="mdb-preloader"]
${ID_Table_SumInvet} =          xpath=//*[@id="sumInvestTable"]
${ID_Number_outlets} =          xpath=//*[@id="group_type"]/div/div[2]/dl/div/div[1]/div[1]
${ID_Contribute_Money} =        xpath=//*[@id="group_type"]/div/div[2]/dl/div/div[2]/table/tbody/tr[2]/td[2]/span
${ID_Contribute_Percent} =      xpath=//*[@id="group_type"]/div/div[2]/dl/div/div[2]/table/tbody/tr[1]/td[2]/span
${ID_Investment_Money} =        xpath=//*[@id="group_type"]/div/div[2]/dl/div/div[2]/table/tbody/tr[5]/td[2]/span
${ID_Investment_Percent} =      xpath=//*[@id="group_type"]/div/div[2]/dl/div/div[2]/table/tbody/tr[4]/td[2]/span
${ID_Group_Growth} =            xpath=//*[@id="group_type"]/div/div[2]/dl/div/div[2]/table/tbody/tr[3]/td[2]/span
${ID_Step1} =                   xpath=//*[@id="tab1"]
${ID_Step2} =                   xpath=//*[@id="tab2"]
${ID_Step3} =                   xpath=//*[@id="tab3"]
${ID_Step4} =                   xpath=//*[@id="tab4"]
${ID_invest} =                  xpath=//*[@id="inputInvestId"]
${ID_growth} =                  xpath=//*[@id="inputGrowthId"]
${ID_Box_Search} =              xpath=//*[@id="reviewPlans"]/div[3]/ul/li[6]/input
${ID_Search_Placeholder} =      xpath=//*[@id="reviewPlans"]/div[3]/ul/li[6]/input
${ID_Button_Search} =           xpath=//*[@id="reviewPlans"]/div[3]/ul/li[6]/button
${ID_Modelgp_History} =         xpath=//*[@id="salesHistoryTable"]/tbody/tr[%STT]/td[1]
${ID_Modelgp_Ele_Inv_His} =     xpath=//*[@id="salesHistoryTable"]/tbody/tr[%STT]/td[%ELE]

# Indicator detail content registeration last month
${ID_OutletModelGroupName} =    xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[2]
${ID_OutletModelName} =         xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[3]
${ID_Cashier} =                 xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[4]
${ID_DisplayPosition} =         xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[5]
${ID_LocationCost} =            xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[6]
${ID_Inv3months} =              xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[8]
${ID_PercentInvest} =           xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[9]

# Indicator detail content registeration current after user modify
${ID_OutletModelName_Edit} =    xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[2]/div/div[1]/input
${ID_DisplayPosition_Edit} =    xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[4]/div/div/input
${ID_LocationCost_Edit} =       xpath=//*[@id="nextMonthTable"]/tbody/tr[%ORDER_MODELGROUP]/td[5]

*** Keywords ***
Verify Page Loaded
    wait until element is not visible  ${ID_preloader}   timeout=90s

Update working window
    select window  title=${Step1_title}

Go to step 1
    click element  ${ID_Step1}
    wait until element is not visible  ${ID_preloader}   timeout=20s
    select window  title=${Step1_title}

Go to step 2
    click element  ${ID_Step2}
    wait until element is not visible  ${ID_preloader}   timeout=20s
    select window  title=${Step2_title}

Go to step 3
    click element  ${ID_Step3}
    wait until element is not visible  ${ID_preloader}   timeout=20s
    select window  title=${Step3_title}

Go to step 4
    click element  ${ID_Step4}
    wait until element is not visible  ${ID_preloader}   timeout=20s
    select window  title=${Step4_title}

Wait table Summary Invest visible
    wait until element is visible  ${ID_Table_SumInvet}  timeout=30s

#######################
### FILTER FUNCTION ###
#######################

Filter by Catgroup Default
    ${selected_catgroup} =  execute javascript  return $('#nganhHang').find('option:not(:disabled):selected').text()
    should be equal  ${selected_catgroup}  ${EMPTY}

Filter by Catgroup DBB
    click element  xpath=//*[@id="leftFilter"]/div[2]/div/input
    # eq(1): DBB
    #    ${selected_catgroup} =  execute javascript  return $('#nganhHang').find('option:not(:disabled):selected').text()
    execute javascript  $('#nganhHang').prev('ul').find('li:eq(1) label').click()
    click element  xpath=//*[@id="filterBtn"]

Filter by Catgroup IFT
    click element  xpath=//*[@id="leftFilter"]/div[2]/div/input
    # eq(2): IFT
    execute javascript  $('#nganhHang').prev('ul').find('li:eq(2) label').click()
    click element  xpath=//*[@id="filterBtn"]

Filter by Catgroup DBB&IFT
    click element  xpath=//*[@id="leftFilter"]/div[2]/div/input
    # eq(1&2): DBB&IFT
    execute javascript  $('#nganhHang').prev('ul').find('li:eq(1) label').click()
    execute javascript  $('#nganhHang').prev('ul').find('li:eq(2) label').click()
    click element  xpath=//*[@id="filterBtn"]

Filter by Modelgroup U KE DBB
    click element  xpath=//*[@id="leftFilter"]/div[2]/div/input
    # eq(1): U KE DBB
    execute javascript  $('#mucTrungBay').prev('ul').find('li:eq(1) label').click()
    click element  xpath=//*[@id="filterBtn"]

Deselect Filter by Catgroup DBB
    ${selected_catgroup} =  execute javascript  return $('#nganhHang').find('option:not(:disabled):selected').text()
    should be equal  ${selected_catgroup}  DBB
    click element  xpath=//*[@id="leftFilter"]/div[2]/div/input
    # eq(1): DBB
    execute javascript  $('#nganhHang').prev('ul').find('li:eq(1) label').click()
    click element  xpath=//*[@id="filterBtn"]

Deselect Filter by Catgroup IFT
    ${selected_catgroup} =  execute javascript  return $('#nganhHang').find('option:not(:disabled):selected').text()
    should be equal  ${selected_catgroup}  IFT
    click element  xpath=//*[@id="leftFilter"]/div[2]/div/input
    # eq(2): IFT
    execute javascript  $('#nganhHang').prev('ul').find('li:eq(2) label').click()
    click element  xpath=//*[@id="filterBtn"]

Deselect Filter by Catgroup DBB&IFT
    ${selected_catgroup} =  execute javascript  return $('#nganhHang').find('option:not(:disabled):selected').text()
    should be equal  ${selected_catgroup}  DBBIFT
    click element  xpath=//*[@id="leftFilter"]/div[2]/div/input
    # eq(1&2): DBB&IFT
    execute javascript  $('#nganhHang').prev('ul').find('li:eq(1) label').click()
    execute javascript  $('#nganhHang').prev('ul').find('li:eq(2) label').click()
    click element  xpath=//*[@id="filterBtn"]

#######################################
### MODIFY INVEST AND GROWTH VALUES ###
#######################################

get value INVEST
    ${invest} =  get value  ${ID_invest}
    [Return]  ${invest}

get value GROWTH
    ${invest} =  get value  ${ID_growth}
    [Return]  ${invest}

adjust value INVEST
    [Arguments]  ${value_invest}
    input text  ${ID_invest}    ${value_invest}

adjust value GROWTH
    [Arguments]  ${value_growth}
    input text  ${ID_growth}    ${value_growth}

click button apply invest and growth
    click element   xpath=//*[@id="check-plan-old"]/div[3]/div[4]

Reset default Invest, Growth
    click element  xpath=//*[@id="check-plan-old"]/div[3]/div[2]/button


############################
### GET INFOR EACH GROUP ###
############################
Get number outlets of each group
    [Arguments]  ${group_type}
    ${id_path} =    run keyword if   '${group_type}' == 'DauTuHieuQua'        replace string  ${ID_Number_outlets}  group_type  mustWinOutlet
    ...                    ELSE IF   '${group_type}' == 'DautTuTangTruong'    replace string  ${ID_Number_outlets}  group_type  investToCapture
    ...                    ELSE IF   '${group_type}' == 'DauTuChuaHieuQua'    replace string  ${ID_Number_outlets}  group_type  mainInvestment
    ...                    ELSE IF   '${group_type}' == 'KhongNenDauTu'       replace string  ${ID_Number_outlets}  group_type  stopInvestment

    ${rsl} =    get text              ${id_path}
    ${rsl} =    convert to integer    ${rsl}

    log         ${rsl}
    [Return]    ${rsl}

Get total outlets
    ${four_group} =     create list   DauTuHieuQua  DautTuTangTruong  DauTuChuaHieuQua  KhongNenDauTu
    ${total_outlet} =   set variable  0

    :FOR  ${grp}  IN   @{four_group}
    \   ${rsl} =  get number outlets of each group  ${grp}
    \   ${total_outlet} =  evaluate  ${rsl} + ${total_outlet}

    log       ${total_outlet}
    [Return]  ${total_outlet}

Get total contribute money of each group
    [Arguments]  ${group_type}
    ${id_path} =    run keyword if   '${group_type}' == 'DauTuHieuQua'        replace string  ${ID_Contribute_Money}  group_type  mustWinOutlet
    ...                    ELSE IF   '${group_type}' == 'DautTuTangTruong'    replace string  ${ID_Contribute_Money}  group_type  investToCapture
    ...                    ELSE IF   '${group_type}' == 'DauTuChuaHieuQua'    replace string  ${ID_Contribute_Money}  group_type  mainInvestment
    ...                    ELSE IF   '${group_type}' == 'KhongNenDauTu'       replace string  ${ID_Contribute_Money}  group_type  stopInvestment

    ${rsl} =    get text                ${id_path}
    ${rsl} =    remove string           ${rsl}   .
    ${rsl} =    convert to number       ${rsl}

    log         ${rsl}
    [Return]    ${rsl}

Get total contribute money of all group
    ${four_group} =     create list   DauTuHieuQua  DautTuTangTruong  DauTuChuaHieuQua  KhongNenDauTu
    ${total_outlet} =   set variable  0

    :FOR  ${grp}  IN   @{four_group}
    \   ${rsl} =  Get total contribute money of each group  ${grp}
    \   ${total_outlet} =  evaluate  ${rsl} + ${total_outlet}

    log       ${total_outlet}
    [Return]  ${total_outlet}

Get total contribute percent of each group
    [Arguments]  ${group_type}
    ${id_path} =    run keyword if   '${group_type}' == 'DauTuHieuQua'        replace string  ${ID_Contribute_Percent}  group_type  mustWinOutlet
    ...                    ELSE IF   '${group_type}' == 'DautTuTangTruong'    replace string  ${ID_Contribute_Percent}  group_type  investToCapture
    ...                    ELSE IF   '${group_type}' == 'DauTuChuaHieuQua'    replace string  ${ID_Contribute_Percent}  group_type  mainInvestment
    ...                    ELSE IF   '${group_type}' == 'KhongNenDauTu'       replace string  ${ID_Contribute_Percent}  group_type  stopInvestment

    ${rsl} =    get text                ${id_path}

    log         ${rsl}
    [Return]    ${rsl}

Get total investment money of each group
    [Arguments]  ${group_type}
    ${id_path} =    run keyword if   '${group_type}' == 'DauTuHieuQua'        replace string  ${ID_Investment_Money}  group_type  mustWinOutlet
    ...                    ELSE IF   '${group_type}' == 'DautTuTangTruong'    replace string  ${ID_Investment_Money}  group_type  investToCapture
    ...                    ELSE IF   '${group_type}' == 'DauTuChuaHieuQua'    replace string  ${ID_Investment_Money}  group_type  mainInvestment
    ...                    ELSE IF   '${group_type}' == 'KhongNenDauTu'       replace string  ${ID_Investment_Money}  group_type  stopInvestment

    ${rsl} =    get text                ${id_path}
    ${rsl} =    remove string           ${rsl}   .
    ${rsl} =    convert to number       ${rsl}

    log         ${rsl}
    [Return]    ${rsl}

Get total investment money of all group
    ${four_group} =     create list   DauTuHieuQua  DautTuTangTruong  DauTuChuaHieuQua  KhongNenDauTu
    ${total_outlet} =   set variable  0

    :FOR  ${grp}  IN   @{four_group}
    \   ${rsl} =  Get total contribute money of each group  ${grp}
    \   ${total_outlet} =  evaluate  ${rsl} + ${total_outlet}

    log       ${total_outlet}
    [Return]  ${total_outlet}

Get total investment percent of each group
    [Arguments]  ${group_type}
    ${id_path} =    run keyword if   '${group_type}' == 'DauTuHieuQua'        replace string  ${ID_Investment_Percent}  group_type  mustWinOutlet
    ...                    ELSE IF   '${group_type}' == 'DautTuTangTruong'    replace string  ${ID_Investment_Percent}  group_type  investToCapture
    ...                    ELSE IF   '${group_type}' == 'DauTuChuaHieuQua'    replace string  ${ID_Investment_Percent}  group_type  mainInvestment
    ...                    ELSE IF   '${group_type}' == 'KhongNenDauTu'       replace string  ${ID_Investment_Percent}  group_type  stopInvestment

    ${rsl} =    get text                ${id_path}

    log         ${rsl}
    [Return]    ${rsl}

Get growth value of each group
    [Arguments]  ${group_type}
    ${id_path} =    run keyword if   '${group_type}' == 'DauTuHieuQua'        replace string  ${ID_Group_Growth}  group_type  mustWinOutlet
    ...                    ELSE IF   '${group_type}' == 'DautTuTangTruong'    replace string  ${ID_Group_Growth}  group_type  investToCapture
    ...                    ELSE IF   '${group_type}' == 'DauTuChuaHieuQua'    replace string  ${ID_Group_Growth}  group_type  mainInvestment
    ...                    ELSE IF   '${group_type}' == 'KhongNenDauTu'       replace string  ${ID_Group_Growth}  group_type  stopInvestment

    ${rsl} =    get text                ${id_path}

    log         ${rsl}
    [Return]    ${rsl}

##############################
### SEARCH OUTLET FUNCTION ###
##############################
Insert outlet code into box search
    [Arguments]  ${code_outlet}
    input text  ${ID_Box_Search}  ${code_outlet}

Verify given placeholder in box search
    [Arguments]  ${given_placeholder}
    ${web_placeholder} =  get webelement  ${ID_Search_Placeholder}
    ${web_placeholder} =  get element attribute  ${ID_Search_Placeholder}
    should be equal as strings  ${given_placeholder}  ${web_placeholder}

Click button search outlet
    click element  ${ID_Button_Search}
    wait until page contains    Hiển thị từ 1 đến 1 của 1 cửa hàng  timeout=30s

Verify outlet code searched present of Group DauTuChuaHieuQua
    #Document: DauTuChuaHieuQua
    ${shown_outlet} =  get text  xpath=//*[@id="mainInvestmentTable_wrapper"]/div[2]/div/div/div[3]/div[2]/div/table/tbody/tr/td[3]/span
    [Return]  ${shown_outlet}

Verify outlet code searched present of Group DauTuHieuQua
    #Document: DauTuHieuQua
    ${shown_outlet} =  get text  xpath=//*[@id="mustWinOutletTable_wrapper"]/div[2]/div/div/div[3]/div[2]/div/table/tbody/tr/td[3]/span
    [Return]  ${shown_outlet}

Verify outlet code searched present of Group DautTuTangTruong
    #Document: DautTuTangTruong
    ${shown_outlet} =  get text  xpath=//*[@id="investToCaptureTable_wrapper"]/div[2]/div/div/div[3]/div[2]/div/table/tbody/tr/td[3]/span
    [Return]  ${shown_outlet}

Verify outlet code searched present of Group KhongNenDauTu
    #Document: KhongNenDauTu
    ${shown_outlet} =  get text  xpath=//*[@id="stopInvestmentTable_wrapper"]/div[2]/div/div/div[3]/div[2]/div/table/tbody/tr/td[3]/span
    [Return]  ${shown_outlet}

Edit outlet and verify window detail display plan of outlet is show Group DauTuChuaHieuQua
    click element                   xpath=//*[@id="mainInvestmentTable_wrapper"]/div[2]/div/div/div[3]/div[2]/div/table/tbody/tr/td[1]/a[1]
    wait until element is visible   xpath=//*[@id="detailModal"]/div/div/div[1]  timeout=10s
    wait until element is not visible   ${ID_preloader}   timeout=90s

Edit outlet and verify window detail display plan of outlet is show Group DauTuHieuQua
    click element                   xpath=//*[@id="mustWinOutletTable_wrapper"]/div[2]/div/div/div[3]/div[2]/div/table/tbody/tr/td[1]/a[1]
    wait until element is visible   xpath=//*[@id="detailModal"]/div/div/div[1]  timeout=10s
    wait until element is not visible   ${ID_preloader}   timeout=90s

Edit outlet and verify window detail display plan of outlet is show Group DautTuTangTruong
    click element                   xpath=//*[@id="investToCaptureTable_wrapper"]/div[2]/div/div/div[3]/div[2]/div/table/tbody/tr/td[1]/a[1]
    wait until element is visible   xpath=//*[@id="detailModal"]/div/div/div[1]  timeout=10s
    wait until element is not visible   ${ID_preloader}   timeout=90s

Edit outlet and verify window detail display plan of outlet is show Group KhongNenDauTu
    click element                       xpath=//*[@id="stopInvestmentTable_wrapper"]/div[2]/div/div/div[3]/div[2]/div/table/tbody/tr/td[1]/a[1]
    wait until element is visible       xpath=//*[@id="detailModal"]/div/div/div[1]  timeout=10s
    wait until element is not visible   ${ID_preloader}   timeout=90s

##########################
### OUTLET INFORMATION ###
##########################
Get information outlet code
    sleep  10s

##############################
### TABLE INVOICE HISTORY  ###
##############################

Get value invoice in past
    ${Nb_Modelgroup} =  Get Matching Xpath Count  //*[@id="salesHistoryTable"]/tbody/tr
    ${ls_modelgp} =     create list
    ${dict_modelgp} =   create dictionary

    :FOR  ${id}  IN RANGE    1  ${Nb_Modelgroup}+1
    \   ${id} =         convert to string   ${id}
    \   ${id_find} =    replace string      ${ID_Modelgp_History}  %STT  ${id}
    \   ${modelgp} =    get text            ${id_find}
    \   append to list  ${ls_modelgp}       ${modelgp}
    \   ${ls_invoice_ele} =  get element invoice of outlet history per model group   ${id}
    \   set to dictionary  ${dict_modelgp}  ${modelgp}  ${ls_invoice_ele}

    log dictionary  ${dict_modelgp}
    log list        ${ls_modelgp}
    [Return]  ${ls_modelgp}     ${dict_modelgp}

Get element invoice of outlet history per model group
    [Arguments]  ${seq_modelgp}
    ${ls_invoice_ele} =  create list
    :FOR  ${id}  IN RANGE  2  10
    \   ${id} =  convert to string  ${id}
    \   ${id_find} =  replace string  ${ID_Modelgp_Ele_Inv_His}  %STT       ${seq_modelgp}
    \   ${id_find} =  replace string  ${id_find}                 %ELE       ${id}
    \   ${inv_ele} =  get text  ${id_find}
    \   log  ${inv_ele}
    \   ${inv_ele} =  run keyword if     '${inv_ele}'!='${EMPTY}' and ${id}!=8 and ${id}!=9     transform invoice result   ${inv_ele}
    \   ...                  ELSE IF     '${inv_ele}'!='${EMPTY}' and ${id}==8                  transform percent result   ${inv_ele}
    \   ...                  ELSE IF     '${inv_ele}'!='${EMPTY}' and ${id}==9                  transform percent result   ${inv_ele}
    \   ...                  ELSE         set variable  0
    \   ${inv_ele} =  convert to number  ${inv_ele}  2
    \   log  ${inv_ele}
    \   append to list  ${ls_invoice_ele}  ${inv_ele}

    log many  ${ls_invoice_ele}
    [Return]  ${ls_invoice_ele}

transform invoice result
    [Arguments]  ${Inv_string}
    ${Inv_Num} =  fetch from left  ${Inv_string}  ${SPACE}
    ${Inv_Num} =  remove string  ${Inv_Num}  .
    ${Inv_Num} =  convert to number   ${Inv_Num}  0

    log         ${Inv_Num}
    [Return]    ${Inv_Num}

transform percent result
    [Arguments]  ${Inv_string}
    ${Inv_Num} =  fetch from left     ${Inv_string}  ${SPACE}
    ${Inv_Num} =  replace string      ${Inv_Num}  ,  .
    ${Inv_Num} =  convert to number   ${Inv_Num}

    log         ${Inv_Num}
    [Return]    ${Inv_Num}

############################
### DETAIL DISPLAY PLAN  ###
############################

Get outletmodel registered as default from last month
    ${dict_all_detail_modelgroup} =  create dictionary

    :FOR  ${idx}  IN RANGE    1  14  2
    \   ${idx} =  convert to string  ${idx}
    \   ${list_tenp} =                  create list
    \   log many  ${ID_OutletModelGroupName}  ${ID_OutletModelName}  ${ID_DisplayPosition}  ${ID_LocationCost}

    \   set test variable  ${OutletModelGroupName}          ${ID_OutletModelGroupName}
    \   set test variable  ${OutletModelName}               ${ID_OutletModelName}
    \   set test variable  ${OutletDisplayPosition}         ${ID_DisplayPosition}
    \   set test variable  ${OutletLocationCost}            ${ID_LocationCost}

    \   ${OutletModelGroupName} =    replace string  ${OutletModelGroupName}        %ORDER_MODELGROUP  ${idx}
    \   ${modelgroupname} =          get text        ${OutletModelGroupName}

    \   ${OutletModelName} =         replace string  ${OutletModelName}             %ORDER_MODELGROUP  ${idx}
    \   ${modelname} =               get text        ${OutletModelName}
    \   log  ${modelname}

    \   ${OutletDisplayPosition} =   replace string  ${OutletDisplayPosition}       %ORDER_MODELGROUP  ${idx}
    \   ${displayposition} =         get text        ${OutletDisplayPosition}

    \   ${OutletLocationCost} =      replace string  ${OutletLocationCost}          %ORDER_MODELGROUP  ${idx}
    \   ${locationcost} =            get text        ${OutletLocationCost}
    \   ${locationcost} =            remove string   ${locationcost}  .

    \   run keyword if   "${modelname}"=="${EMPTY}"   log to console  OKOKOK
    \   ...       ELSE                            append to list  ${list_tenp}  ${modelname}  ${displayposition}  ${locationcost}

    \   set to dictionary  ${dict_all_detail_modelgroup}  ${modelgroupname}  ${list_tenp}

    \   log list  ${list_tenp}
    \   log dictionary  ${dict_all_detail_modelgroup}

    log dictionary  ${dict_all_detail_modelgroup}
    [Return]        ${dict_all_detail_modelgroup}

Get Avg Invoice in three months on section detail for each modelgroup
    ${dict_Inv3months_modelgroup} =  create dictionary

    :FOR  ${idx}  IN RANGE    1  14  2
    \   ${idx} =  convert to string  ${idx}
    \   ${list_temp} =                  create list
    \   log many   ${ID_OutletModelGroupName}  ${ID_OutletModelName}  ${ID_Inv3months}  ${ID_PercentInvest}

    \   set test variable  ${OutletModelGroupName}  ${ID_OutletModelGroupName}
    \   set test variable  ${OutletModelName}       ${ID_OutletModelName}
    \   set test variable  ${Inv3months}            ${ID_Inv3months}
    \   set test variable  ${PercentInvest}         ${ID_PercentInvest}

    \   ${OutletModelGroupName} =    replace string  ${OutletModelGroupName}        %ORDER_MODELGROUP  ${idx}
    \   ${modelgroupname} =          get text        ${OutletModelGroupName}

    \   ${OutletModelName} =         replace string  ${OutletModelName}             %ORDER_MODELGROUP  ${idx}
    \   ${modelname} =               get text        ${OutletModelName}
    \   log  ${modelname}

    \   ${Inv3months} =             replace string     ${Inv3months}                   %ORDER_MODELGROUP  ${idx}
    \   ${Inv3months} =             get text           ${Inv3months}

    \   ${Inv3months} =             run keyword if  "${Inv3months}" != "${EMPTY}"   remove string        ${Inv3months}  .           ELSE   set variable  ${EMPTY}
    \   ${Inv3months} =             run keyword if  "${Inv3months}" != "${EMPTY}"   fetch from left      ${Inv3months}  ${SPACE}    ELSE   set variable  ${EMPTY}
    \   ${Inv3months} =             run keyword if  "${Inv3months}" != "${EMPTY}"   convert to number    ${Inv3months}  0           ELSE   set variable  0

    \   ${PercentInvest} =          replace string  ${PercentInvest}                %ORDER_MODELGROUP  ${idx}
    \   ${PercentInvest} =          get text        ${PercentInvest}
    \   ${PercentInvest} =          remove string   ${PercentInvest}                %
    \   ${PercentInvest} =          replace string  ${PercentInvest}                ,        .

#    \   run keyword if   "${modelname}"=="${EMPTY}"     log to console     OKOKOK
#    \   ...       ELSE                                  append to list     ${list_temp}   ${modelname}  ${Inv3months}  ${PercentInvest}

    \   append to list     ${list_temp}   ${modelname}  ${Inv3months}  ${PercentInvest}
    \   set to dictionary  ${dict_Inv3months_modelgroup}  ${modelgroupname}  ${list_temp}
    \   log dictionary     ${dict_Inv3months_modelgroup}

    log dictionary  ${dict_Inv3months_modelgroup}
    [Return]        ${dict_Inv3months_modelgroup}

####################################
###  TABLE EFFECTIVE INVESTMENT  ###
####################################
Get number outlets in two aspect target and reality
    ${DBB_target} =   get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[1]/td[2]/span
    ${DBB_reality} =  get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[1]/td[3]/span
    ${IFT_target} =   get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[2]/td[2]/span
    ${IFT_reality} =  get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[2]/td[3]/span
    ${ALL_target} =   get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[3]/td[2]/span
    ${ALL_reality} =  get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[3]/td[3]/span

    ${Number_Outlet_DBB} =      create list  ${DBB_target}  ${DBB_reality}
    ${Number_Outlet_IFT} =      create list  ${IFT_target}  ${IFT_reality}
    ${Number_Outlet_ALL} =      create list  ${ALL_target}  ${ALL_reality}
    log many  ${Number_Outlet_DBB}  ${Number_Outlet_IFT}  ${Number_Outlet_ALL}
    [Return]  ${Number_Outlet_DBB}  ${Number_Outlet_IFT}  ${Number_Outlet_ALL}

Get Invoice Contribute of Whole distributor, register display outlet and percentage Contribution
    [Arguments]  ${catgroup}
    ${DBB_Invoice_all_distributor} =            get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[1]/td[4]/span
    ${DBB_Invoice_outlet_registerdisplay} =     get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[1]/td[5]/span
    ${DBB_Percent_Contribute} =                 get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[1]/td[6]/span
    ${IFT_Invoice_all_distributor} =            get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[2]/td[4]/span
    ${IFT_Invoice_outlet_registerdisplay} =     get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[2]/td[5]/span
    ${IFT_Percent_Contribute} =                 get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[2]/td[6]/span
    ${ALL_Invoice_all_distributor} =            get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[3]/td[4]/span
    ${ALL_Invoice_outlet_registerdisplay} =     get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[3]/td[5]/span
    ${ALL_Percent_Contribute} =                 get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[3]/td[6]/span

    ${return_Invoice_all_distributor} =         set variable if
    ...          "${catgroup}" == "DBB"         ${DBB_Invoice_all_distributor}
    ...          "${catgroup}" == "IFT"         ${IFT_Invoice_all_distributor}
    ...          "${catgroup}" == "ALL"         ${ALL_Invoice_all_distributor}
    ${return_Invoice_all_distributor} =         fetch from left    ${return_Invoice_all_distributor}   ,
    ${return_Invoice_all_distributor} =         remove string      ${return_Invoice_all_distributor}   .
    ${return_Invoice_all_distributor} =         convert to number  ${return_Invoice_all_distributor}

    ${return_Invoice_outlet_registerdisplay} =  set variable if
    ...          "${catgroup}" == "DBB"         ${DBB_Invoice_outlet_registerdisplay}
    ...          "${catgroup}" == "IFT"         ${IFT_Invoice_outlet_registerdisplay}
    ...          "${catgroup}" == "ALL"         ${ALL_Invoice_outlet_registerdisplay}
    ${return_Invoice_outlet_registerdisplay} =         fetch from left    ${return_Invoice_outlet_registerdisplay}   ,
    ${return_Invoice_outlet_registerdisplay} =         remove string      ${return_Invoice_outlet_registerdisplay}   .
    ${return_Invoice_outlet_registerdisplay} =         convert to number  ${return_Invoice_outlet_registerdisplay}

    ${return_Percent_Contribute} =              set variable if
    ...          "${catgroup}" == "DBB"         ${DBB_Percent_Contribute}
    ...          "${catgroup}" == "IFT"         ${IFT_Percent_Contribute}
    ...          "${catgroup}" == "ALL"         ${ALL_Percent_Contribute}
    ${return_Percent_Contribute} =         fetch from left    ${return_Percent_Contribute}   ${SPACE}
    ${return_Percent_Contribute} =         convert to number  ${return_Percent_Contribute}

    log many  ${return_Invoice_all_distributor}  ${return_Invoice_outlet_registerdisplay}  ${return_Percent_Contribute}
    [Return]  ${return_Invoice_all_distributor}  ${return_Invoice_outlet_registerdisplay}  ${return_Percent_Contribute}

Get Location cost, display cost, total invest cost and percentage investment
    [Arguments]  ${catgroup}
    ${DBB_Location_cost} =                      get text  xpath=//*[@id="location_budget_3_DBB"]
    ${DBB_Display_cost} =                       get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[1]/td[8]/span
    ${DBB_Total_Investment} =                   get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[1]/td[9]/span
    ${DBB_Percentage_Investment} =              get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[1]/td[10]/span

    ${IFT_Location_cost} =                      get text  xpath=//*[@id="location_budget_3_IFT"]
    ${IFT_Display_cost} =                       get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[2]/td[8]/span
    ${IFT_Total_Investment} =                   get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[2]/td[9]/span
    ${IFT_Percentage_Investment} =              get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[2]/td[10]/span

    ${ALL_Location_cost} =                      get text  xpath=//*[@id="location_budget_3_total"]
    ${ALL_Display_cost} =                       get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[3]/td[8]/span
    ${ALL_Total_Investment} =                   get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[3]/td[9]/span
    ${ALL_Percentage_Investment} =              get text  xpath=//*[@id="sumInvestTable"]/tbody/tr[3]/td[10]/span

    ${return_Location_cost} =                   set variable if
    ...          "${catgroup}" == "DBB"         ${DBB_Location_cost}
    ...          "${catgroup}" == "IFT"         ${IFT_Location_cost}
    ...          "${catgroup}" == "ALL"         ${ALL_Location_cost}
    ${return_Location_cost} =                   remove string      ${return_Location_cost}   .
    ${return_Location_cost} =                   convert to number  ${return_Location_cost}

    ${return_Display_cost} =                    set variable if
    ...          "${catgroup}" == "DBB"         ${DBB_Display_cost}
    ...          "${catgroup}" == "IFT"         ${IFT_Display_cost}
    ...          "${catgroup}" == "ALL"         ${ALL_Display_cost}
    ${return_Display_cost} =                    remove string      ${return_Display_cost}   .
    ${return_Display_cost} =                    convert to number  ${return_Display_cost}

    ${return_Total_Investment} =                set variable if
    ...          "${catgroup}" == "DBB"         ${DBB_Total_Investment}
    ...          "${catgroup}" == "IFT"         ${IFT_Total_Investment}
    ...          "${catgroup}" == "ALL"         ${ALL_Total_Investment}
    ${return_Total_Investment} =                remove string      ${return_Total_Investment}   .
    ${return_Total_Investment} =                convert to number  ${return_Total_Investment}

    ${return_Percentage_Investment} =              set variable if
    ...          "${catgroup}" == "DBB"         ${DBB_Percentage_Investment}
    ...          "${catgroup}" == "IFT"         ${IFT_Percentage_Investment}
    ...          "${catgroup}" == "ALL"         ${ALL_Percentage_Investment}
    ${return_Percentage_Investment} =           fetch from left    ${return_Percentage_Investment}   ${SPACE}
    ${return_Percentage_Investment} =           convert to number  ${return_Percentage_Investment}

    log many  ${return_Location_cost}  ${return_Display_cost}  ${return_Total_Investment}  ${return_Percentage_Investment}
    [Return]  ${return_Location_cost}  ${return_Display_cost}  ${return_Total_Investment}  ${return_Percentage_Investment}

#############################
###  MODIFY DISPLAY PLAN  ###
#############################
Edit fields in ModelGroup U Ke DBB
    [Arguments]  ${outlet_model}
    click element      xpath=//*[@id="nextMonthTable"]/tbody/tr[2]/td[1]/div
    ${javascript} =    set variable  $("select[outletModelGroupid = 34]").find($("option[value = %OUTLET_MODEL_ID]")).prop('selected',true);$(".mdb-select").material_select('destroy');$(".mdb-select").material_select();

    ${outlet_model_id} =  set variable if
    ...        "${outlet_model}" == "CHDD"          287
    ...        "${outlet_model}" == "U_DBB"         289
    ...        "${outlet_model}" == "U_DBB_CH"      290
    ...        "${outlet_model}" == "KE_DBB"        292
    ...        "${outlet_model}" == "KE_DBB_CH"     293
    ...        "${outlet_model}" == "U_CHUAN_KE"    294
    ...        "${outlet_model}" == "FUN_4_KIDS"    301
    ...        "${outlet_model}" == "MINI_DBB_KE"   385
    ...        "${outlet_model}" == "MINI_DBB_WF"   386

    ${javascript} =  replace string  ${javascript}  %OUTLET_MODEL_ID  ${outlet_model_id}
    log  ${javascript}
    execute javascript  ${javascript}

Edit fields in ModelGroup U IFT
    [Arguments]  ${outlet_model}
    click element      xpath=//*[@id="nextMonthTable"]/tbody/tr[2]/td[1]/div
    ${javascript} =    set variable  $("select[outletModelGroupid = 50]").find($("option[value = %OUTLET_MODEL_ID]")).prop('selected',true);$(".mdb-select").material_select('destroy');$(".mdb-select").material_select();

    ${outlet_model_id} =  set variable if
    ...        "${outlet_model}" == "U90_FRISO"          362

    ${javascript} =  replace string  ${javascript}  %OUTLET_MODEL_ID  ${outlet_model_id}
    log  ${javascript}
    execute javascript  ${javascript}

Edit fields in ModelGroup SCM
    [Arguments]  ${outlet_model}
    click element      xpath=//*[@id="nextMonthTable"]/tbody/tr[2]/td[1]/div
    ${javascript} =    set variable  $("select[outletModelGroupid = 35]").find($("option[value = %OUTLET_MODEL_ID]")).prop('selected',true);$(".mdb-select").material_select('destroy');$(".mdb-select").material_select();

    ${outlet_model_id} =  set variable if
    ...        "${outlet_model}" == "KE_SCM"             297
    ...        "${outlet_model}" == "KE_SCM_CH"          298

    ${javascript} =  replace string  ${javascript}  %OUTLET_MODEL_ID  ${outlet_model_id}
    log  ${javascript}
    execute javascript  ${javascript}

Edit fields in ModelGroup KE FINO
    [Arguments]  ${outlet_model}
    click element      xpath=//*[@id="nextMonthTable"]/tbody/tr[2]/td[1]/div
    ${javascript} =    set variable  $("select[outletModelGroupid = 55]").find($("option[value = %OUTLET_MODEL_ID]")).prop('selected',true);$(".mdb-select").material_select('destroy');$(".mdb-select").material_select();

    ${outlet_model_id} =  set variable if
    ...        "${outlet_model}" == "FINO"             377

    ${javascript} =  replace string  ${javascript}  %OUTLET_MODEL_ID  ${outlet_model_id}
    log  ${javascript}
    execute javascript  ${javascript}

Edit fields in ModelGroup SUA BOT FRISO
    [Arguments]  ${outlet_model}
    click element      xpath=//*[@id="nextMonthTable"]/tbody/tr[2]/td[1]/div
    ${javascript} =    set variable  $("select[outletModelGroupid = 39]").find($("option[value = %OUTLET_MODEL_ID]")).prop('selected',true);$(".mdb-select").material_select('destroy');$(".mdb-select").material_select();

    ${outlet_model_id} =  set variable if
    ...        "${outlet_model}" == "FRISO_6_MAT"               321
    ...        "${outlet_model}" == "FRISO_12_MAT"              323
    ...        "${outlet_model}" == "FRISO_24_MAT"              324
    ...        "${outlet_model}" == "FRISO_48_MAT"              327
    ...        "${outlet_model}" == "FRISO_72_MAT"              328
    ...        "${outlet_model}" == "FRISO_96_MAT"              329
    ...        "${outlet_model}" == "FRISO_144_MAT"             330
    ...        "${outlet_model}" == "FF"                        354

    ${javascript} =  replace string  ${javascript}  %OUTLET_MODEL_ID  ${outlet_model_id}
    log  ${javascript}
    execute javascript  ${javascript}

Edit fields in ModelGroup NGUYEN KEM
    [Arguments]  ${outlet_model}
    click element      xpath=//*[@id="nextMonthTable"]/tbody/tr[2]/td[1]/div
    ${javascript} =    set variable  $("select[outletModelGroupid = 37]").find($("option[value = %OUTLET_MODEL_ID]")).prop('selected',true);$(".mdb-select").material_select('destroy');$(".mdb-select").material_select();

    ${outlet_model_id} =  set variable if
    ...        "${outlet_model}" == "NK_6_MAT"               304
    ...        "${outlet_model}" == "NK_12_MAT"              306
    ...        "${outlet_model}" == "NK_24_MAT"              307

    ${javascript} =  replace string  ${javascript}  %OUTLET_MODEL_ID  ${outlet_model_id}
    log  ${javascript}
    execute javascript  ${javascript}

Edit fields in ModelGroup FRISTI KE HINH CHAI
    [Arguments]  ${outlet_model}
    click element      xpath=//*[@id="nextMonthTable"]/tbody/tr[2]/td[1]/div
    ${javascript} =    set variable  $("select[outletModelGroupid = 59]").find($("option[value = %OUTLET_MODEL_ID]")).prop('selected',true);$(".mdb-select").material_select('destroy');$(".mdb-select").material_select();

    ${outlet_model_id} =  set variable if
    ...        "${outlet_model}" == "U_FRISTI_HC"               391

    ${javascript} =  replace string  ${javascript}  %OUTLET_MODEL_ID  ${outlet_model_id}
    log  ${javascript}
    execute javascript  ${javascript}

Get each outletmodel just modified this month
    [Arguments]  ${outlet_modegroup}
    ${dict_modelgroup} =  create dictionary   U_KE_DBB=2  U_IFT=4  SCM=6  KE_FINO=8    SUA_BOT_FRISO=10  NGUYEN_KEM=12   FRISTI_KE_HINH_CHAI=14

    ${idx} =  get from dictionary  ${dict_modelgroup}   ${outlet_modegroup}
    ${idx} =  convert to string  ${idx}
    log  ${idx}

    set test variable            ${OutletModelName}     ${ID_OutletModelName_Edit}
    ${OutletModelName} =         replace string         ${OutletModelName}             %ORDER_MODELGROUP  ${idx}
    ${modelname} =               get value              ${OutletModelName}
    log  ${modelname}
    [Return]  ${modelname}