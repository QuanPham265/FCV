*** Settings ***
Library  Selenium2Library
Library  DatabaseLibrary
Library  String
Library  OperatingSystem
Library  Collections

*** Variables ***
${Lession_URL} =  http://www.esl-lab.com/santa/santard1.htm
${Duration} =  120s

# pybot -d C:/results tests/trial/Auto_Replay.robot

*** Keywords ***

*** Test Cases ***
Auto replay
    open browser  ${Lession_URL}  googlechrome
    wait until page contains  Listening Exercises
    click element  xpath=//*[@id="container"]
    sleep  50s
    click element  xpath=//*[@id="container_jwplayer_controlbar_playButton"]
