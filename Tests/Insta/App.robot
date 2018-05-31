*** Settings ***
Library  Selenium2Library
Library  Collections
Resource  ./Func.robot
Test Setup      Begin Web Test
Test Teardown   End Web Test

# pybot -d C:/results/insta tests/insta/app.robot

*** Variables ***
${URL}              https://www.instagram.com/?hl=vi
${BROWSER}          chrome
${USERNAME}         01268199265
${PASSWORD}         Pq260592
${TAGS}             https://www.instagram.com/explore/tags/tree/
${PERIOD}

*** Test Cases ***
SignIn
    Func.Access web Instagram    ${URL}
    Func.Go to page Login        ${USERNAME}     ${PASSWORD}
    Func.Main Page
    Func.Search HashTag
    Func.Choose photo which user have just posted

    :FOR  ${times}  IN RANGE  5
    \   Func.Link User Profile
    \   Get index of this account
    \   pause execution
    \   Func.Open the most recent photo of User
    \   Func.Like photo
    \   Func.Press button arrow right
    \   Func.Like photo
    \   Func.Press button arrow right
    \   Func.Like photo
    \   Func.Quit current user profile TO prepare moving on next user
    \   Func.Press button arrow right
    \   pause execution

#    :FOR  ${times}  IN RANGE  5
#    \   Func.Search HashTag
#    \   Func.Choose User
#    \   Func.Link User Profile
#    \   Func.Like three photos
##    \   Func.Quit current user profile TO prepare moving on next user
##    \   Func.Press button arrow right
#    \   sleep  60s
