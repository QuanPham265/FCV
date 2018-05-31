*** Settings ***
Documentation  Test connection between Pycharm and Postgres SQL
Library  C:/FCV/Libraries/EditString.py
Resource  C:/FCV/Resources/Postgres_Server.robot


Library  Collections
Library  String
Library  C:/Python27/Lib/site-packages/robot/libraries/DateTime.py

# How to run this script
# pybot -d C:/results/trial  tests/trial/Postgres_Server_Test.robot

*** Variables ***
${statement} =              ${EMPTY}
${month} =                  04
${year} =                   2018
${distributor_code} =       337375.1
${cat_group} =              IFT
${model_group} =            NGUYÊN KEM

*** Test Cases ***
Run some simple sql database
    [Tags]  DB

    Postgres_Server.Connect database
    Postgres_Server.Get Invoice of whole Catgroup of Distributor  02  02  2018  ${distributor_code}  salesinfo  ALL
#    Postgres_Server.Get Invoice of all outlet  01  05  2018   '337375C00293737', '337375C00293751', '337375C00293755'    salesinfo
    Postgres_Server.Disconnect database
#    log to console  ${x}

*** Keywords ***


