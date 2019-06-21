#!/bin/bash
# Curl Testing Script for Nginx Ultimate Bad Bot Blocker
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

##############################################################################                                                                
#       _  __     _                                                          #
#      / |/ /__ _(_)__ __ __                                                 #
#     /    / _ `/ / _ \\ \ /                                                 #
#    /_/|_/\_, /_/_//_/_\_\                                                  #
#       __/___/      __   ___       __     ___  __         __                #
#      / _ )___ ____/ /  / _ )___  / /_   / _ )/ /__  ____/ /_____ ____      #
#     / _  / _ `/ _  /  / _  / _ \/ __/  / _  / / _ \/ __/  '_/ -_) __/      #
#    /____/\_,_/\_,_/  /____/\___/\__/  /____/_/\___/\__/_/\_\\__/_/         #
#                                                                            #
##############################################################################                                                                

# *******************************************
# Set Location of our Curl Test Results Files
# *******************************************

echo "Tests Starting"

_curltest1=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest1.txt
_curltest2=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest2.txt
_curltest3=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest3.txt
_curltest4=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest4.txt
_curltest5=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest5.txt
_curltest6=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest6.txt
_curltest7=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest7.txt
_curltest8=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest8.txt
_curltest9=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest9.txt
_curltest10=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest10.txt
_curltest11=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest11.txt
_curltest12=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest12.txt
_curltest13=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest13.txt
_curltest14=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest14.txt
_curltest15=${TRAVIS_BUILD_DIR}/.dev-tools/_curl_tests_changetesting/curltest15.txt
_now="$(date)"


# *************************************************
# Function Curl Test 1 - Check for Bad Bot "80legs"
# *************************************************

run_curltest1 () {
truncate -s 0 ${_curltest1}
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest1}"
curl -A "80legs" http://localhost:9000/index.php 2>> ${_curltest1}
if grep -i '(52)' ${_curltest1}; then
   echo "$(tput setaf 2)BAD BOT DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)BAD BOT NOT DETECTED - TEST FAILED"
fi
}
run_curltest1


# **************************************************
# Function Curl Test 2 - Check for Bad Bot "Nutch"
# **************************************************

run_curltest2 () {
truncate -s 0 ${_curltest2}
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest2}"
curl -A "Nutch" http://localhost:9000/index.php 2>> ${_curltest2}
if grep -i '(52)' ${_curltest2}; then
   echo "$(tput setaf 2)BAD BOT DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)BAD BOT NOT DETECTED - TEST FAILED"
   #exit 1
fi
}
run_curltest2


# ******************************************************************
# Function Curl Test 3 - Check for Bad Referrer "100dollars-seo.com"
# ******************************************************************

run_curltest3 () {
truncate -s 0 ${_curltest3}
printf '\n%s\n%s\n%s\n\n' "##############################" "TESTING BAD REFERRER IS DENIED" "##############################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest3}"
curl -I http://localhost:9000/index.php -e http://100dollars-seo.com 2>> ${_curltest3}
if grep -i '(52)' ${_curltest3}; then
   echo "$(tput setaf 2)BAD REFERRER DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)BAD REFERRER NOT DETECTED - TEST FAILED"
   #exit 1
fi
}
run_curltest3


# ******************************************************
# Function Curl Test 4 - Check for Bad Referrer "zx6.ru"
# ******************************************************

run_curltest4 () {
truncate -s 0 ${_curltest4}
printf '\n%s\n%s\n%s\n\n' "##############################" "TESTING BAD REFERRER IS DENIED" "##############################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest4}"
curl -I http://localhost:9000/index.php -e http://zx6.ru 2>> ${_curltest4}
if grep -i '(52)' ${_curltest4}; then
   echo "$(tput setaf 2)BAD REFERRER DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)BAD REFERRER NOT DETECTED - TEST FAILED"
   #exit 1
fi
}
run_curltest4

# *****************************************************
# Function Curl Test 5 - Check for Good Bot "GoogleBot"
# *****************************************************

run_curltest5 () {
truncate -s 0 ${_curltest5}
printf '\n%s\n%s\n%s\n\n' "###########################" "TESTING GOOD BOT IS ALLOWED" "###########################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest5}"
curl -v -A "GoogleBot" http://localhost:9000/index.php 2>&1 >> ${_curltest5}
if grep -i 'Welcome' ${_curltest5}; then
   echo "$(tput setaf 2)GOOD BOT ALLOWED THROUGH - TEST PASSED"
else
   echo "$(tput setaf 1)GOOD BOT NOT ALLOWED THROUGH - TEST FAILED"
   #exit 1
fi
}
run_curltest5

# ***************************************************
# Function Curl Test 6 - Check for Good Bot "BingBot"
# ***************************************************

run_curltest6 () {
truncate -s 0 ${_curltest6}
printf '\n%s\n%s\n%s\n\n' "###########################" "TESTING GOOD BOT IS ALLOWED" "###########################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest6}"
curl -v -A "BingBot" http://localhost:9000/index.php 2>&1 >> ${_curltest6}
if grep -i 'Welcome' ${_curltest6}; then
   echo "$(tput setaf 2)GOOD BOT ALLOWED THROUGH - TEST PASSED"
else
   echo "$(tput setaf 1)GOOD BOT NOT ALLOWED THROUGH - TEST FAILED"
   #exit 1
fi
}
run_curltest6

# ***********************************************************
# Function Curl Test 7 - Check for Good Referrer "google.com"
# ***********************************************************

run_curltest7 () {
truncate -s 0 ${_curltest7}
printf '\n%s\n%s\n%s\n\n' "################################" "TESTING GOOD REFERRER IS ALLOWED" "################################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest7}"
curl http://localhost:9000/index.php -e http://google.com 2>&1 >> ${_curltest7}
if grep -i 'Welcome' ${_curltest7}; then
   echo "$(tput setaf 2)GOOD REFERRER DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)GOOD REFERRER NOT DETECTED - TEST FAILED"
   #exit 1
fi
}
run_curltest7

# ***********************************************************
# Function Curl Test 8 - Check for Good Referrer "bing.com"
# ***********************************************************

run_curltest8 () {
truncate -s 0 ${_curltest8}
printf '\n%s\n%s\n%s\n\n' "################################" "TESTING GOOD REFERRER IS ALLOWED" "################################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest8}"
curl http://localhost:9000/index.php -e http://bing.com 2>&1 >> ${_curltest8}
if grep -i 'Welcome' ${_curltest8}; then
   echo "$(tput setaf 2)GOOD REFERRER DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)GOOD REFERRER NOT DETECTED - TEST FAILED"
   #exit 1
fi
}
run_curltest8

# **************************************************
# Function Curl Test 9 - Check for Bad Bot "Nutch"
# **************************************************

run_curltest9 () {
truncate -s 0 ${_curltest9}
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest9}"
curl -A "Googlebot/Nutch-1.7" http://localhost:9000/index.php 2>> ${_curltest9}
if grep -i '(52)' ${_curltest9}; then
   echo "$(tput setaf 2)BAD BOT DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)BAD BOT NOT DETECTED - TEST FAILED"
   #exit 1
fi
}
run_curltest9

# **************************************************
# Function Curl Test 10 - Check for Bad Bot "Nutch"
# **************************************************

run_curltest10 () {
truncate -s 0 ${_curltest10}
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest10}"
curl -A "Mozilla/5.0 (compatible; Googlebot/Nutch2.1; +http://www.google.com/bot.html)" http://localhost:9000/index.php 2>> ${_curltest10}
if grep -i '(52)' ${_curltest10}; then
   echo "$(tput setaf 2)BAD BOT DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)BAD BOT NOT DETECTED - TEST FAILED"
   #exit 1
fi
}
run_curltest10

# **************************************************
# Function Curl Test 11 - Check for Bad Bot "Nutch"
# **************************************************

run_curltest11 () {
truncate -s 0 ${_curltest11}
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest11}"
curl -A "Mozilla/5.0 (compatible; Googlebot/nutch/-2.1; +http://www.google.com/bot.html)" http://localhost:9000/index.php 2>> ${_curltest11}
if grep -i '(52)' ${_curltest11}; then
   echo "$(tput setaf 2)BAD BOT DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)BAD BOT NOT DETECTED - TEST FAILED"
   #exit 1
fi
}
run_curltest11

# **************************************************
# Function Curl Test 12 - Check for Bad Bot "Nutch"
# **************************************************

run_curltest12 () {
truncate -s 0 ${_curltest12}
printf '\n%s\n%s\n%s\n\n' "############################" "TESTING FALSE POSITIVE CASES" "############################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest12}"
curl -A "Mozilla/5.0 (compatible; Googlebot-Image/Snutch\-/-2.1; +http://www.google.com/bot.html)" http://localhost:9000/index.php 2>> ${_curltest12}
if grep -i 'Welcome' ${_curltest12}; then
   echo "$(tput setaf 2)NO FALSE POSITIVE - TEST PASSED"
else
   echo "$(tput setaf 1)FALSE POSITIVE - TEST FAILED"
fi
}
run_curltest12

# **************************************************
# Function Curl Test 13 - Check for Bad Bot "Nutch"
# **************************************************

run_curltest13 () {
truncate -s 0 ${_curltest13}
printf '\n%s\n%s\n%s\n\n' "############################" "TESTING FALSE POSITIVE CASES" "############################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest13}"
curl -A "SnutchMozilla/5.0 (compatible; Googlebot-Image/SMutch\-/-2.1; +http://www.google.com/bot.html)" http://localhost:9000/index.php 2>> ${_curltest13}
if grep -i 'Welcome' ${_curltest13}; then
   echo "$(tput setaf 2)NO FALSE POSITIVE - TEST PASSED"
else
   echo "$(tput setaf 1)FALSE POSITIVE - TEST FAILED"
fi
}
run_curltest13

# **************************************************
# Function Curl Test 14 - Check for Good Bot
# **************************************************

run_curltest14 () {
truncate -s 0 ${_curltest14}
printf '\n%s\n%s\n%s\n\n' "############################" "TESTING FALSE POSITIVE CASES" "############################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest14}"
curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0" http://localhost:9000/index.php 2>> ${_curltest14}
if grep -i 'Welcome' ${_curltest14}; then
   echo "$(tput setaf 2)NO FALSE POSITIVE - TEST PASSED"
else
   echo "$(tput setaf 1)FALSE POSITIVE - TEST FAILED"
fi
}
run_curltest14


# **************************************************
# Function Curl Test 15 - TEST CASES
# **************************************************

run_curltest15 () {
truncate -s 0 ${_curltest15}
printf '\n%s\n%s\n%s\n\n' "############################" "TESTING FALSE POSITIVE CASES" "############################"
printf '%s%s\n\n' "Last Tested: " "$_now" >> "${_curltest15}"
curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0" http://localhost:9000/index.php 2>> ${_curltest15}
if grep -i 'Welcome' ${_curltest15}; then
   echo "$(tput setaf 2)NO FALSE POSITIVE - TEST PASSED"
else
   echo "$(tput setaf 1)FALSE POSITIVE - TEST FAILED"
fi
}
run_curltest15


echo "Tests Completed"

# **********************
# Exit With Error Number
# **********************

exit ${?}


