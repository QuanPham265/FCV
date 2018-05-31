*** Settings ***
Library  Selenium2Library
Library  DatabaseLibrary
Library  String
Library  OperatingSystem
Library  Collections
Library  Dialogs

Test Setup          Start My tools
Test Teardown       Ending process

# How to run this Test Suite
# pybot -d C:/results/trial -i demo tests/trial/Insta.robot
# pybot -d C:/results/trial         tests/trial/Insta.robot


*** Variables ***
${browser} =  chrome
${url_path} =  https://www.instagram.com/?hl=en
${url_tags} =  https://www.instagram.com/explore/tags/%TAG/
${username} =  01268199265
${password} =  Pq260592

*** Keywords ***
Start My tools
    open browser  about:blank  ${browser}
#    maximize browser window

Ending process
    close all browsers

Connect to main page
    go to    ${url_path}
    wait until page contains element  xpath=//*[@id="react-root"]/section/main/article/div[2]/div[1]/div/form/div[6]/span/button

Fill username, pass and sign in
    click element  xpath=//*[@id="react-root"]/section/main/article/div[2]/div[2]/p/a
    input text  name=username  ${username}
    input text  name=password  ${password}
    click element  xpath=//*[@id="react-root"]/section/main/article/div[2]/div[1]/div/form/span/button
    wait until page contains  Turn on Notifications
    click element  xpath=/html/body/div[3]/div/div/div/div[3]/button[2]
    sleep  1s

Search particular tag
    [Arguments]  ${tags}
    ${tags_link} =  replace string  ${url_tags}  %TAG  ${tags}
    log  ${tags_link}
    go to  ${tags_link}
    wait until page contains element  xpath=//*[@id="react-root"]/section/main/article/header/div[2]/h1

Click recently post
    click element  xpath=//*[@id="react-root"]/section/main/article/div[2]/div/div[1]/div[1]/a/div/div[2]
    sleep  2s

Jump to profile
    click link  xpath=/html/body/div[2]/div/div[2]/div/article/div[2]/div[1]/ul/li/a
    sleep  2s

Get index of this account
    ${nb_post} =  get text  xpath=//*[@id="react-root"]/section/main/div/header/section/ul/li[1]/span/span
    ${nb_follower} =  get text  xpath=//*[@id="react-root"]/section/main/div/header/section/ul/li[2]/a/span
    ${nb_following} =  get text  xpath=//*[@id="react-root"]/section/main/div/header/section/ul/li[3]/a/span

    log many  ${nb_post}  ${nb_follower}  ${nb_following}
    [Return]  ${nb_post}  ${nb_follower}  ${nb_following}

Go back and move next
    go back

Like random 5 photos
    # click first phot and like
    click element  xpath=//*[@id="react-root"]/section/main/div/article/div[1]/div/div[1]/div[1]/a/div/div[2]
    click element  xpath=/html/body/div[3]/div/div[2]/div/article/div[2]/section[1]/a[1]/span
    sleep  3s

    # move next and like
    click link  xpath=/html/body/div[3]/div/div[1]/div/div/a
    pause execution
#    click element  xpath=/html/body/div[3]/div/div[2]/div/article/div[2]/section[1]/a[1]/span
#    sleep  3s
#    pause execution
#
#    # move next and like
#    click link  xpath=/html/body/div[3]/div/div[1]/div/div/a[2]
#    click element  xpath=/html/body/div[3]/div/div[2]/div/article/div[2]/section[1]/a[1]/span
#    sleep  3s
#    pause execution

*** Test Cases ***
Autolike best account with hashtag
    Connect to main page
    Fill username, pass and sign in
    Search particular tag  tree
    Click recently post
    Jump to profile
#    ${nb_post}  ${nb_follower}  ${nb_following} =  Get index of this account
    Like random 5 photos


