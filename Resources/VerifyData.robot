*** Settings ***
Resource  C:/FCV/Resources/Postgres_Server.robot
Resource  C:/FCV/Resources/PO/PO_Dashboard.robot
Resource  C:/FCV/Resources/PO/PO_DetailedDisplayPlan_Step1.robot
Resource  C:/FCV/Resources/PO/PO_TopHeader.robot
Resource  C:/FCV/Resources/ViewElement.robot

Library  C:/FCV/Libraries/EditString.py

*** Variables ***
${curt_step1} =     0
${lastmth_step4} =  0

*** Keywords ***
Verify general information on Dashboard
    [Arguments]  ${user_name}  ${distributor_code}
    ${web_distributor_code} =       PO_Dashboard.Get distributor code
    ${web_user_name} =              PO_Dashboard.Get User name

    should be equal    ${web_distributor_code}      ${distributor_code}
    should be equal    ${web_user_name}             ${user_name}

Verify status of display plan
    [Arguments]    ${status_displayplan}
    ${web_status_displayplan} =     PO_Dashboard.Get status of display plan
    should be equal    ${web_status_displayplan}    ${status_displayplan}


Verify data in table 1
    PO_Dashboard.Get number of outlet in chart 1 include tota, target, reality
    PO_Dashboard.Get number outlet target

Verify total outlets shift to Step 1
    [Documentation]  Compare number outlets in step 1 of current month with number in step 4 last month
    [Arguments]  ${test_month}  ${last_month}  ${year}
    ${curt_step1} =  PO_DetailedDisplayPlan_Step1.Get total outlets
    PO_TopHeader.Access Page Registration History
    ViewElement.View display plan  ${last_month}  ${year}
    PO_Dashboard.Click button Edit Display Plan
    PO_DetailedDisplayPlan_Step1.Update working window
    PO_DetailedDisplayPlan_Step1.Verify Page Loaded
    PO_DetailedDisplayPlan_Step1.Go to step 4
    ${lastmth_step4} =  PO_DetailedDisplayPlan_Step1.Get total outlets
    should be equal  ${curt_step1}  ${lastmth_step4}

Filter By Catgroup default and verify shown outlet
    ${before_filter} =  PO_DetailedDisplayPlan_Step1.Get total outlets
    ViewElement.Filter BY Catgroup DBB
    ViewElement.Deselect Filter BY Catgroup DBB
    ViewElement.Filter BY Catgroup Default
    ${after_filter} =  PO_DetailedDisplayPlan_Step1.Get total outlets
    should be equal  ${before_filter}  ${after_filter}

Filter By Catgroup DBB and verify shown outlet
    [Arguments]  ${month}=None  ${year}=None  ${distributor_code}=None  ${cat_group}=DBB
    Postgres_Server.Connect database
    ViewElement.Filter BY Catgroup DBB
    ${web_display} =    PO_DetailedDisplayPlan_Step1.Get total outlets
    ${query_DB} =       Postgres_Server.Get number outlets by Catgroup after HBS  ${month}  ${year}  ${distributor_code}  ${cat_group}
    should be equal  ${query_DB}    ${web_display}
    Postgres_Server.Disconnect database

Filter By Catgroup IFT and verify shown outlet
    [Arguments]  ${month}=None  ${year}=None  ${distributor_code}=None  ${cat_group}=IFT
    Postgres_Server.Connect database
    ViewElement.Filter BY Catgroup IFT
    ${web_display} =    PO_DetailedDisplayPlan_Step1.Get total outlets
    ${query_DB} =       Postgres_Server.Get number outlets by Catgroup after HBS  ${month}  ${year}  ${distributor_code}  ${cat_group}
    should be equal  ${query_DB}    ${web_display}
    Postgres_Server.Disconnect database

Filter By Catgroup DBB&IFT and verify shown outlet
    [Arguments]  ${month}=None  ${year}=None  ${distributor_code}=None
    Postgres_Server.Connect database
    ViewElement.Filter BY Catgroup DBB&IFT
    ${web_display} =    PO_DetailedDisplayPlan_Step1.Get total outlets
    ${query_DB} =       Postgres_Server.Get number outlets of both DBB&IFT after HBS  ${month}  ${year}  ${distributor_code}
    should be equal  ${query_DB}    ${web_display}
    Postgres_Server.Disconnect database

Filter By ModelGroup U KE DBB and verify shown outlet
    [Arguments]  ${month}=None  ${year}=None  ${distributor_code}=None  ${model_group}=Ụ Kệ DBB
    Postgres_Server.Connect database
    ViewElement.Filter BY Modelgroup U KE DBB
    ${web_display} =    PO_DetailedDisplayPlan_Step1.Get total outlets
    ${query_DB} =       Postgres_Server.Get number outlets by ModelGroup after HBS  ${month}  ${year}  ${distributor_code}  ${model_group}
    should be equal  ${query_DB}    ${web_display}
    Postgres_Server.Disconnect database

Verify Default Values Invest And Growth
    [Arguments]  ${invest_def}  ${growth_def}
    ${web_invest} =  PO_DetailedDisplayPlan_Step1.get value INVEST
    ${web_growth} =  PO_DetailedDisplayPlan_Step1.get value GROWTH
    should be equal  ${web_invest}    ${inv est_def}
    should be equal  ${web_growth}    ${growth_def}

Check set default for Invest and Growth
    [Arguments]  ${invest_def}  ${growth_def}   ${invest}  ${growth}
    ViewElement.Adjust Values Invest And Growth                 ${invest}       ${growth}
    PO_DetailedDisplayPlan_Step1.Reset default Invest, Growth
    VerifyData.Verify Default Values Invest And Growth          ${invest_def}   ${growth_def}

Verify ablity group outlets with known values
    [Arguments]  ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}  ${cat_group}=None  ${model_group}=None
    PO_DetailedDisplayPlan_Step1.adjust value INVEST    ${invest}
    PO_DetailedDisplayPlan_Step1.adjust value GROWTH    ${growth}
    PO_DetailedDisplayPlan_Step1.click button apply invest and growth
    Postgres_Server.Connect database
    ${Gr_DauTuHieuQua}    ${Gr_DauTuChuaHieuQua}   ${Gr_TangTruong}    ${Gr_KhongNenDauTu} =  run keyword if
    ...                 '${cat_group}'!='None'      Postgres_Server.Evaluate Invest,Growth Values and group outlets with filter Catgroup at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}  ${cat_group}
    ...    ELSE IF      '${model_group}'!='None'    Postgres_Server.Evaluate Invest,Growth Values and group outlets with filter Modelgroup at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}  ${model_group}
    ...    ELSE                                     Postgres_Server.Evaluate Invest,Growth Values and group outlets at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}
    Postgres_Server.Disconnect database

    ${Nb_DB_DauTuHieuQua} =        get length  ${Gr_DauTuHieuQua}
    ${Nb_DB_DauTuChuaHieuQua} =    get length  ${Gr_DauTuChuaHieuQua}
    ${Nb_DB_TangTruong} =          get length  ${Gr_TangTruong}
    ${Nb_DB_KhongNenDauTu} =       get length  ${Gr_KhongNenDauTu}
    ${Nb_Web_DauTuHieuQua} =       PO_DetailedDisplayPlan_Step1.Get number outlets of each group  DauTuHieuQua
    ${Nb_Web_DauTuChuaHieuQua} =   PO_DetailedDisplayPlan_Step1.Get number outlets of each group  DauTuChuaHieuQua
    ${Nb_Web_TangTruong} =         PO_DetailedDisplayPlan_Step1.Get number outlets of each group  DautTuTangTruong
    ${Nb_Web_KhongNenDauTu} =      PO_DetailedDisplayPlan_Step1.Get number outlets of each group  KhongNenDauTu

    should be equal  ${Nb_DB_DauTuHieuQua}          ${Nb_Web_DauTuHieuQua}
    should be equal  ${Nb_DB_DauTuChuaHieuQua}      ${Nb_Web_DauTuChuaHieuQua}
    should be equal  ${Nb_DB_TangTruong}            ${Nb_Web_TangTruong}
    should be equal  ${Nb_DB_KhongNenDauTu}         ${Nb_Web_KhongNenDauTu}

Verify total contribute money and percentage contribution each group
    [Arguments]  ${group_type}  ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}=8  ${growth}=150  ${cat_group}=None  ${model_group}=None
    ${Nb_Outlet_Web} =      PO_DetailedDisplayPlan_Step1.Get number outlets of each group                   ${group_type}
    ${contb_money_web} =    PO_DetailedDisplayPlan_Step1.Get total contribute money of each group           ${group_type}
    ${contr_percent_web} =  PO_DetailedDisplayPlan_Step1.Get total contribute percent of each group         ${group_type}

    pass execution if   ${Nb_Outlet_Web}==0 and ${contb_money_web}==0   there is nothing outlet in group to get overview values

    Postgres_Server.Connect database
    ${Gr_DauTuHieuQua}    ${Gr_DauTuChuaHieuQua}   ${Gr_TangTruong}    ${Gr_KhongNenDauTu} =  run keyword if
    ...                 '${cat_group}'!='None'      Postgres_Server.Evaluate Invest,Growth Values and group outlets with filter Catgroup at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}  ${cat_group}
    ...    ELSE IF      '${model_group}'!='None'    Postgres_Server.Evaluate Invest,Growth Values and group outlets with filter Modelgroup at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}  ${model_group}
    ...    ELSE                                     Postgres_Server.Evaluate Invest,Growth Values and group outlets at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}

    ${lst_outletcode} =  run keyword if   '${group_type}' == 'DauTuHieuQua'        Postgres_Server.Merge string outlet code    ${Gr_DauTuHieuQua}
    ...                         ELSE IF   '${group_type}' == 'DautTuTangTruong'    Postgres_Server.Merge string outlet code    ${Gr_TangTruong}
    ...                         ELSE IF   '${group_type}' == 'DauTuChuaHieuQua'    Postgres_Server.Merge string outlet code    ${Gr_DauTuChuaHieuQua}
    ...                         ELSE IF   '${group_type}' == 'KhongNenDauTu'       Postgres_Server.Merge string outlet code    ${Gr_KhongNenDauTu}

    ${contb_money_db} =       Postgres_Server.Evaluate Average Invoice value in three months of all outlets        ${test_month}  ${year}  ${lst_outletcode}
    ${Distr_Invoice_db} =     Postgres_Server.Evaluate Average Invoice value in three months of whole distributor  ${test_month}  ${year}  ${distributor_code}
    ${contr_percent_db} =     evaluate  ${contb_money_db}/${Distr_Invoice_db}*100

    ${contb_money_db} =       convert to number  ${contb_money_db}    2
    ${contr_percent_db} =     convert to number  ${contr_percent_db}  2
    Postgres_Server.Disconnect database

    should not be equal  ${contb_money_web}          ${contb_money_db}
    should not be equal  ${contr_percent_web}        ${contr_percent_db}

Verify growth rate of each group
    [Arguments]  ${group_type}  ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}=8  ${growth}=150  ${cat_group}=None  ${model_group}=None
    ${Nb_Outlet_Web} =      PO_DetailedDisplayPlan_Step1.Get number outlets of each group          ${group_type}
    ${growth_rate_web} =    PO_DetailedDisplayPlan_Step1.Get growth value of each group            ${group_type}


    pass execution if   ${Nb_Outlet_Web}==0 and ${growth_rate_web}==0  there is nothing outlet in group to get overview values

    Postgres_Server.Connect database
    ${Gr_DauTuHieuQua}    ${Gr_DauTuChuaHieuQua}   ${Gr_TangTruong}    ${Gr_KhongNenDauTu} =  run keyword if
    ...                 '${cat_group}'!='None'      Postgres_Server.Evaluate Invest,Growth Values and group outlets with filter Catgroup at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}  ${cat_group}
    ...    ELSE IF      '${model_group}'!='None'    Postgres_Server.Evaluate Invest,Growth Values and group outlets with filter Modelgroup at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}  ${model_group}
    ...    ELSE                                     Postgres_Server.Evaluate Invest,Growth Values and group outlets at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}

    ${lst_outletcode} =  run keyword if   '${group_type}' == 'DauTuHieuQua'        Postgres_Server.Merge string outlet code    ${Gr_DauTuHieuQua}
    ...                         ELSE IF   '${group_type}' == 'DautTuTangTruong'    Postgres_Server.Merge string outlet code    ${Gr_TangTruong}
    ...                         ELSE IF   '${group_type}' == 'DauTuChuaHieuQua'    Postgres_Server.Merge string outlet code    ${Gr_DauTuChuaHieuQua}
    ...                         ELSE IF   '${group_type}' == 'KhongNenDauTu'       Postgres_Server.Merge string outlet code    ${Gr_KhongNenDauTu}

    ${Period_Invoice_2018}    ${Period_Invoice_2017}  ${Period_Invoice_2016} =   Postgres_Server.Evaluate Average Invoice periodic of all outlets   ${test_month}  ${year}  ${lst_outletcode}

    ${Growth} =  run keyword if  ${year}==2018 and ${test_month}==01    Postgres_Server.Evaluate Growth  ${Period_Invoice_2017}   ${Period_Invoice_2016}
    ...                 ELSE IF  ${year}==2018 and ${test_month}==02    Postgres_Server.Evaluate Growth  ${Period_Invoice_2017}   ${Period_Invoice_2016}
    ...                 ELSE IF  ${year}==2018                          Postgres_Server.Evaluate Growth  ${Period_Invoice_2018}   ${Period_Invoice_2017}
    ...                 ELSE IF  ${year}==2017                          Postgres_Server.Evaluate Growth  ${Period_Invoice_2017}   ${Period_Invoice_2016}
    ${growth_rate_db} =   convert to number   ${Growth}             2
    ${growth_rate_web} =  convert to number   ${growth_rate_web}    2
    Postgres_Server.Disconnect database

    should not be equal  ${growth_rate_web}          ${growth_rate_db}

Verify total invest money and invest percentage of each group
    [Arguments]  ${group_type}  ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}=8  ${growth}=150  ${cat_group}=None  ${model_group}=None
    ${Nb_Outlet_Web} =          PO_DetailedDisplayPlan_Step1.Get number outlets of each group               ${group_type}
    ${invest_money_web} =       PO_DetailedDisplayPlan_Step1.Get total investment money of each group       ${group_type}
    ${invest_percent_web} =     PO_DetailedDisplayPlan_Step1.Get total investment percent of each group     ${group_type}


    pass execution if   ${Nb_Outlet_Web}==0 and ${invest_money_web}==0  there is nothing outlet in group to get overview values

    Postgres_Server.Connect database
    ${Gr_DauTuHieuQua}    ${Gr_DauTuChuaHieuQua}   ${Gr_TangTruong}    ${Gr_KhongNenDauTu} =  run keyword if
    ...                 '${cat_group}'!='None'      Postgres_Server.Evaluate Invest,Growth Values and group outlets with filter Catgroup at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}  ${cat_group}
    ...    ELSE IF      '${model_group}'!='None'    Postgres_Server.Evaluate Invest,Growth Values and group outlets with filter Modelgroup at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}  ${model_group}
    ...    ELSE                                     Postgres_Server.Evaluate Invest,Growth Values and group outlets at step1
    ...                                             ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${invest}  ${growth}

    ${lst_dist_outlet} =  Postgres_Server.Get string combine all outlets of each distributor after HBS  ${last_month}  ${year}  ${distributor_code}
    ${lst_gr_outlet} =   run keyword if   '${group_type}' == 'DauTuHieuQua'        Postgres_Server.Merge string outlet code    ${Gr_DauTuHieuQua}
    ...                         ELSE IF   '${group_type}' == 'DautTuTangTruong'    Postgres_Server.Merge string outlet code    ${Gr_TangTruong}
    ...                         ELSE IF   '${group_type}' == 'DauTuChuaHieuQua'    Postgres_Server.Merge string outlet code    ${Gr_DauTuChuaHieuQua}
    ...                         ELSE IF   '${group_type}' == 'KhongNenDauTu'       Postgres_Server.Merge string outlet code    ${Gr_KhongNenDauTu}

    ${Invest_money_db} =     Postgres_Server.Get Display Cost and Location Cost of all outlets   ${last_month}  ${year}  ${lst_gr_outlet}
    ${Invest_money_dist} =   Postgres_Server.Get Display Cost and Location Cost of all outlets   ${last_month}  ${year}  ${lst_dist_outlet}
    ${invest_percent_db} =   evaluate  ${Invest_money_db}/${Invest_money_dist}*100
    ${invest_percent_db} =    convert to number  ${invest_percent_db}  2
    ${invest_percent_web} =   convert to number  ${invest_percent_web}  2

    Postgres_Server.Disconnect database

    should not be equal  ${invest_money_web}            ${Invest_money_db}
    should not be equal  ${invest_percent_web}          ${invest_percent_db}

Verify history Invoice table
    [Arguments]  ${month}  ${year}  ${outlet_code}
    Postgres_Server.Connect database
    ${ls_modelgp}     ${dict_modelgp_web} =  PO_DetailedDisplayPlan_Step1.Get value invoice in past
    ${dict_modelgp_db} =                     Postgres_Server.Get Invoice History of outlet as modelgroup  ${ls_modelgp}  ${month}  ${year}  ${outlet_code}
    Postgres_Server.Disconnect database

    :FOR  ${model_group}  IN    @{ls_modelgp}
    \   ${data_web} =   get from dictionary   ${dict_modelgp_web}   ${model_group}
    \   ${data_db} =    get from dictionary   ${dict_modelgp_db}    ${model_group}
    \   log many                    ${data_web}   ${data_db}
    \   Compare items in two list   ${data_web}   ${data_db}

Compare items in two list
    [Arguments]  ${list_1}  ${list_2}
    ${size} =  get length   ${list_1}
    :FOR  ${i}   IN RANGE   0     ${size}   #0,1,2...,size
    \   should be equal as numbers   @{list_1}[${i}]    @{list_2}[${i}]
    \   log many  @{list_1}[${i}]    @{list_2}[${i}]

Verify entry display plan
    [Arguments]  ${month}  ${year}  ${outlet_code}
    # Verify MUC TB, NHOM TB, vi tri
    ${dict_modelgp_web} =  PO_DetailedDisplayPlan_Step1.Get outletmodel registered as default from last month
    Postgres_Server.Connect database
    ${ls_modelgp}     ${dict_modelgp_db} =  Postgres_Server.Get outletmodel registered of last month    ${month}  ${year}  ${outlet_code}
    Postgres_Server.Disconnect database

    :FOR  ${model_group}  IN    @{ls_modelgp}
    \   ${data_web} =   get from dictionary   ${dict_modelgp_web}   ${model_group}
    \   ${data_db} =    get from dictionary   ${dict_modelgp_db}    ${model_group}
    \   log many                    ${data_web}   ${data_db}
    \   Compare items in two list   ${data_web}   ${data_db}

    # Verify AVG Invoice in 3 months of modelgroup and percentage Invest of each modelgroup
    ${dict_Inv3months_modelgroup} =  PO_DetailedDisplayPlan_Step1.Get Avg Invoice in three months on section detail for each modelgroup
    Verify ensure non-existence modelgroupnam thus non-existence percentage invest   ${dict_Inv3months_modelgroup}
    ${ls_modelgp_1}     ${dict_modelgp_web_1} =  PO_DetailedDisplayPlan_Step1.Get value invoice in past

    :FOR  ${model_group_1}  IN    @{ls_modelgp_1}
    \   ${list_HistoryInvTable} =           get from dictionary     ${dict_modelgp_web_1}           ${model_group_1}
    \   ${data_InvAvg_HistoryInvTable} =    set variable            @{list_HistoryInvTable}[3]

    \   ${list_HistoryDisplayPlan} =         get from dictionary   ${dict_Inv3months_modelgroup}    ${model_group_1}
    \   ${data_InvAvg_HistoryDisplayPlan} =  set variable          @{list_HistoryDisplayPlan}[1]

    \   log many                    ${data_InvAvg_HistoryInvTable}   ${data_InvAvg_HistoryDisplayPlan}
    \   should be equal as numbers  ${data_InvAvg_HistoryInvTable}   ${data_InvAvg_HistoryDisplayPlan}

    \   ${modelname} =    get from list     ${list_HistoryDisplayPlan}  0
    \   ${displaycost} =  run keyword if   "${modelname}"!="${EMPTY}"   displaycost outletmodel   ${modelname}
    \   ...                         ELSE    set variable  ${EMPTY}
    \   log  ${displaycost}

    \   ${list_temp} =     run keyword if    "${modelname}"!="${EMPTY}"     get from dictionary   ${dict_modelgp_db}     ${model_group_1}
    \   ...                          ELSE    set variable                   ${EMPTY}
    \   ${locationcost} =  run keyword if    "${model_group_1}"=="SỮA BỘT FRISO"    set variable  @{list_temp}[2]
    \   ...                         ELSE     set variable  0
    \   ${locationcost} =  convert to number  ${locationcost}
    \   log  ${locationcost}

    \   ${cal_percent} =  run keyword if  "${modelname}"!="${EMPTY}"    evaluate  (${displaycost}+${locationcost})/${data_InvAvg_HistoryDisplayPlan}*100
    \   ...                         ELSE    set variable  ${EMPTY}

    \   ${cal_percent} =  run keyword if  "${modelname}"!="${EMPTY}"    convert to number  ${cal_percent}  2
    \   ...                         ELSE    set variable  ${EMPTY}

    \   log many         ${cal_percent}               @{list_HistoryDisplayPlan}[2]
    \   run keyword if  "${modelname}"!="${EMPTY}"    should be equal as numbers     ${cal_percent}     @{list_HistoryDisplayPlan}[2]

Verify ensure non-existence modelgroupnam thus non-existence percentage invest     # Ticket 2860
    [Arguments]     ${dict_Inv3months_modelgroup}
    log dictionary  ${dict_Inv3months_modelgroup}

    ${keys} =  get dictionary keys  ${dict_Inv3months_modelgroup}
    :FOR  ${idx}  IN   @{keys}
    \   ${lst_elements} =  get from dictionary  ${dict_Inv3months_modelgroup}  ${idx}
    \   ${modelname} =  set variable  @{lst_elements}[0]
    \   ${percent} =    set variable  @{lst_elements}[2]

    \   log many        ${modelname}   ${percent}
    \   ${status} =     evaluate       "${modelname}" == "${EMPTY}" and "${percent}" == "${EMPTY}"
    \   should be true  ${status}      FAILURE BY Ticket 2860

Verify target and reality number outlets in table SUMMARY EFFECTIVE INVESTMENT
    [Arguments]  ${month}  ${year}  ${distributor_code}
    ${Web_List_Number_Outlet_DBB}  ${Web_List_Number_Outlet_IFT}  ${Web_List_Number_Outlet_ALL} =  PO_DetailedDisplayPlan_Step1.Get number outlets in two aspect target and reality

    ${lst_month} =  evaluate           ${month}-1
    ${temp} =       convert to string  ${lst_month}
    ${lst_month} =  run keyword if  0< ${lst_month} <10     catenate  SEPARATOR=  0  ${temp}
    ...                       ELSE  ${lst_month}

    log  ${lst_month}
    Postgres_Server.Connect database
    ${DB_DBB_target} =   Postgres_Server.Get number outlets by Catgroup after HBS  ${lst_month}  ${year}  ${distributor_code}  DBB
    ${DB_DBB_reality} =  Postgres_Server.Get number outlets by Catgroup after HBS  ${month}      ${year}  ${distributor_code}  DBB

    ${DB_IFT_target} =   Postgres_Server.Get number outlets by Catgroup after HBS  ${lst_month}  ${year}  ${distributor_code}  IFT
    ${DB_IFT_reality} =  Postgres_Server.Get number outlets by Catgroup after HBS  ${month}      ${year}  ${distributor_code}  IFT

    ${DB_ALL_target} =   Postgres_Server.Get total number outlets of each distributor after HBS  ${lst_month}  ${year}  ${distributor_code}
    ${DB_ALL_reality} =  Postgres_Server.Get total number outlets of each distributor after HBS  ${month}      ${year}  ${distributor_code}
    Postgres_Server.Disconnect database

    log many  ${DB_DBB_target}  ${DB_DBB_reality}  ${DB_IFT_target}  ${DB_IFT_reality}  ${DB_ALL_target}  ${DB_ALL_reality}
    log many  ${Web_List_Number_Outlet_DBB}  ${Web_List_Number_Outlet_IFT}  ${Web_List_Number_Outlet_ALL}

    should be equal as numbers  @{Web_List_Number_Outlet_DBB}[0]  ${DB_DBB_target}
    should be equal as numbers  @{Web_List_Number_Outlet_DBB}[1]  ${DB_DBB_reality}

    should be equal as numbers  @{Web_List_Number_Outlet_IFT}[0]  ${DB_IFT_target}
    should be equal as numbers  @{Web_List_Number_Outlet_IFT}[1]  ${DB_IFT_reality}

    should be equal as numbers  @{Web_List_Number_Outlet_ALL}[0]  ${DB_ALL_target}
    should be equal as numbers  @{Web_List_Number_Outlet_ALL}[1]  ${DB_ALL_reality}

Verify Invoice distributor, register display outlet and percentage Contribution for Catgroup
    [Arguments]  ${month}  ${year}  ${distributor_code}  ${catgroup}
    ${Web_Invoice_distributor}  ${Web_Invoice_outlet_registerdisplay}  ${Web_Percent_Contribute} =  PO_DetailedDisplayPlan_Step1.Get Invoice Contribute of Whole distributor, register display outlet and percentage Contribution  ${catgroup}

    ${table_inv} =  create dictionary       2018=salesinfo   2017=salesinfo_2017     2016=salesinfo_2016
    ${table} =      get from dictionary     ${table_inv}     ${year}
    log  ${table}

    ${modelgroup} =  set variable if
    ...             "${catgroup}" == "DBB"    289,297,304,391
    ...             "${catgroup}" == "IFT"    327,362,377
    ...             "${catgroup}" == "ALL"    289,297,304,391,327,362,377

    Postgres_Server.Connect database
    ${DB_Invoice_distributor} =              Postgres_Server.Get Invoice of whole Catgroup of Distributor  ${month}  ${month}  ${year}  ${distributor_code}      ${table}  ${catgroup}
    ${List_Outlet_Catgroup} =                run keyword if  "${catgroup}" == "ALL"
    ...                                      Postgres_Server.Get string combine outlets by Catgroup after HBS                  ${month}  ${year}  ${distributor_code}      ${catgroup}
    ...                     ELSE             Postgres_Server.Get string combine all outlets of each distributor after HBS      ${month}  ${year}  ${distributor_code}      ${catgroup}
    ${DB_Invoice_outlet_registerdisplay} =   Postgres_Server.Get Invoice of each model group               ${month}  ${month}  ${year}  ${List_Outlet_Catgroup}  ${modelgroup}   ${table}
    ${DB_Percent_Contribute} =               evaluate  ${DB_Invoice_outlet_registerdisplay}/${DB_Invoice_distributor}*100

    log many  ${DB_Invoice_distributor}  ${List_Outlet_Catgroup}  ${DB_Invoice_outlet_registerdisplay}  ${Web_Percent_Contribute}

    should be equal as numbers  ${Web_Invoice_distributor}              ${DB_Invoice_distributor}
    should be equal as numbers  ${Web_Invoice_outlet_registerdisplay}   ${DB_Invoice_outlet_registerdisplay}
    should be equal as numbers  ${Web_Percent_Contribute}               ${DB_Percent_Contribute}

Verify Location cost, display cost, total invest cost and percentage investment for Catgroup
    [Arguments]  ${month}  ${year}  ${distributor_code}  ${catgroup}
    ${Web_LocationCost}  ${Web_DisplayCost}  ${Web_TotalInvestCost}  ${Web_PercentInvest} =  PO_DetailedDisplayPlan_Step1.Get Location cost, display cost, total invest cost and percentage investment  ${catgroup}

    ${table_inv} =  create dictionary       2018=salesinfo   2017=salesinfo_2017     2016=salesinfo_2016
    ${table} =      get from dictionary     ${table_inv}     ${year}
    log  ${table}

    ${modelgroup} =  set variable if
    ...             "${catgroup}" == "DBB"    289,297,304,391
    ...             "${catgroup}" == "IFT"    327,362,377
    ...             "${catgroup}" == "ALL"    289,297,304,391,327,362,377

    Postgres_Server.Connect database
    ${List_Outlet_Catgroup} =                run keyword if  "${catgroup}" == "ALL"
    ...                                      Postgres_Server.Get string combine outlets by Catgroup after HBS                  ${month}  ${year}  ${distributor_code}      ${catgroup}
    ...                     ELSE             Postgres_Server.Get string combine all outlets of each distributor after HBS      ${month}  ${year}  ${distributor_code}      ${catgroup}
    ${DB_Invoice_outlet_registerdisplay} =      Postgres_Server.Get Invoice of each model group                     ${month}  ${month}  ${year}  ${List_Outlet_Catgroup}  ${modelgroup}   ${table}
    ${DB_LocationCost} =                        Postgres_Server.Get Location Cost of all outlets                    ${month}  ${year}   ${List_Outlet_Catgroup}
    ${DB_DisplayCost} =                         Postgres_Server.Get Display Cost of all outlets                     ${month}  ${year}   ${List_Outlet_Catgroup}
    ${DB_TotalInvestCost} =                     Postgres_Server.Get Display Cost and Location Cost of all outlets   ${month}  ${year}   ${List_Outlet_Catgroup}
    ${DB_PercentInvest} =                       evaluate  ${DB_TotalInvestCost}/${DB_Invoice_outlet_registerdisplay}*100

    should be equal as numbers  ${Web_LocationCost}         ${DB_LocationCost}
    should be equal as numbers  ${Web_DisplayCost}          ${DB_DisplayCost}
    should be equal as numbers  ${Web_TotalInvestCost}      ${DB_TotalInvestCost}
    should be equal as numbers  ${Web_PercentInvest}        ${DB_PercentInvest}

Change specific OutletModel in ModelGroup and check
    [Arguments]  ${outlet_model_group}  ${outlet_model}
    run keyword if  "${outlet_model_group}" == "U_KE_DBB"               PO_DetailedDisplayPlan_Step1.Edit fields in ModelGroup U Ke DBB             ${outlet_model}
    ...    ELSE IF  "${outlet_model_group}" == "U_IFT"                  PO_DetailedDisplayPlan_Step1.Edit fields in ModelGroup U IFT                ${outlet_model}
    ...    ELSE IF  "${outlet_model_group}" == "SCM"                    PO_DetailedDisplayPlan_Step1.Edit fields in ModelGroup SCM                  ${outlet_model}
    ...    ELSE IF  "${outlet_model_group}" == "KE_FINO"                PO_DetailedDisplayPlan_Step1.Edit fields in ModelGroup KE FINO              ${outlet_model}
    ...    ELSE IF  "${outlet_model_group}" == "SUA_BOT_FRISO"          PO_DetailedDisplayPlan_Step1.Edit fields in ModelGroup SUA BOT FRISO        ${outlet_model}
    ...    ELSE IF  "${outlet_model_group}" == "NGUYEN_KEM"             PO_DetailedDisplayPlan_Step1.Edit fields in ModelGroup NGUYEN KEM           ${outlet_model}
    ...    ELSE IF  "${outlet_model_group}" == "FRISTI_KE_HINH_CHAI"    PO_DetailedDisplayPlan_Step1.Edit fields in ModelGroup FRISTI KE HINH CHAI  ${outlet_model}

    ${outlet_model_after} =  PO_DetailedDisplayPlan_Step1.Get each outletmodel just modified this month   ${outlet_model_group}
    should be equal as strings  ${outlet_model}  ${outlet_model_after}

Save and veriry the change
    [Arguments]  ${outlet_model_group}  ${outlet_model}
    click element   xpath=//*[text()='Điểu chỉnh']
    sleep  1s
    PO_DetailedDisplayPlan_Step1.Edit outlet and verify window detail display plan of outlet is show Group DauTuChuaHieuQua
    ${outlet_model_after} =     PO_DetailedDisplayPlan_Step1.Get each outletmodel just modified this month   ${outlet_model_group}
    should be equal as strings  ${outlet_model}  ${outlet_model_after}

