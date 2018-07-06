*** Settings ***
Library  Selenium2Library

*** Variables ***
${BROWSER} =            chrome
${URL} =                http://www.banviengroup.com:86/ssologin.html?action=logout
#${URL} =                http://sso.fcv-etools.com/sso/auth/cRA6ZnhA1HJt-TiaTGqZYsl7uDA6KiW_sMmriGYf04l7_1F7y1ITZdvCbzRSczAScYWI91UiI-0FtzLzeMswfQ~~

${USERNAME} =           3574
${FULLNAME} =           TRẦN VĂN THANH
${PASSWORD} =           123456
${DISTRIBUTOR_CODE} =   337375.1
${CODE_DTHQ} =          C00293935           #Outlet code of group dau tu hieu qua
${CODE_DTCHQ} =         C00294241           #Outlet code of group dau tu CHUA hieu qua
${CODE_DTTTR} =         C00295132           #Outlet code of group dau tu TANG TRUONG
${CODE_KNDT} =          C00293859           #Outlet code of group KHONG NEN DAU TU
${CODE_DTHQ_FULL} =     '337375C00293935'   #FULL Outlet code of group dau tu hieu qua
${CODE_DTCHQ_FULL} =    '337375C00294241'   #FULL Outlet code of group dau tu CHUA hieu qua
${CODE_DTTTR_FULL} =    '337375C00295132'   #FULL Outlet code of group dau tu TANG TRUONG
${CODE_KNDT_FULL} =     '337375C00293859'   #FULL Outlet code of group KHONG NEN DAU TU
${TEST_MONTH} =         07
${LAST_MONTH} =         06
${TEST_YEAR} =          2018

${INVEST_DEF} =         8
${GROWTH_DEF} =         150

*** Keywords ***
Begin Web Test
    open browser  about:blank  ${BROWSER}
    maximize browser window

End Web Test
    close all browsers