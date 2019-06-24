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

echo "Disable any User Whitelisting and set to Default"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/blacklist-user-agents-none.conf /etc/nginx/bots.d/blacklist-user-agents.conf
echo "Reloading Nginx"
sudo nginx -t && sudo nginx -s reload

echo "Sleeping for 30 seconds to allow Nginx Properly Reload inside Travis"
sleep 30s

# *************************************************
# Function Curl Test 1 - Check for Bad Bot "80legs"
# *************************************************

run_curltest1 () {
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
if curl -v -A "80legs" http://localhost:9000/index.html 2>&1 | grep -i '(52)'; then
   echo "$(tput setaf 1)BAD BOT DETECTED - $(tput setaf 2)TEST PASSED"
else
   echo "$(tput setaf 1)BAD BOT NOT DETECTED - TEST FAILED"
   exit 1
fi
}
run_curltest1


# **************************************************
# Function Curl Test 2 - Check for Bad Bot "Nutch"
# **************************************************

run_curltest2 () {
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
if curl -v -A "Nutch" http://localhost:9000/index.html 2>&1 | grep -i '(52)'; then
   echo "$(tput setaf 1)BAD BOT DETECTED - $(tput setaf 2)TEST PASSED"
else
   echo "$(tput setaf 1)BAD BOT NOT DETECTED - TEST FAILED"
   exit 1
fi
}
run_curltest2


# ******************************************************************
# Function Curl Test 3 - Check for Bad Referrer "100dollars-seo.com"
# ******************************************************************

run_curltest3 () {
printf '\n%s\n%s\n%s\n\n' "##############################" "TESTING BAD REFERRER IS DENIED" "##############################"
if curl -I http://localhost:9000/index.html -e http://100dollars-seo.com 2>&1 | grep -i '(52)'; then
   echo "$(tput setaf 1)BAD REFERRER DETECTED - $(tput setaf 2)TEST PASSED"
else
   echo "$(tput setaf 1)BAD REFERRER NOT DETECTED - TEST FAILED"
   exit 1
fi
}
run_curltest3


# ******************************************************
# Function Curl Test 4 - Check for Bad Referrer "zx6.ru"
# ******************************************************

run_curltest4 () {
printf '\n%s\n%s\n%s\n\n' "##############################" "TESTING BAD REFERRER IS DENIED" "##############################"
if curl -I http://localhost:9000/index.html -e http://zx6.ru 2>&1 | grep -i '(52)'; then
   echo "$(tput setaf 1)BAD REFERRER DETECTED - $(tput setaf 2)TEST PASSED"
else
   echo "$(tput setaf 1)BAD REFERRER NOT DETECTED - TEST FAILED"
   exit 1
fi
}
run_curltest4

# *****************************************************
# Function Curl Test 5 - Check for Good Bot "GoogleBot"
# *****************************************************

run_curltest5 () {
printf '\n%s\n%s\n%s\n\n' "###########################" "TESTING GOOD BOT IS ALLOWED" "###########################"
if curl -v -A "GoogleBot" http://localhost:9000/index.html 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)GOOD BOT ALLOWED THROUGH - TEST PASSED"
else
   echo "$(tput setaf 1)GOOD BOT NOT ALLOWED THROUGH - TEST FAILED"
   exit 1
fi
}
run_curltest5

# ***************************************************
# Function Curl Test 6 - Check for Good Bot "BingBot"
# ***************************************************

run_curltest6 () {
printf '\n%s\n%s\n%s\n\n' "###########################" "TESTING GOOD BOT IS ALLOWED" "###########################"
if curl -v -A "BingBot" http://localhost:9000/index.html 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)GOOD BOT ALLOWED THROUGH - TEST PASSED"
else
   echo "$(tput setaf 1)GOOD BOT NOT ALLOWED THROUGH - TEST FAILED"
   exit 1
fi
}
run_curltest6

# ***********************************************************
# Function Curl Test 7 - Check for Good Referrer "google.com"
# ***********************************************************

run_curltest7 () {
printf '\n%s\n%s\n%s\n\n' "################################" "TESTING GOOD REFERRER IS ALLOWED" "################################"
if curl http://localhost:9000/index.html -e http://google.com 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)GOOD REFERRER DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)GOOD REFERRER NOT DETECTED - TEST FAILED"
   exit 1
fi
}
run_curltest7

# ***********************************************************
# Function Curl Test 8 - Check for Good Referrer "bing.com"
# ***********************************************************

run_curltest8 () {
printf '\n%s\n%s\n%s\n\n' "################################" "TESTING GOOD REFERRER IS ALLOWED" "################################"
if curl http://localhost:9000/index.html -e http://bing.com 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)GOOD REFERRER DETECTED - TEST PASSED"
else
   echo "$(tput setaf 1)GOOD REFERRER NOT DETECTED - TEST FAILED"
   exit 1
fi
}
run_curltest8

# **************************************************
# Function Curl Test 9 - Check for Bad Bot "Nutch"
# **************************************************

run_curltest9 () {
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
if curl -A "Googlebot/Nutch-1.7" http://localhost:9000/index.html 2>&1 | grep -i '(52)'; then
   echo "$(tput setaf 1)BAD BOT DETECTED - $(tput setaf 2)TEST PASSED"
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
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
if curl -A "Mozilla/5.0 (compatible; Googlebot/Nutch2.1; +http://www.google.com/bot.html)" http://localhost:9000/index.html 2>&1 | grep -i '(52)'; then
   echo "$(tput setaf 1)BAD BOT DETECTED - $(tput setaf 2)TEST PASSED"
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
printf '\n%s\n%s\n%s\n\n' "#########################" "TESTING BAD BOT IS DENIED" "#########################"
if curl -A "Mozilla/5.0 (compatible; Googlebot/nutch/-2.1; +http://www.google.com/bot.html)" http://localhost:9000/index.html 2>&1 | grep -i '(52)'; then
   echo "$(tput setaf 1)BAD BOT DETECTED - $(tput setaf 2)TEST PASSED"
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
printf '\n%s\n%s\n%s\n\n' "############################" "TESTING FALSE POSITIVE CASES" "############################"
if curl -v -A "Mozilla/5.0 (compatible; Googlebot-Image/Snutch\-/-2.1; +http://www.google.com/bot.html)" http://localhost:9000/index.html 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)NO FALSE POSITIVE - TEST PASSED"
else
   echo "$(tput setaf 1)FALSE POSITIVE - TEST FAILED"
   #exit 1
fi
}
run_curltest12

# **************************************************
# Function Curl Test 13 - Check for Bad Bot "Nutch"
# **************************************************

run_curltest13 () {
printf '\n%s\n%s\n%s\n\n' "############################" "TESTING FALSE POSITIVE CASES" "############################"
if curl -v -A "SnutchMozilla/5.0 (compatible; Googlebot-Image/SMutch\-/-2.1; +http://www.google.com/bot.html)" http://localhost:9000/index.html 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)NO FALSE POSITIVE - TEST PASSED"
else
   echo "$(tput setaf 1)FALSE POSITIVE - TEST FAILED"
   #exit 1
fi
}
run_curltest13

# **************************************************
# Function Curl Test 14 - Check for Good Bot
# **************************************************

run_curltest14 () {
printf '\n%s\n%s\n%s\n\n' "############################" "TESTING FALSE POSITIVE CASES" "############################"
if curl -v -A "Mozilla/5.0 (X11; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0" http://localhost:9000/index.html 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)NO FALSE POSITIVE - TEST PASSED"
else
   echo "$(tput setaf 1)FALSE POSITIVE - TEST FAILED"
   #exit 1
fi
}
run_curltest14


# **************************************************
# Function Curl Test 15 - TEST CASES
# **************************************************

run_curltest15 () {
printf '\n%s\n%s\n%s\n\n' "############################" "TESTING FALSE POSITIVE CASES" "############################"
if curl -v -A "Mozilla/5.0 (X11; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0" http://localhost:9000/index.html 2>&1 | grep -i 'Welcome'; then
   echo "$(tput setaf 2)NO FALSE POSITIVE - TEST PASSED"
else
   echo "$(tput setaf 1)FALSE POSITIVE - TEST FAILED"
   #exit 1
fi
}
run_curltest15

bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
# ************************************************
# Test 50 Random User-Agents from Bad-User-Agents
# ************************************************
shuf -n 50 ${TRAVIS_BUILD_DIR}/_generator_lists/bad-user-agents.list > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-test-quick.tmp
sed 's/\\//g' ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-test-quick.tmp > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-test-quick.list
sudo rm ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-test-quick.tmp
sort -u ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-test-quick.list -o ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-test-quick.list

echo "Testing 250 Random Bad Bots"
IFS=$'\n'
file=${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-test-quick.list
lines=$(cat ${file})
for line in ${lines}; do
   if
   curl -v -A "${line}" http://localhost:9000 2>&1 | grep -i '(52)'; then
   echo "${bold}${green}PASSED - ${red}${line} was ${bold}${red}BLOCKED"
   else
   echo "${bold}${red}FAILED - ${red}${line} was ${bold}${red}NOT BLOCKED"
   fi
done
IFS=""

# ************************************************
# Test All Good User-Agents from Good-User-Agents
# ************************************************
sed 's/\\//g' ${TRAVIS_BUILD_DIR}/_generator_lists/good-user-agents.list > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/good-bots-for-test.list

echo "Testing All Good Bots"
IFS=$'\n'
file=${TRAVIS_BUILD_DIR}/.dev-tools/test_units/good-bots-for-test.list
lines=$(cat ${file})
for line in ${lines}; do
   if
   curl -v -A "${line}" http://localhost:9000 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - ${green}${line} was ${bold}${green}ALLOWED"
   else
   echo "${bold}${red}FAILED - ${red}${line} was ${bold}${red}BLOCKED"
   fi
done
IFS=""


# *****************************************************
# Test All Allowed User-Agents from Allowed-User-Agents
# *****************************************************
sed 's/\\//g' ${TRAVIS_BUILD_DIR}/_generator_lists/allowed-user-agents.list > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/allowed-bots-for-test.list

echo "Testing All Allowed Bots"
IFS=$'\n'
file=${TRAVIS_BUILD_DIR}/.dev-tools/test_units/allowed-bots-for-test.list
lines=$(cat ${file})
for line in ${lines}; do
   if
   curl -v -A "${line}" http://localhost:9000 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - ${green}${line} was ${bold}${green}ALLOWED"
   else
   echo "${bold}${red}FAILED - ${red}${line} was ${bold}${red}BLOCKED"
   fi
done
IFS=""

# *****************************************************
# Test All Limited User-Agents from Limited-User-Agents
# *****************************************************
sed 's/\\//g' ${TRAVIS_BUILD_DIR}/_generator_lists/limited-user-agents.list > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/limited-bots-for-test.list

echo "Testing All Limited Bots"
IFS=$'\n'
file=${TRAVIS_BUILD_DIR}/.dev-tools/test_units/limited-bots-for-test.list
lines=$(cat ${file})
for line in ${lines}; do
   if
   curl -v -A "${line}" http://localhost:9000 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - ${green}${line} was ${bold}${green}ALLOWED"
   else
   echo "${bold}${green}FAILED - ${red}${line} was ${bold}${red}BLOCKED"
   fi
done
IFS=""

# ********************************************
# Test 100 Random Referrers from Bad-Referrers
# ********************************************
shuf -n 100 ${TRAVIS_BUILD_DIR}/_generator_lists/bad-referrers.list > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-test-quick.list
sort -u ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-test-quick.list -o ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-test-quick.list

echo "Testing 100 Random Bad Referrers"
IFS=$'\n'
file=${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-test-quick.list
lines=$(cat ${file})
for line in ${lines}; do
   if
   curl -I http://localhost:9000 -e "http://${line}" 2>&1 | grep -i '(52)'; then
   echo "${bold}${green}PASSED - ${red}${line} was ${bold}${red}BLOCKED"
   else
   echo "${bold}${red}FAILED - ${red}${line} was ${bold}${red}NOT BLOCKED"
   fi
done
IFS=""

# **************************
# Test Good Referrer Domains
# **************************

echo "Testing Good Referrers"
IFS=$'\n'
file=${TRAVIS_BUILD_DIR}/.dev-tools/test_units/good-referrers-for-test.list
lines=$(cat ${file})
for line in ${lines}; do
   if
   curl -v -A "${line}" http://localhost:9000 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - ${green}${line} was ${bold}${green}ALLOWED"
   else
   echo "${bold}${green}FAILED - ${red}${line} was ${bold}${red}BLOCKED"
   fi
done
IFS=""


echo "Tests Completed"

# **********************
# Exit With Error Number
# **********************

exit ${?}


