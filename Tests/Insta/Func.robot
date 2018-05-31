*** Settings ***
Library  Selenium2Library
Library  Collections
Library  String
Library  Dialogs


*** Variables ***

*** Keywords ***
Begin Web Test
    open browser  about:blank  chrome
#    maximize browser window

End Web Test
    close all browsers

Access web Instagram
    [Arguments]  ${url}
    go to           ${url}
    wait until page contains element  xpath=//*[@id="react-root"]/section/main/article/div[2]/div[2]/p/a
    click element   xpath=//*[@id="react-root"]/section/main/article/div[2]/div[2]/p/a

Go to page Login
    [Arguments]  ${username}    ${password}
    wait until page contains element   name=username
    input text      name=username      ${username}
    input text      name=password      ${password}
    press key       name=password      \\13

Main Page
    wait until page contains    Bật thông báo
    click element               xpath=//*[contains(text(),'Lúc khác')]

Search HashTag
    go to                       https://www.instagram.com/explore/tags/saigon/
    wait until page contains    \#saigon

Choose photo which user have just posted
    # Click first user
    click element                       xpath=//div[@class='_si7dy']
    wait until page contains element    xpath=//div[@class='_ebcx9 ']

Link User Profile
    # access profile
    click element                       xpath=//div[@class='_eeohz']
    wait until page contains element    xpath=//section[@class='_o6mpc']

Like three photos
    # click and live first photo
    click element                       xpath=//div[@class='_si7dy']
    wait until page contains element    xpath=//div[@class='_ebcx9 ']
    click element                       xpath=//a[@class='_eszkz _l9yih']
    sleep  2s
    pause execution

    # move right arrow, wait new page loaded and click like
    click element                       xpath=//a[contains(@class,'coreSpriteRightPaginationArrow')]
    wait until page contains element    xpath=//div[@class='_ebcx9 ']
    click element                       xpath=//a[@class='_eszkz _l9yih']
    sleep  2s
    pause execution

    # move right arrow, wait new page loaded and click like
    click element                       xpath=//a[contains(@class,'coreSpriteRightPaginationArrow')]
    wait until page contains element    xpath=//div[@class='_ebcx9 ']
    click element                       xpath=//a[@class='_eszkz _l9yih']
    sleep  2s
    pause execution

Open the most recent photo of User
    click element                       xpath=//div[@class='_si7dy']
    wait until page contains element    xpath=//div[@class='_ebcx9 ']

Like photo
    click element                       xpath=//a[@class='_eszkz _l9yih']

Quit current user profile TO prepare moving on next user
    click element  xpath=//button[@class='_dcj9f']
    go back
    sleep  2s

Press button arrow right
    click element                       xpath=//a[contains(@class,'coreSpriteRightPaginationArrow')]
    wait until page contains element    xpath=//div[@class='_ebcx9 ']




Get index of this account
    ${nb_post} =        get text  xpath=//ul[@class='_h9luf ']/li[1]/span
    ${nb_follower} =    get text  xpath=//ul[@class='_h9luf ']/li[2]
    ${nb_following} =   get text  xpath=//ul[@class='_h9luf ']/li[3]

    log many  ${nb_post}  ${nb_follower}  ${nb_following}
    [Return]  ${nb_post}  ${nb_follower}  ${nb_following}


