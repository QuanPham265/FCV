*** Settings ***
Library  DatabaseLibrary
Library  String
Library  Dialogs
Library  OperatingSystem
Library  Collections
Library  C:/FCV/Libraries/EditString.py

# pybot -d results tests/postgres_server_test.robot
*** Variables ***
${DB_NAME} =                        FCVPlatform
${DB_USER_NAME} =                   postgres
${DB_USER_PASSWORD} =               123456
${DB_HOST} =                        192.168.2.127
${DB_PORT} =                        5434

${DB_PRODUCTION_NAME} =             FCVPlatform
${DB_PRODUCTION_USER_NAME} =        fcv
${DB_PRODUCTION_USER_PASSWORD} =    123456
${DB_PRODUCTION_HOST} =             112.109.90.100
${DB_PRODUCTION_PORT} =             5432

*** Keywords ***
Connect database
    connect to database  psycopg2  ${DB_NAME}              ${DB_USER_NAME}              ${DB_USER_PASSWORD}              ${DB_HOST}               ${DB_PORT}
#    connect to database  psycopg2  ${DB_PRODUCTION_NAME}   ${DB_PRODUCTION_USER_NAME}   ${DB_PRODUCTION_USER_PASSWORD}   ${DB_PRODUCTION_HOST}    ${DB_PRODUCTION_PORT}

Disconnect database
    disconnect from database

Get whole number outlet which distributor manage
    [Arguments]  ${distributor_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Outlet_Whole_Distributor.sql
    ${statement} =  replace string  ${statement}  %MA_NPP   ${distributor_code}

    log             ${statement}
    ${nb_outlet} =  query                 ${statement}

    log  ${nb_outlet}

    [Return]  ${nb_outlet}

Get list outlets of each distributor after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Outlet_Total_Number_After_HBS.sql
    ${statement} =  replace string  ${statement}  %THANG    ${month}
    ${statement} =  replace string  ${statement}  %NAM      ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP   ${distributor_code}

    log  ${statement}

    ${list_outlet} =  query                 ${statement}
    ${list_outlet} =  convert to list       ${list_outlet}

    log       ${list_outlet}
    [Return]  ${list_outlet}

Get total number outlets of each distributor after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}
    ${list_outlet} =  Get list outlets of each distributor after HBS  ${month}  ${year}  ${distributor_code}
    ${nb_outlet} =    get length  ${list_outlet}

    log       ${nb_outlet}
    [Return]  ${nb_outlet}

Get string combine all outlets of each distributor after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Outlet_Total_Str_After_HBS.sql
    ${statement} =  replace string  ${statement}  %THANG            ${month}
    ${statement} =  replace string  ${statement}  %NAM              ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP           ${distributor_code}
    log             ${statement}

    ${str_all_outlet} =  query                  ${statement}
    ${str_all_outlet} =  convert to string      ${str_all_outlet}
    ${str_all_outlet} =  fetch from right       ${str_all_outlet}  ["
    ${str_all_outlet} =  fetch from left        ${str_all_outlet}  "]
    ${str_all_outlet} =  remove string          ${str_all_outlet}  "

    log         ${str_all_outlet}
    [Return]    ${str_all_outlet}

Get list of outlets by Catgroup after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}  ${cat_group}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Outlet_Catgroup_Number_After_HBS.sql
    ${statement} =  replace string  ${statement}  %THANG        ${month}
    ${statement} =  replace string  ${statement}  %NAM          ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP       ${distributor_code}
    ${statement} =  replace string  ${statement}  %NGANH_HANG   ${cat_group}
    log             ${statement}

    ${list_outlet} =  query                 ${statement}
    ${list_outlet} =  convert to list       ${list_outlet}

    log       ${list_outlet}
    [Return]  ${list_outlet}

Get number outlets by Catgroup after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}  ${cat_group}
    ${list_outlet} =  Get list of outlets by Catgroup after HBS  ${month}  ${year}  ${distributor_code}  ${cat_group}
    ${nb_outlet} =    get length  ${list_outlet}

    log       ${nb_outlet}
    [Return]  ${nb_outlet}

Get string combine outlets by Catgroup after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}  ${cat_group}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Outlet_Catgroup_Str_After_HBS.sql
    ${statement} =  replace string  ${statement}  %THANG        ${month}
    ${statement} =  replace string  ${statement}  %NAM          ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP       ${distributor_code}
    ${statement} =  replace string  ${statement}  %NGANH_HANG   ${cat_group}
    log             ${statement}

    ${str_all_outlet} =  query                  ${statement}
    ${str_all_outlet} =  convert to string      ${str_all_outlet}
    ${str_all_outlet} =  fetch from right       ${str_all_outlet}  ["
    ${str_all_outlet} =  fetch from left        ${str_all_outlet}  "]
    ${str_all_outlet} =  remove string          ${str_all_outlet}  "

    log         ${str_all_outlet}
    [Return]    ${str_all_outlet}

Get list outlets of both DBB&IFT after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Outlet_Catgroup_DBB_IFT_Number_After_HBS.sql
    ${statement} =  replace string  ${statement}  %THANG        ${month}
    ${statement} =  replace string  ${statement}  %NAM          ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP       ${distributor_code}
    log             ${statement}

    ${list_outlet} =  query                 ${statement}
    ${list_outlet} =  convert to list       ${list_outlet}

    log       ${list_outlet}
    [Return]  ${list_outlet}

Get number outlets of both DBB&IFT after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}
    ${list_outlet} =  Get list outlets of both DBB&IFT after HBS  ${month}  ${year}  ${distributor_code}
    ${nb_outlet} =    get length  ${list_outlet}

    log       ${nb_outlet}
    [Return]  ${nb_outlet}

Get string combine outlets of both DBB&IFT after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Outlet_Catgroup_DBB_IFT_Str_After_HBS.sql
    ${statement} =  replace string  ${statement}  %THANG        ${month}
    ${statement} =  replace string  ${statement}  %NAM          ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP       ${distributor_code}
    log             ${statement}

    ${str_all_outlet} =  query                  ${statement}
    ${str_all_outlet} =  convert to string      ${str_all_outlet}
    ${str_all_outlet} =  fetch from right       ${str_all_outlet}  ["
    ${str_all_outlet} =  fetch from left        ${str_all_outlet}  "]
    ${str_all_outlet} =  remove string          ${str_all_outlet}  "

    log         ${str_all_outlet}
    [Return]    ${str_all_outlet}

Get list of outlets by ModelGroup after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}  ${model_group}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Outlet_ModelGroup_Number_After_HBS.sql
    ${statement} =  replace string  ${statement}  %THANG            ${month}
    ${statement} =  replace string  ${statement}  %NAM              ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP           ${distributor_code}
    ${statement} =  replace string  ${statement}  %MUC_TRUNG_BAY    ${model_group}
    log             ${statement}

    ${list_outlet} =  query                 ${statement}
    ${list_outlet} =  convert to list       ${list_outlet}

    log       ${list_outlet}
    [Return]  ${list_outlet}

Get number outlets by ModelGroup after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}  ${model_group}
    ${list_outlet} =  Get list of outlets by ModelGroup after HBS  ${month}  ${year}  ${distributor_code}  ${model_group}
    ${nb_outlet} =    get length  ${list_outlet}

    log       ${nb_outlet}
    [Return]  ${nb_outlet}

Get string combine outlets by ModelGroup after HBS
    [Arguments]  ${month}  ${year}  ${distributor_code}  ${model_group}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Outlet_ModelGroup_Str_After_HBS.sql
    ${statement} =  replace string  ${statement}  %THANG            ${month}
    ${statement} =  replace string  ${statement}  %NAM              ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP           ${distributor_code}
    ${statement} =  replace string  ${statement}  %MUC_TRUNG_BAY    ${model_group}
    log             ${statement}

    ${str_all_outlet} =  query                  ${statement}
    ${str_all_outlet} =  convert to string      ${str_all_outlet}
    ${str_all_outlet} =  fetch from right       ${str_all_outlet}  ["
    ${str_all_outlet} =  fetch from left        ${str_all_outlet}  "]
    ${str_all_outlet} =  remove string          ${str_all_outlet}  "

    log         ${str_all_outlet}
    [Return]    ${str_all_outlet}


################
### INVOICE  ###
################

Get Invoice of each outlet
    # Return total invoice of each outletcode in certain range time
    [Arguments]  ${month_begin}  ${month_end}  ${year}  ${outlet_code}  ${table}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Invoice_Outlet.sql
    ${statement} =  replace string  ${statement}  %THANG_BEGIN          ${month_begin}
    ${statement} =  replace string  ${statement}  %THANG_END            ${month_end}
    ${statement} =  replace string  ${statement}  %NAM                  ${year}
    ${statement} =  replace string  ${statement}  %MA_CH                ${outlet_code}
    ${statement} =  replace string  ${statement}  %DOANHSO_NAM          ${table}

    log       ${statement}
    ${rsl} =  query                     ${statement}

    log  ${rsl}
    ${rsl} =  convert to dictionary     ${rsl}

    log dictionary      ${rsl}
    [Return]            ${rsl}

Get Invoice of all outlet
    # Return total invoice of each outletcode in certain range time
    [Arguments]  ${month_begin}  ${month_end}  ${year}  ${outlet_code}  ${table}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Invoice_Total_Outlets.sql
    ${statement} =  replace string  ${statement}  %THANG_BEGIN          ${month_begin}
    ${statement} =  replace string  ${statement}  %THANG_END            ${month_end}
    ${statement} =  replace string  ${statement}  %NAM                  ${year}
    ${statement} =  replace string  ${statement}  %MA_CH                ${outlet_code}
    ${statement} =  replace string  ${statement}  %DOANHSO_NAM          ${table}

    log       ${statement}
    ${rsl} =  query                 ${statement}
    ${rsl} =  convert to string     ${rsl}
    ${rsl} =  run keyword if        "${rsl}" == "[(None,)]"     set variable                    0
    ...                 ELSE                                    Convert db value to number      ${rsl}

    ${rsl} =  convert to number     ${rsl}
    log       ${rsl}
    [Return]  ${rsl}

Get Invoice of whole distributor
    # Return total invoice of each outletcode in certain range time
    [Arguments]  ${month_begin}  ${month_end}  ${year}  ${distributor_code}  ${table}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Invoice_Distributor.sql
    ${statement} =  replace string  ${statement}  %THANG_BEGIN          ${month_begin}
    ${statement} =  replace string  ${statement}  %THANG_END            ${month_end}
    ${statement} =  replace string  ${statement}  %NAM                  ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP               ${distributor_code}
    ${statement} =  replace string  ${statement}  %DOANHSO_NAM          ${table}

    log       ${statement}
    ${rsl} =  query                 ${statement}
    ${rsl} =  convert to string     ${rsl}
    ${rsl} =  run keyword if        "${rsl}" == "[(None,)]"     set variable                    0
    ...                 ELSE                                    Convert db value to number      ${rsl}

    ${rsl} =  convert to number     ${rsl}
    log       ${rsl}
    [Return]  ${rsl}

Get Invoice of whole Catgroup of Distributor
    # Return total invoice of Catgroup of certain Distributor
    [Arguments]  ${month_begin}  ${month_end}  ${year}  ${distributor_code}  ${table}  ${catgroup}
    # exchange ${catgroup} by modelgroup belong to
    ${modelgroup} =  set variable if
    ...             "${catgroup}" == "DBB"    289,297,304,391
    ...             "${catgroup}" == "IFT"    327,362,377
    ...             "${catgroup}" == "ALL"    289,297,304,391,327,362,377

    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Invoice_Distributor_eachCatGroup.sql
    ${statement} =  replace string  ${statement}  %THANG_BEGIN          ${month_begin}
    ${statement} =  replace string  ${statement}  %THANG_END            ${month_end}
    ${statement} =  replace string  ${statement}  %NAM                  ${year}
    ${statement} =  replace string  ${statement}  %MA_NPP               ${distributor_code}
    ${statement} =  replace string  ${statement}  %DOANHSO_NAM          ${table}
    ${statement} =  replace string  ${statement}  %MODELGROUP           ${modelgroup}

    log       ${statement}
    ${rsl} =  query                 ${statement}
    ${rsl} =  convert to string     ${rsl}
    ${rsl} =  run keyword if        "${rsl}" == "[(None,)]"     set variable                    0
    ...                 ELSE                                    Convert db value to number      ${rsl}

    ${rsl} =  convert to number     ${rsl}
    log       ${rsl}
    [Return]  ${rsl}

Get Invoice of each model group
    # Return total invoice of each model group to use for Invoice history
    [Arguments]  ${month_begin}  ${month_end}  ${year}  ${outlet_code}  ${model_group}   ${table}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Invoice_ModelGroup_Outlet.sql
    ${statement} =  replace string  ${statement}  %THANG_BEGIN          ${month_begin}
    ${statement} =  replace string  ${statement}  %THANG_END            ${month_end}
    ${statement} =  replace string  ${statement}  %NAM                  ${year}
    ${statement} =  replace string  ${statement}  %MA_CH                ${outlet_code}
    ${statement} =  replace string  ${statement}  %MODELGROUP           ${model_group}
    ${statement} =  replace string  ${statement}  %DOANHSO_NAM          ${table}

    log       ${statement}
    ${rsl} =  query                 ${statement}
    ${rsl} =  convert to string     ${rsl}
    ${rsl} =  run keyword if        "${rsl}" == "[(None,)]"     set variable                    0
    ...                 ELSE                                    Convert db value to number      ${rsl}

    ${rsl} =  convert to number     ${rsl}
    log       ${rsl}
    [Return]  ${rsl}

Evaluate Average Invoice value in three months
    # Detect suitable range of month with different input month. example
    # input month = 05/2018     Month range: 03/2018, 02/2018, 01/2018
    # input month = 03/2018     Month range: 01/2018, 11/2017, 10/2017
    [Arguments]  ${month}  ${year}  ${list_outlet}

    ${Invoice_2018}    ${Invoice_2017} =     timerange_Invoice_Avg_3mths   ${month}   ${year}
    ${length_Invoice_2018} =    get length  ${Invoice_2018}
    ${length_Invoice_2017} =    get length  ${Invoice_2017}

    ${Sum_Invoice_2018} =  run keyword if  "${length_Invoice_2018}" != "0"     Get Invoice of each outlet     @{Invoice_2018}[-1]   @{Invoice_2018}[0]  2018  ${list_outlet}  salesinfo
    ...                              ELSE   create dictionary
    ${Sum_Invoice_2017} =  run keyword if  "${length_Invoice_2017}" != "0"     Get Invoice of each outlet     @{Invoice_2017}[-1]   @{Invoice_2017}[0]  2017  ${list_outlet}  salesinfo_2017
    ...                              ELSE   create dictionary

    log dictionary  ${Sum_Invoice_2018}
    log dictionary  ${Sum_Invoice_2017}

    log many  ${Sum_Invoice_2018}  ${Sum_Invoice_2017}
    [Return]  ${Sum_Invoice_2018}  ${Sum_Invoice_2017}

Evaluate Average Invoice periodic
    [Arguments]  ${month}  ${year}  ${list_outlet}
    log many  ${month}  ${year}
    ${period} =   timerange_Income_Avg_period   ${month}   ${year}

    ${Period_Invoice_2018} =  Get Invoice of each outlet     @{period}[0]   @{period}[-1]  2018  ${list_outlet}  salesinfo
    ${Period_Invoice_2017} =  Get Invoice of each outlet     @{period}[0]   @{period}[-1]  2017  ${list_outlet}  salesinfo_2017
    ${Period_Invoice_2016} =  Get Invoice of each outlet     @{period}[0]   @{period}[-1]  2016  ${list_outlet}  salesinfo_2016

    log dictionary  ${Period_Invoice_2018}
    log dictionary  ${Period_Invoice_2017}
    log dictionary  ${Period_Invoice_2016}

    log many  ${Period_Invoice_2018}    ${Period_Invoice_2017}  ${Period_Invoice_2016}
    [Return]  ${Period_Invoice_2018}    ${Period_Invoice_2017}  ${Period_Invoice_2016}

Evaluate Average Invoice value in three months of all outlets
    [Arguments]  ${month}  ${year}  ${list_outlet}
    set test variable  ${Avg_Invoice}   0
    set test variable  ${sum1}          0
    set test variable  ${sum2}          0

    ${Invoice_2018}    ${Invoice_2017} =     timerange_Invoice_Avg_3mths   ${month}   ${year}
    ${length_Invoice_2018} =    get length  ${Invoice_2018}
    ${length_Invoice_2017} =    get length  ${Invoice_2017}

    ${tmp1} =  run keyword if  "${length_Invoice_2018}" != "0"     Get Invoice of all outlet     @{Invoice_2018}[-1]   @{Invoice_2018}[0]  2018  ${list_outlet}  salesinfo
    ${tmp2} =  run keyword if  "${length_Invoice_2017}" != "0"     Get Invoice of all outlet     @{Invoice_2017}[-1]   @{Invoice_2017}[0]  2017  ${list_outlet}  salesinfo_2017

    ${sum1} =  set variable if  ${tmp1}==None     ${sum1}   ${tmp1}
    ${sum2} =  set variable if  ${tmp2}==None     ${sum2}   ${tmp2}

    ${Avg_Invoice} =  evaluate  (${sum1} + ${sum2})/3

    log       ${Avg_Invoice}
    [Return]  ${Avg_Invoice}

Evaluate Average Invoice periodic of all outlets
    [Arguments]  ${month}  ${year}  ${list_outlet}
    ${period} =   timerange_Income_Avg_period   ${month}   ${year}

    ${Period_Invoice_2018} =  Get Invoice of all outlet     @{period}[0]   @{period}[-1]  2018  ${list_outlet}  salesinfo
    ${Period_Invoice_2017} =  Get Invoice of all outlet     @{period}[0]   @{period}[-1]  2017  ${list_outlet}  salesinfo_2017
    ${Period_Invoice_2016} =  Get Invoice of all outlet     @{period}[0]   @{period}[-1]  2016  ${list_outlet}  salesinfo_2016

    log many  ${Period_Invoice_2018}    ${Period_Invoice_2017}  ${Period_Invoice_2016}
    [Return]  ${Period_Invoice_2018}    ${Period_Invoice_2017}  ${Period_Invoice_2016}

Evaluate Average Invoice value in three months of whole distributor
    [Arguments]  ${month}  ${year}  ${distributor_code}
    set test variable  ${Avg_Invoice}   0
    set test variable  ${sum1}          0
    set test variable  ${sum2}          0

    ${Invoice_2018}    ${Invoice_2017} =     timerange_Invoice_Avg_3mths   ${month}   ${year}
    ${length_Invoice_2018} =    get length  ${Invoice_2018}
    ${length_Invoice_2017} =    get length  ${Invoice_2017}

    ${tmp1} =  run keyword if  "${length_Invoice_2018}" != "0"     Get Invoice of whole distributor     @{Invoice_2018}[-1]   @{Invoice_2018}[0]  2018    ${distributor_code}  salesinfo
    ${tmp2} =  run keyword if  "${length_Invoice_2017}" != "0"     Get Invoice of whole distributor     @{Invoice_2017}[-1]   @{Invoice_2017}[0]  2017    ${distributor_code}  salesinfo_2017

    ${sum1} =  set variable if  ${tmp1}==None     ${sum1}   ${tmp1}
    ${sum2} =  set variable if  ${tmp2}==None     ${sum2}   ${tmp2}

    ${Avg_Invoice} =  evaluate  (${sum1} + ${sum2})/3

    log       ${Avg_Invoice}
    [Return]  ${Avg_Invoice}

Evaluate Average Invoice periodic of each model group
    [Arguments]  ${month}  ${year}  ${outlet_code}  ${model_group}
    ${period} =   timerange_Income_Avg_period   ${month}   ${year}

    ${Period_Invoice_2018} =  Get Invoice of each model group     @{period}[0]   @{period}[-1]  2018  ${outlet_code}    ${model_group}  salesinfo
    ${Period_Invoice_2017} =  Get Invoice of each model group     @{period}[0]   @{period}[-1]  2017  ${outlet_code}    ${model_group}  salesinfo_2017
    ${Period_Invoice_2016} =  Get Invoice of each model group     @{period}[0]   @{period}[-1]  2016  ${outlet_code}    ${model_group}  salesinfo_2016

    log many  ${Period_Invoice_2018}    ${Period_Invoice_2017}  ${Period_Invoice_2016}
    [Return]  ${Period_Invoice_2018}    ${Period_Invoice_2017}  ${Period_Invoice_2016}

#####################
### DISPLAY COST  ###
#####################

Get Display Cost and Location Cost of all outlets
    [Arguments]  ${month}  ${year}  ${outlet_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/DisplayCost_LocationCost_Setting_Total_Outlets.sql
    ${statement} =  replace string  ${statement}  %THANG            ${month}
    ${statement} =  replace string  ${statement}  %NAM              ${year}
    ${statement} =  replace string  ${statement}  %MA_CH            ${outlet_code}

    log       ${statement}
    ${rsl} =  query                 ${statement}
    ${rsl} =  convert to string     ${rsl}
    ${rsl} =  run keyword if        "${rsl}" == "[(None,)]"     set variable                    0
    ...                 ELSE                                    Convert db value to number      ${rsl}

    ${rsl} =  convert to number     ${rsl}
    log       ${rsl}
    [Return]  ${rsl}

Get Display Cost and Location Cost of each outlet
    [Arguments]  ${month}  ${year}  ${outlet_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/DisplayCost_LocationCost_Setting.sql
    ${statement} =  replace string  ${statement}  %THANG            ${month}
    ${statement} =  replace string  ${statement}  %NAM              ${year}
    ${statement} =  replace string  ${statement}  %MA_CH            ${outlet_code}

    ${Cost_Setting} =        query                       ${statement}
    ${Cost_Setting} =        convert to dictionary       ${Cost_Setting}

    log dictionary      ${Cost_Setting}
    log many            ${Cost_Setting}
    [Return]            ${Cost_Setting}

Get Display Cost of all outlets
    [Arguments]  ${month}  ${year}  ${outlet_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/DisplayCost_Setting_Total_Outlets.sql
    ${statement} =  replace string  ${statement}  %THANG            ${month}
    ${statement} =  replace string  ${statement}  %NAM              ${year}
    ${statement} =  replace string  ${statement}  %MA_CH            ${outlet_code}

    log       ${statement}
    ${rsl} =  query                 ${statement}
    ${rsl} =  convert to string     ${rsl}
    ${rsl} =  run keyword if        "${rsl}" == "[(None,)]"     set variable                    0
    ...                 ELSE                                    Convert db value to number      ${rsl}

    ${rsl} =  convert to number     ${rsl}
    log       ${rsl}
    [Return]  ${rsl}

Get Location Cost of all outlets
    [Arguments]  ${month}  ${year}  ${outlet_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/LocationCost_Setting_Total_Outlets.sql
    ${statement} =  replace string  ${statement}  %THANG            ${month}
    ${statement} =  replace string  ${statement}  %NAM              ${year}
    ${statement} =  replace string  ${statement}  %MA_CH            ${outlet_code}

    log       ${statement}
    ${rsl} =  query                 ${statement}
    ${rsl} =  convert to string     ${rsl}
    ${rsl} =  run keyword if        "${rsl}" == "[(None,)]"     set variable                    0
    ...                 ELSE                                    Convert db value to number      ${rsl}

    ${rsl} =  convert to number     ${rsl}
    log       ${rsl}
    [Return]  ${rsl}


######################
### CAL PARAMETER  ###
######################
Merge string outlet code
    [Arguments]  ${list_outlet}

    ${str_outlet} =  set variable   STRI
    :FOR  ${code}  IN   @{list_outlet}
    \   ${str_outlet} =  catenate        ${str_outlet}   ,  '${code}'
    ${str_outlet} =      remove string   ${str_outlet}   STRI${SPACE},${SPACE}

    [Return]  ${str_outlet}

Convert db value to number
    [Arguments]  ${vla}
    ${vla} =  fetch from right      ${vla}  ('
    ${vla} =  fetch from left       ${vla}  ')
    ${vla} =  convert to number     ${vla}

    log       ${vla}
    [Return]  ${vla}

Convert value None
    # If parameter has value None --> transform to '${EMPTY}' and else return "String"
    [Arguments]   ${vla}
    ${result} =  run keyword if  '${vla}' == 'None'   set variable       ${EMPTY}
    ...                    ELSE                       convert to string  ${vla}

    log       ${result}
    [Return]  ${result}

Evaluate Growth
    [Arguments]  ${invoice_curt_year}   ${invoice_last_year}
    log many     ${invoice_curt_year}   ${invoice_last_year}
    ${growth_value} =  run keyword if   ${invoice_last_year}!= 0    evaluate      (${invoice_curt_year}-${invoice_last_year})/(${invoice_last_year}+0.0000000001)*100
    ...                       ELSE IF   ${invoice_last_year}== 0    set variable   0

    log       ${growth_value}
    [Return]  ${growth_value}

Evaluate Invest,Growth Values and group outlets at step1
    [Arguments]  ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${threshold_invest}=8    ${threshold_growth}=150
    # Get list outlets have display plan
    # Get list all outlet
    ${list_outlet} =  Get list outlets of each distributor after HBS  ${last_month}  ${year}  ${distributor_code}
    ${lth_outlet} =   get length  ${list_outlet}
    log to console  ${lth_outlet}

    # Get string combine all outlet code to input query Invoice
    ${str_all_outlet} =  Get string combine all outlets of each distributor after HBS  ${last_month}  ${year}  ${distributor_code}

    # Get average Invoice of outlet in three months
    ${Dict_Outlet_Invoice_2018}  ${Dict_Outlet_Invoice_2017} =  Evaluate Average Invoice value in three months  ${test_month}  ${year}  ${str_all_outlet}

    # Get total display cost and location cost of each outlet
    ${Dict_Outlet_Cost_Setting} =  Get Display Cost and Location Cost of each outlet  ${last_month}  ${year}  ${str_all_outlet}

    # Get average Invoice of outlet in period time current year and last year
    ${Dict_Period_Invoice_2018}  ${Dict_Period_Invoice_2017}  ${Dict_Period_Invoice_2016} =  Evaluate Average Invoice periodic  ${test_month}  ${year}  ${str_all_outlet}

    ${lst_invest} =             create list
    ${lst_growth} =             create list
    ${Gr_DauTuChuaHieuQua} =    create list
    ${Gr_DauTuHieuQua} =        create list
    ${Gr_KhongNenDauTu} =       create list
    ${Gr_TangTruong} =          create list
    ${Outlet_Inv_zero_2017} =   create list
    ${Outlet_Inv_zero_2016} =   create list

    :FOR  ${outlet}  IN   @{list_outlet}
    \   ${outlet} =  convert to string   ${outlet}
    \   ${outlet} =  fetch from right    ${outlet}  ('
    \   ${outlet} =  fetch from left     ${outlet}  ',
    \   # CACULATE INVEST VALUE
    \   ${pass_Inv_2018} =  run keyword and return status       dictionary should contain key  ${Dict_Outlet_Invoice_2018}  ${outlet}
    \   ${pass_Inv_2017} =  run keyword and return status       dictionary should contain key  ${Dict_Outlet_Invoice_2017}  ${outlet}
    \   ${pass_Cost} =      run keyword and return status       dictionary should contain key  ${Dict_Outlet_Cost_Setting}  ${outlet}
    \   ${Inv_2018} =       run keyword if  ${pass_Inv_2018}    get from dictionary            ${Dict_Outlet_Invoice_2018}  ${outlet}
    \   ...                           ELSE  set variable        0
    \   ${Inv_2017} =       run keyword if  ${pass_Inv_2017}    get from dictionary            ${Dict_Outlet_Invoice_2017}  ${outlet}
    \   ...                           ELSE  set variable        0
    \   ${Cost} =           run keyword if  ${pass_Cost}        get from dictionary            ${Dict_Outlet_Cost_Setting}  ${outlet}
    \   ...                           ELSE  set variable        0
    \   ${Inv_2018} =  convert to number  ${Inv_2018}
    \   ${Inv_2017} =  convert to number  ${Inv_2017}
    \   ${Cost} =      convert to number  ${Cost}
    \   log many  ${Inv_2018}   ${Inv_2017}  ${Cost}
    \   ${avg_inv_threemths} =  evaluate  (${Inv_2018} + ${Inv_2017})/3
    \   ${Invest} =  evaluate  (${Cost}/${avg_inv_threemths})*100
    \   ${Invest} =  convert to number  ${Invest}
    \   # CACULATE GROWTH VALUE
    \   ${pass_Period_2018} =  run keyword and return status            dictionary should contain key   ${Dict_Period_Invoice_2018}  ${outlet}
    \   ${pass_Period_2017} =  run keyword and return status            dictionary should contain key   ${Dict_Period_Invoice_2017}  ${outlet}
    \   ${pass_Period_2016} =  run keyword and return status            dictionary should contain key   ${Dict_Period_Invoice_2016}  ${outlet}

    \   ${Period_Inv_2018} =   run keyword if  ${pass_Period_2018}      get from dictionary             ${Dict_Period_Invoice_2018}  ${outlet}
    \   ...                              ELSE  set variable             0
    \   ${Period_Inv_2017} =   run keyword if  ${pass_Period_2017}      get from dictionary             ${Dict_Period_Invoice_2017}  ${outlet}
    \   ...                              ELSE  set variable             0
    \   ${Period_Inv_2016} =   run keyword if  ${pass_Period_2016}      get from dictionary             ${Dict_Period_Invoice_2016}  ${outlet}
    \   ...                              ELSE  set variable             0

    \   log many  ${Period_Inv_2018}  ${Period_Inv_2017}  ${Period_Inv_2016}
    \   ${Growth} =  run keyword if  ${year}==2018 and ${test_month}==01    Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ...                 ELSE IF  ${year}==2018 and ${test_month}==02    Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ...                 ELSE IF  ${year}==2018                          Evaluate Growth  ${Period_Inv_2018}   ${Period_Inv_2017}
    \   ...                 ELSE IF  ${year}==2017                          Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ${Growth} =  convert to number   ${Growth}  2
    \   append to list  ${lst_invest}    ${Invest}
    \   append to list  ${lst_growth}    ${Growth}

    \   log many  ${Invest}  ${Growth}  ${threshold_invest}    ${threshold_growth}
    \   run keyword if  ${Invest}>= ${threshold_invest} and ${Growth}<= ${threshold_growth}    append to list   ${Gr_KhongNenDauTu}       ${outlet}
    \   ...    ELSE IF  ${Invest} < ${threshold_invest} and ${Growth} > ${threshold_growth}    append to list   ${Gr_DauTuHieuQua}        ${outlet}
    \   ...    ELSE IF  ${Invest} < ${threshold_invest} and ${Growth} < ${threshold_growth}    append to list   ${Gr_DauTuChuaHieuQua}    ${outlet}
    \   ...    ELSE IF  ${Invest} > ${threshold_invest} and ${Growth} > ${threshold_growth}    append to list   ${Gr_TangTruong}          ${outlet}

#    \   run keyword if  ${year}==2018 and ${test_month}==01 and ${Period_Inv_2016} == 0          append to list   ${Outlet_Inv_zero_2016}   ${outlet}
#    \   ...    ELSE IF  ${year}==2018 and ${test_month}==02 and ${Period_Inv_2016} == 0          append to list   ${Outlet_Inv_zero_2016}   ${outlet}
#    \   ...    ELSE IF  ${year} == 2018 and ${Period_Inv_2017} == 0                              append to list   ${Outlet_Inv_zero_2017}   ${outlet}
#    \   ...    ELSE IF  ${year} == 2017 and ${Period_Inv_2016} == 0                              append to list   ${Outlet_Inv_zero_2016}   ${outlet}
#    \   ...    ELSE IF  ${Invest} <  ${threshold_invest} and ${Growth} >  ${threshold_growth}    append to list   ${Gr_DauTuHieuQua}        ${outlet}
#    \   ...    ELSE IF  ${Invest} <  ${threshold_invest} and ${Growth} <  ${threshold_growth}    append to list   ${Gr_DauTuChuaHieuQua}    ${outlet}
#    \   ...    ELSE IF  ${Invest} >  ${threshold_invest} and ${Growth} >  ${threshold_growth}    append to list   ${Gr_TangTruong}          ${outlet}
#    \   ...    ELSE IF  ${Invest} >= ${threshold_invest} and ${Growth} <= ${threshold_growth}    append to list   ${Gr_KhongNenDauTu}       ${outlet}

    log list  ${Gr_DauTuHieuQua}
    log list  ${Gr_DauTuChuaHieuQua}
    log list  ${Gr_TangTruong}
    log list  ${Gr_KhongNenDauTu}
    log list  ${Outlet_Inv_zero_2017}
    log list  ${Outlet_Inv_zero_2016}

    log  ${lst_invest}
    log  ${lst_growth}

    [Return]  ${Gr_DauTuHieuQua}  ${Gr_DauTuChuaHieuQua}  ${Gr_TangTruong}  ${Gr_KhongNenDauTu}

Evaluate Invest,Growth Values and group outlets with filter Catgroup at step1
    [Arguments]  ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${threshold_invest}=8    ${threshold_growth}=150  ${cat_group}=None
    # Get list outlets have display plan
    # Get list all outlet
    ${list_outlet} =  Get list of outlets by Catgroup after HBS  ${last_month}  ${year}  ${distributor_code}  ${cat_group}
    ${lth_outlet} =   get length  ${list_outlet}
    log to console  ${lth_outlet}

    # Get string combine all outlet code to input query Invoice
    ${str_all_outlet} =  Get string combine outlets by Catgroup after HBS  ${last_month}  ${year}  ${distributor_code}  ${cat_group}

    # Get average Invoice of outlet in three months
    ${Dict_Outlet_Invoice_2018}  ${Dict_Outlet_Invoice_2017} =  Evaluate Average Invoice value in three months  ${test_month}  ${year}  ${str_all_outlet}

    # Get total display cost and location cost of each outlet
    ${Dict_Outlet_Cost_Setting} =  Get Display Cost and Location Cost of each outlet  ${last_month}  ${year}  ${str_all_outlet}

    # Get average Invoice of outlet in period time current year and last year
    ${Dict_Period_Invoice_2018}  ${Dict_Period_Invoice_2017}  ${Dict_Period_Invoice_2016} =  Evaluate Average Invoice periodic  ${test_month}  ${year}  ${str_all_outlet}

    ${lst_invest} =             create list
    ${lst_growth} =             create list
    ${Gr_DauTuChuaHieuQua} =    create list
    ${Gr_DauTuHieuQua} =        create list
    ${Gr_KhongNenDauTu} =       create list
    ${Gr_TangTruong} =          create list
    ${Outlet_Inv_zero_2017} =   create list
    ${Outlet_Inv_zero_2016} =   create list

    :FOR  ${outlet}  IN   @{list_outlet}
    \   ${outlet} =  convert to string   ${outlet}
    \   ${outlet} =  fetch from right    ${outlet}  ('
    \   ${outlet} =  fetch from left     ${outlet}  ',
    \   # CACULATE INVEST VALUE
    \   ${pass_Inv_2018} =  run keyword and return status       dictionary should contain key  ${Dict_Outlet_Invoice_2018}  ${outlet}
    \   ${pass_Inv_2017} =  run keyword and return status       dictionary should contain key  ${Dict_Outlet_Invoice_2017}  ${outlet}
    \   ${pass_Cost} =      run keyword and return status       dictionary should contain key  ${Dict_Outlet_Cost_Setting}  ${outlet}
    \   ${Inv_2018} =       run keyword if  ${pass_Inv_2018}    get from dictionary            ${Dict_Outlet_Invoice_2018}  ${outlet}
    \   ...                           ELSE  set variable        0
    \   ${Inv_2017} =       run keyword if  ${pass_Inv_2017}    get from dictionary            ${Dict_Outlet_Invoice_2017}  ${outlet}
    \   ...                           ELSE  set variable        0
    \   ${Cost} =           run keyword if  ${pass_Cost}        get from dictionary            ${Dict_Outlet_Cost_Setting}  ${outlet}
    \   ...                           ELSE  set variable        0
    \   ${Inv_2018} =  convert to number  ${Inv_2018}
    \   ${Inv_2017} =  convert to number  ${Inv_2017}
    \   ${Cost} =      convert to number  ${Cost}
    \   log many  ${Inv_2018}   ${Inv_2017}  ${Cost}
    \   ${avg_inv_threemths} =  evaluate  (${Inv_2018} + ${Inv_2017})/3
    \   ${Invest} =  evaluate  (${Cost}/${avg_inv_threemths})*100
    \   ${Invest} =  convert to number  ${Invest}
    \   # CACULATE GROWTH VALUE
    \   ${pass_Period_2018} =  run keyword and return status            dictionary should contain key   ${Dict_Period_Invoice_2018}  ${outlet}
    \   ${pass_Period_2017} =  run keyword and return status            dictionary should contain key   ${Dict_Period_Invoice_2017}  ${outlet}
    \   ${pass_Period_2016} =  run keyword and return status            dictionary should contain key   ${Dict_Period_Invoice_2016}  ${outlet}

    \   ${Period_Inv_2018} =   run keyword if  ${pass_Period_2018}      get from dictionary             ${Dict_Period_Invoice_2018}  ${outlet}
    \   ...                              ELSE  set variable             0
    \   ${Period_Inv_2017} =   run keyword if  ${pass_Period_2017}      get from dictionary             ${Dict_Period_Invoice_2017}  ${outlet}
    \   ...                              ELSE  set variable             0
    \   ${Period_Inv_2016} =   run keyword if  ${pass_Period_2016}      get from dictionary             ${Dict_Period_Invoice_2016}  ${outlet}
    \   ...                              ELSE  set variable             0

    \   log many  ${Period_Inv_2018}  ${Period_Inv_2017}  ${Period_Inv_2016}
    \   ${Growth} =  run keyword if  ${year}==2018 and ${test_month}==01    Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ...                 ELSE IF  ${year}==2018 and ${test_month}==02    Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ...                 ELSE IF  ${year}==2018                          Evaluate Growth  ${Period_Inv_2018}   ${Period_Inv_2017}
    \   ...                 ELSE IF  ${year}==2017                          Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ${Growth} =  convert to number   ${Growth}  2
    \   append to list  ${lst_invest}    ${Invest}
    \   append to list  ${lst_growth}    ${Growth}

    \   log many  ${Invest}  ${Growth}  ${threshold_invest}    ${threshold_growth}
    \   run keyword if  ${year}==2018 and ${test_month}==01 and ${Period_Inv_2016} == 0          append to list   ${Outlet_Inv_zero_2016}   ${outlet}
    \   ...    ELSE IF  ${year}==2018 and ${test_month}==02 and ${Period_Inv_2016} == 0          append to list   ${Outlet_Inv_zero_2016}   ${outlet}
    \   ...    ELSE IF  ${year} == 2018 and ${Period_Inv_2017} == 0                              append to list   ${Outlet_Inv_zero_2017}   ${outlet}
    \   ...    ELSE IF  ${year} == 2017 and ${Period_Inv_2016} == 0                              append to list   ${Outlet_Inv_zero_2016}   ${outlet}
    \   ...    ELSE IF  ${Invest} < ${threshold_invest} and ${Growth} > ${threshold_growth}   append to list   ${Gr_DauTuHieuQua}        ${outlet}
    \   ...    ELSE IF  ${Invest} < ${threshold_invest} and ${Growth} < ${threshold_growth}   append to list   ${Gr_DauTuChuaHieuQua}    ${outlet}
    \   ...    ELSE IF  ${Invest} > ${threshold_invest} and ${Growth} > ${threshold_growth}   append to list   ${Gr_TangTruong}          ${outlet}
    \   ...    ELSE IF  ${Invest} > ${threshold_invest} and ${Growth} < ${threshold_growth}   append to list   ${Gr_KhongNenDauTu}       ${outlet}

    log list  ${Gr_DauTuHieuQua}
    log list  ${Gr_DauTuChuaHieuQua}
    log list  ${Gr_TangTruong}
    log list  ${Gr_KhongNenDauTu}
    log list  ${Outlet_Inv_zero_2017}
    log list  ${Outlet_Inv_zero_2016}

    log  ${lst_invest}
    log  ${lst_growth}

    [Return]  ${Gr_DauTuHieuQua}  ${Gr_DauTuChuaHieuQua}  ${Gr_TangTruong}  ${Gr_KhongNenDauTu}

Evaluate Invest,Growth Values and group outlets with filter Modelgroup at step1
    [Arguments]  ${test_month}  ${last_month}  ${year}  ${distributor_code}  ${threshold_invest}=8    ${threshold_growth}=150  ${model_group}=None
    # Get list outlets have display plan
    # Get list all outlet
    ${list_outlet} =  Get list of outlets by ModelGroup after HBS  ${last_month}  ${year}  ${distributor_code}  ${model_group}
    ${lth_outlet} =   get length  ${list_outlet}
    log to console  ${lth_outlet}

    # Get string combine all outlet code to input query Invoice
    ${str_all_outlet} =  Get string combine outlets by ModelGroup after HBS  ${last_month}  ${year}  ${distributor_code}  ${model_group}

    # Get average Invoice of outlet in three months
    ${Dict_Outlet_Invoice_2018}  ${Dict_Outlet_Invoice_2017} =  Evaluate Average Invoice value in three months  ${test_month}  ${year}  ${str_all_outlet}

    # Get total display cost and location cost of each outlet
    ${Dict_Outlet_Cost_Setting} =  Get Display Cost and Location Cost of each outlet  ${last_month}  ${year}  ${str_all_outlet}

    # Get average Invoice of outlet in period time current year and last year
    ${Dict_Period_Invoice_2018}  ${Dict_Period_Invoice_2017}  ${Dict_Period_Invoice_2016} =  Evaluate Average Invoice periodic  ${test_month}  ${year}  ${str_all_outlet}

    ${lst_invest} =             create list
    ${lst_growth} =             create list
    ${Gr_DauTuChuaHieuQua} =    create list
    ${Gr_DauTuHieuQua} =        create list
    ${Gr_KhongNenDauTu} =       create list
    ${Gr_TangTruong} =          create list
    ${Outlet_Inv_zero_2017} =   create list
    ${Outlet_Inv_zero_2016} =   create list

    :FOR  ${outlet}  IN   @{list_outlet}
    \   ${outlet} =  convert to string   ${outlet}
    \   ${outlet} =  fetch from right    ${outlet}  ('
    \   ${outlet} =  fetch from left     ${outlet}  ',
    \   # CACULATE INVEST VALUE
    \   ${pass_Inv_2018} =  run keyword and return status       dictionary should contain key  ${Dict_Outlet_Invoice_2018}  ${outlet}
    \   ${pass_Inv_2017} =  run keyword and return status       dictionary should contain key  ${Dict_Outlet_Invoice_2017}  ${outlet}
    \   ${pass_Cost} =      run keyword and return status       dictionary should contain key  ${Dict_Outlet_Cost_Setting}  ${outlet}
    \   ${Inv_2018} =       run keyword if  ${pass_Inv_2018}    get from dictionary            ${Dict_Outlet_Invoice_2018}  ${outlet}
    \   ...                           ELSE  set variable        0
    \   ${Inv_2017} =       run keyword if  ${pass_Inv_2017}    get from dictionary            ${Dict_Outlet_Invoice_2017}  ${outlet}
    \   ...                           ELSE  set variable        0
    \   ${Cost} =           run keyword if  ${pass_Cost}        get from dictionary            ${Dict_Outlet_Cost_Setting}  ${outlet}
    \   ...                           ELSE  set variable        0
    \   ${Inv_2018} =  convert to number  ${Inv_2018}
    \   ${Inv_2017} =  convert to number  ${Inv_2017}
    \   ${Cost} =      convert to number  ${Cost}
    \   log many  ${Inv_2018}   ${Inv_2017}  ${Cost}
    \   ${avg_inv_threemths} =  evaluate  (${Inv_2018} + ${Inv_2017})/3
    \   ${Invest} =  evaluate  (${Cost}/${avg_inv_threemths})*100
    \   ${Invest} =  convert to number  ${Invest}
    \   # CACULATE GROWTH VALUE
    \   ${pass_Period_2018} =  run keyword and return status            dictionary should contain key   ${Dict_Period_Invoice_2018}  ${outlet}
    \   ${pass_Period_2017} =  run keyword and return status            dictionary should contain key   ${Dict_Period_Invoice_2017}  ${outlet}
    \   ${pass_Period_2016} =  run keyword and return status            dictionary should contain key   ${Dict_Period_Invoice_2016}  ${outlet}

    \   ${Period_Inv_2018} =   run keyword if  ${pass_Period_2018}      get from dictionary             ${Dict_Period_Invoice_2018}  ${outlet}
    \   ...                              ELSE  set variable             0
    \   ${Period_Inv_2017} =   run keyword if  ${pass_Period_2017}      get from dictionary             ${Dict_Period_Invoice_2017}  ${outlet}
    \   ...                              ELSE  set variable             0
    \   ${Period_Inv_2016} =   run keyword if  ${pass_Period_2016}      get from dictionary             ${Dict_Period_Invoice_2016}  ${outlet}
    \   ...                              ELSE  set variable             0

    \   log many  ${Period_Inv_2018}  ${Period_Inv_2017}  ${Period_Inv_2016}
    \   ${Growth} =  run keyword if  ${year}==2018 and ${test_month}==01    Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ...                 ELSE IF  ${year}==2018 and ${test_month}==02    Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ...                 ELSE IF  ${year}==2018                          Evaluate Growth  ${Period_Inv_2018}   ${Period_Inv_2017}
    \   ...                 ELSE IF  ${year}==2017                          Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ${Growth} =  convert to number   ${Growth}  2
    \   append to list  ${lst_invest}    ${Invest}
    \   append to list  ${lst_growth}    ${Growth}

    \   log many  ${Invest}  ${Growth}  ${threshold_invest}    ${threshold_growth}
    \   run keyword if  ${year}==2018 and ${test_month}==01 and ${Period_Inv_2016} == 0          append to list   ${Outlet_Inv_zero_2016}   ${outlet}
    \   ...    ELSE IF  ${year}==2018 and ${test_month}==02 and ${Period_Inv_2016} == 0          append to list   ${Outlet_Inv_zero_2016}   ${outlet}
    \   ...    ELSE IF  ${year} == 2018 and ${Period_Inv_2017} == 0                              append to list   ${Outlet_Inv_zero_2017}   ${outlet}
    \   ...    ELSE IF  ${year} == 2017 and ${Period_Inv_2016} == 0                              append to list   ${Outlet_Inv_zero_2016}   ${outlet}
    \   ...    ELSE IF  ${Invest} < ${threshold_invest} and ${Growth} > ${threshold_growth}   append to list   ${Gr_DauTuHieuQua}        ${outlet}
    \   ...    ELSE IF  ${Invest} < ${threshold_invest} and ${Growth} < ${threshold_growth}   append to list   ${Gr_DauTuChuaHieuQua}    ${outlet}
    \   ...    ELSE IF  ${Invest} > ${threshold_invest} and ${Growth} > ${threshold_growth}   append to list   ${Gr_TangTruong}          ${outlet}
    \   ...    ELSE IF  ${Invest} > ${threshold_invest} and ${Growth} < ${threshold_growth}   append to list   ${Gr_KhongNenDauTu}       ${outlet}

    log list  ${Gr_DauTuHieuQua}
    log list  ${Gr_DauTuChuaHieuQua}
    log list  ${Gr_TangTruong}
    log list  ${Gr_KhongNenDauTu}
    log list  ${Outlet_Inv_zero_2017}
    log list  ${Outlet_Inv_zero_2016}

    log  ${lst_invest}
    log  ${lst_growth}

    [Return]  ${Gr_DauTuHieuQua}  ${Gr_DauTuChuaHieuQua}  ${Gr_TangTruong}  ${Gr_KhongNenDauTu}

########################
### INVOICE HISTORY  ###
########################
Get Invoice History of outlet as modelgroup
    [Arguments]  ${ls_model_group}  ${month}  ${year}  ${outlet_code}
    ${dt} =                create dictionary   Ụ Kệ DBB=289   SCM=297   NGUYÊN KEM=304   SỮA BỘT FRISO=327   Ụ IFT=362   KỆ FINO=377   Fristi kệ hình chai=391
    ${dict_modelgp_db} =   create dictionary

    :FOR  ${id}   IN    @{ls_model_group}
    \   ${list_tenp} =    create list
    \   ${model_group} =  set variable  &{dt}[${id}]
    \   ${Invoice_2018}    ${Invoice_2017} =     timerange_Invoice_Avg_3mths   ${month}   ${year}
    \   ${lgth_Invoice_2018} =  get length  ${Invoice_2018}
    \   ${lgth_Invoice_2017} =  get length  ${Invoice_2017}
    \   ${First_Inv} =   run keyword if   ${lgth_Invoice_2018}==3   Get Invoice of each model group   @{Invoice_2018}[2]   @{Invoice_2018}[2]  2018  ${outlet_code}  ${model_group}   salesinfo
    \   ...                     ELSE IF   ${lgth_Invoice_2018}==2   Get Invoice of each model group   @{Invoice_2017}[0]   @{Invoice_2017}[0]  2017  ${outlet_code}  ${model_group}   salesinfo_2017
    \   ...                     ELSE IF   ${lgth_Invoice_2018}==1   Get Invoice of each model group   @{Invoice_2017}[1]   @{Invoice_2017}[1]  2017  ${outlet_code}  ${model_group}   salesinfo_2017
    \   ...                     ELSE                                Get Invoice of each model group   @{Invoice_2017}[2]   @{Invoice_2017}[2]  2017  ${outlet_code}  ${model_group}   salesinfo_2017

    \   ${Second_Inv} =  run keyword if   ${lgth_Invoice_2018}==3   Get Invoice of each model group   @{Invoice_2018}[1]   @{Invoice_2018}[1]  2018  ${outlet_code}  ${model_group}   salesinfo
    \   ...                     ELSE IF   ${lgth_Invoice_2018}==2   Get Invoice of each model group   @{Invoice_2018}[1]   @{Invoice_2018}[1]  2018  ${outlet_code}  ${model_group}   salesinfo
    \   ...                     ELSE IF   ${lgth_Invoice_2018}==1   Get Invoice of each model group   @{Invoice_2017}[0]   @{Invoice_2017}[0]  2017  ${outlet_code}  ${model_group}   salesinfo_2017
    \   ...                     ELSE                                Get Invoice of each model group   @{Invoice_2017}[1]   @{Invoice_2017}[1]  2017  ${outlet_code}  ${model_group}   salesinfo_2017

    \   ${Third_Inv} =   run keyword if   ${lgth_Invoice_2018}==3   Get Invoice of each model group   @{Invoice_2018}[0]   @{Invoice_2018}[0]  2018  ${outlet_code}  ${model_group}   salesinfo
    \   ...                     ELSE IF   ${lgth_Invoice_2018}==2   Get Invoice of each model group   @{Invoice_2018}[0]   @{Invoice_2018}[0]  2018  ${outlet_code}  ${model_group}   salesinfo
    \   ...                     ELSE IF   ${lgth_Invoice_2018}==1   Get Invoice of each model group   @{Invoice_2018}[0]   @{Invoice_2018}[0]  2018  ${outlet_code}  ${model_group}   salesinfo
    \   ...                     ELSE                                Get Invoice of each model group   @{Invoice_2017}[0]   @{Invoice_2017}[0]  2017  ${outlet_code}  ${model_group}   salesinfo_2017

    \   ${Avg_Inv_3months} =  evaluate  (${First_Inv}+${Second_Inv}+${Third_Inv})/3
    \   ${Avg_Inv_3months} =  convert to number   ${Avg_Inv_3months}   2
    \   ${Period_Inv_2018}    ${Period_Inv_2017}  ${Period_Inv_2016} =  Evaluate Average Invoice periodic of each model group  ${month}  ${year}  ${outlet_code}  ${model_group}
    \   ${Growth} =  run keyword if  ${year}==2018 and ${month}==01     Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ...                 ELSE IF  ${year}==2018 and ${month}==02     Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ...                 ELSE IF  ${year}==2018                      Evaluate Growth  ${Period_Inv_2018}   ${Period_Inv_2017}
    \   ...                 ELSE IF  ${year}==2017                      Evaluate Growth  ${Period_Inv_2017}   ${Period_Inv_2016}
    \   ${Percent_Growth} =  convert to number   ${Growth}  2
    \   ${Dict_Outlet_Invoice_2018}  ${Dict_Outlet_Invoice_2017} =  Evaluate Average Invoice value in three months  ${month}  ${year}  ${outlet_code}

    \   ${outlet_key} =  remove string  ${outlet_code}  '
    \   ${pass_Inv_2018} =  run keyword and return status       dictionary should contain key  ${Dict_Outlet_Invoice_2018}  ${outlet_key}
    \   ${pass_Inv_2017} =  run keyword and return status       dictionary should contain key  ${Dict_Outlet_Invoice_2017}  ${outlet_key}
    \   ${Inv_2018} =       run keyword if  ${pass_Inv_2018}    get from dictionary            ${Dict_Outlet_Invoice_2018}  ${outlet_key}
    \   ...                           ELSE  set variable        0
    \   ${Inv_2017} =       run keyword if  ${pass_Inv_2017}    get from dictionary            ${Dict_Outlet_Invoice_2017}  ${outlet_key}
    \   ...                           ELSE  set variable        0

    \   ${Inv_2018} =  convert to number  ${Inv_2018}
    \   ${Inv_2017} =  convert to number  ${Inv_2017}

    \   ${Invoice_AllModelgroup} =  evaluate            (${Inv_2018}+${Inv_2017})/3
    \   ${Percent_Contribute} =     evaluate            ${Avg_Inv_3months}/${Invoice_AllModelgroup}*100
    \   ${Percent_Contribute} =     convert to number   ${Percent_Contribute}   2
    \   run keyword if  ${year}==2018 and ${month}==01   append to list  ${list_tenp}  ${First_Inv}  ${Second_Inv}   ${Third_Inv}    ${Avg_Inv_3months}  ${Period_Inv_2016}  ${Period_Inv_2017}  ${Percent_Contribute}  ${Percent_Contribute}
    \   ...    ELSE IF  ${year}==2018 and ${month}==02   append to list  ${list_tenp}  ${First_Inv}  ${Second_Inv}   ${Third_Inv}    ${Avg_Inv_3months}  ${Period_Inv_2016}  ${Period_Inv_2017}  ${Percent_Contribute}  ${Percent_Contribute}
    \   ...    ELSE IF  ${year}==2018                    append to list  ${list_tenp}  ${First_Inv}  ${Second_Inv}   ${Third_Inv}    ${Avg_Inv_3months}  ${Period_Inv_2017}  ${Period_Inv_2018}  ${Percent_Contribute}  ${Percent_Contribute}
    \   ...    ELSE IF  ${year}==2017                    append to list  ${list_tenp}  ${First_Inv}  ${Second_Inv}   ${Third_Inv}    ${Avg_Inv_3months}  ${Period_Inv_2016}  ${Period_Inv_2017}  ${Percent_Contribute}  ${Percent_Contribute}

    \   set to dictionary  ${dict_modelgp_db}  ${id}  ${list_tenp}
    \   log             ${model_group}
    \   log list        ${list_tenp}
    \   log dictionary  ${dict_modelgp_db}
    log dictionary  ${dict_modelgp_db}
    [Return]        ${dict_modelgp_db}


###########################
###  DETAIL MODELGROUP  ###
###########################
Get outletmodel registered of last month
    # Return detail item of each model group which outlet registered
    [Arguments]  ${month}  ${year}  ${outlet_code}
    # Insert needed information
    ${statement} =  get file  C:/FCV/SQL_Scripts/Detail_Outlet_ModelGroup.sql
    ${statement} =  replace string  ${statement}  %THANG                ${month}
    ${statement} =  replace string  ${statement}  %NAM                  ${year}
    ${statement} =  replace string  ${statement}  %MA_CH                ${outlet_code}

    log       ${statement}
    ${rsl} =  query                     ${statement}
    ${rsl} =  convert to list     ${rsl}

    log list  ${rsl}

    ${dict_modelgroupid} =       create dictionary   34=Ụ Kệ DBB     35=SCM   37=NGUYÊN KEM   39=SỮA BỘT FRISO   50=Ụ IFT   55=KỆ FINO   59=Fristi kệ hình chai
    ${modelgroupid} =            create dictionary
    ${keys} =  get dictionary keys  ${dict_modelgroupid}
    log  ${keys}

    ${number_modelgroup} =  get length  ${rsl}
    :FOR  ${idx}  IN  @{rsl}
    \   log  ${idx}
    \   ${tmp} =  convert to list  ${idx}
    \   ${first} =      set variable  @{tmp}[0]
    \   ${second} =     set variable  @{tmp}[1]
    \   ${third} =      set variable  @{tmp}[2]
    \   ${four} =       set variable  @{tmp}[3]
    \   ${first} =   convert to string    ${first}
    \   ${key} =     get from dictionary  ${dict_modelgroupid}  ${first}
    \   ${second} =  run keyword  Convert value None  ${second}
    \   ${third} =   run keyword  Convert value None  ${third}
    \   ${four} =    run keyword  Convert value None  ${four}
    \   log many  ${key}  ${second}   ${third}   ${four}
    \   ${list_ele} =      create list      ${second}   ${third}      ${four}
    \   set to dictionary  ${modelgroupid}  ${key}      ${list_ele}

    ${nb_modelgroup} =  get dictionary keys  ${modelgroupid}   # return list modelgroup which outlet have display plan in month [U ke DBB, SCM, Nguyen Kem]

    log dictionary  ${modelgroupid}
    [Return]        ${nb_modelgroup}  ${modelgroupid}


####################################
###  TABLE EFFECTIVE INVESTMENT  ###
####################################

###########################
###  DATA IN DASHBOARD  ###
###########################
# CHART 1
Get number of outlet in chart 1
    [Arguments]  ${month}  ${year}  ${distributor_code}

    ${lst_month} =  evaluate           ${month}-1
    ${temp} =       convert to string  ${lst_month}
    ${lst_month} =  run keyword if  0< ${lst_month} <10     catenate  SEPARATOR=  0  ${temp}
    ...                       ELSE     ${lst_month}

    ${db_total_nb_outlet} =     Get whole number outlet which distributor manage                                ${distributor_code}
    ${db_target_nb_outlet} =    Get total number outlets of each distributor after HBS  ${lst_month}  ${year}   ${distributor_code}
    ${db_reality_nb_outlet} =   Get total number outlets of each distributor after HBS  ${month}      ${year}   ${distributor_code}
    ${db_remain_nb_outlet} =    evaluate  ${db_total_nb_outlet} - ${db_reality_nb_outlet}
    ${db_percent_complete} =    ${db_reality_nb_outlet}/${db_target_nb_outlet}*100
    ${db_percent_complete} =    convert to number  ${db_percent_complete}  2

    log many  ${db_total_nb_outlet}  ${db_target_nb_outlet}  ${db_reality_nb_outlet}  ${db_remain_nb_outlet}  ${db_percent_complete}
    [Return]  ${db_total_nb_outlet}  ${db_target_nb_outlet}  ${db_reality_nb_outlet}  ${db_remain_nb_outlet}  ${db_percent_complete}

# CHART 2
Get number of outlet in chart 2
    [Arguments]  ${month}  ${year}  ${distributor_code}

    ${lst_month} =  evaluate           ${month}-1
    ${temp} =       convert to string  ${lst_month}
    ${lst_month} =  run keyword if  0< ${lst_month} <10     catenate  SEPARATOR=  0  ${temp}
    ...                       ELSE     ${lst_month}

    ${nb_outlet_DBB_target} =  Get number outlets by Catgroup after HBS                 ${lst_month}  ${year}  ${distributor_code}  DBB
    ${nb_outlet_IFT_target} =  Get number outlets by Catgroup after HBS                 ${lst_month}  ${year}  ${distributor_code}  IFT
    ${nb_outlet_ALL_target} =  Get total number outlets of each distributor after HBS   ${lst_month}  ${year}  ${distributor_code}

    ${nb_outlet_DBB_reality} =  Get number outlets by Catgroup after HBS                 ${month}  ${year}  ${distributor_code}  DBB
    ${nb_outlet_IFT_reality} =  Get number outlets by Catgroup after HBS                 ${month}  ${year}  ${distributor_code}  IFT
    ${nb_outlet_ALL_reality} =  Get total number outlets of each distributor after HBS   ${month}  ${year}  ${distributor_code}

    log many  ${nb_outlet_DBB_target}   ${nb_outlet_IFT_target}    ${nb_outlet_ALL_target}
    log many  ${nb_outlet_DBB_reality}  ${nb_outlet_IFT_reality}   ${nb_outlet_ALL_reality}
    [Return]  ${nb_outlet_DBB_target}   ${nb_outlet_IFT_target}    ${nb_outlet_ALL_target}  ${nb_outlet_DBB_reality}  ${nb_outlet_IFT_reality}   ${nb_outlet_ALL_reality}

# CHART 3
Get Invoice in chart 3
    [Arguments]  ${month}  ${year}  ${distributor_code}
#    ${list_outlet_DBB}
#    ${list_outlet_IFT}
#    ${list_outlet_ALL}
#    ${Invoice_DBB} =  Evaluate Average Invoice value in three months                 ${month}  ${year}  ${list_outlet_DBB}
#    ${Invoice_IFT} =  Evaluate Average Invoice value in three months                 ${month}  ${year}  ${list_outlet_IFT}
#    ${Invoice_ALL} =  Evaluate Average Invoice value in three months                 ${month}  ${year}  ${list_outlet_ALL}

    ${list_outlet_displayplan_DBB} =  Get string combine outlets by Catgroup after HBS              ${month}  ${year}  ${distributor_code}  DBB
    ${list_outlet_displayplan_IFT} =  Get string combine outlets by Catgroup after HBS              ${month}  ${year}  ${distributor_code}  IFT
    ${list_outlet_displayplan_ALL} =  Get string combine all outlets of each distributor after HBS  ${month}  ${year}  ${distributor_code}
    ${Invoice_DBB_Display_Outlet} =  Evaluate Average Invoice value in three months                 ${month}  ${year}  ${list_outlet_displayplan_DBB}
    ${Invoice_IFT_Display_Outlet} =  Evaluate Average Invoice value in three months                 ${month}  ${year}  ${list_outlet_displayplan_IFT}
    ${Invoice_ALL_Display_Outlet} =  Evaluate Average Invoice value in three months                 ${month}  ${year}  ${list_outlet_displayplan_ALL}

