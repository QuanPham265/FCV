*** Settings ***

*** Variables ***
@{valid_start_month} =  10/2017  08/2017  01/2018  ${EMPTY}  ${EMPTY}
@{valid_end_month} =    01/2018  08/2017  12/2018  ${EMPTY}  12/2018
@{invalid_start_month} =  08/2017  05/2019
@{invalid_end_month} =    04/2017  08/2019


*** Keywords ***
