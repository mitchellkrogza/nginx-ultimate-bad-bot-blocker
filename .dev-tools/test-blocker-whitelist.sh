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

# ------------------------------------------------------------------------------
# MIT License
# ------------------------------------------------------------------------------
# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza
# ------------------------------------------------------------------------------
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# ------------------------------------------------------------------------------
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# ------------------------------------------------------------------------------
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------

# ------------------------
# Set Terminal Font Colors
# ------------------------

bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
defaultcolor=$(tput setaf default)

# ---------
# FUNCTIONS
# ---------

reloadNginX () {
printf "\n"
echo "${bold}${green}---------------"
echo "${bold}${green}Reloading Nginx"
echo "${bold}${green}---------------"
sudo nginx -t && sudo nginx -s reload
}

waitforReload () {
echo "${bold}${yellow}-----------------------------------------------------------------------"
echo "${bold}${yellow}Sleeping for 10 seconds to allow Nginx to Properly Reload inside Travis"
echo "${bold}${yellow}-----------------------------------------------------------------------"
printf "\n"
sleep 10s
}

run_curltest1 () {
if curl -v -A "Nutch" http://localhost:9000 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - WHITELISTING OF BAD BOT Nutch ALLOWED"
else
   echo "${bold}${red}FAILED - WHITELISTING of BAD BOT Nutch FAILED"
   #exit 1
   curl -v -A "Nutch" http://localhost:9000 2>&1
fi
}

run_curltest2 () {
if curl http://localhost:9000 -e http://zx6.ru 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - WHITELISTING OF REFERRER zx6.ru ALLOWED"
else
   echo "${bold}${red}FAILED - WHITELISTING OF REFERRER zx6.ru FAILED"
   #exit 1
   curl http://localhost:9000 -e http://zx6.ru 2>&1
fi
}

generateCustomBlacklists () {
echo "${bold}${magenta}-----------------------------------------------------------------"
echo "${bold}${magenta}Generating blacklist-user-agents.conf & custom-bad-referrers.conf"
echo "${bold}${magenta}-----------------------------------------------------------------"
printf "\n"
# --------------------------------------------------------------------------
# Generate our custom test units turning all good to bad and all bad to good
# --------------------------------------------------------------------------
_input1=${TRAVIS_BUILD_DIR}/_generator_lists/bad-user-agents.list
_input2=${TRAVIS_BUILD_DIR}/.dev-tools/referrers-regex-format-whitelist-test.txt
_inputdb1=${TRAVIS_BUILD_DIR}/.dev-tools/good-bad-user-agents.db
_inputdb2=${TRAVIS_BUILD_DIR}/.dev-tools/good-bad-referrers.db
_tmpnginx1=_tmpnginx1
_tmpnginx2=_tmpnginx2
_start1="# START MAKE BAD BOTS GOOD ### DO NOT EDIT THIS LINE AT ALL ###"
_end1="# END MAKE BAD BOTS GOOD ### DO NOT EDIT THIS LINE AT ALL ###"
_start2="# START MAKE BAD REFERRERS GOOD ### DO NOT EDIT THIS LINE AT ALL ###"
_end2="# END MAKE BAD REFERRERS GOOD ### DO NOT EDIT THIS LINE AT ALL ###"
_action1="0;"

# ----------------------------
# BAD BOTS - Create and Insert
# ----------------------------

echo "${bold}${yellow}------------------------"
echo "${bold}${green}Making all ${red}Bad Bots ${green}GOOD"
echo "${bold}${yellow}------------------------"
printf "\n"

printf '%s\n' "$_start1" >> ${_tmpnginx1}
while IFS= read -r LINE
do
printf '\t"~*%s%s"\t\t%s\n' "(?:\b)${LINE}" "(?:\b|)" "$_action1" >> ${_tmpnginx1}
done < ${_input1}
printf '%s\n' "$_end1"  >> ${_tmpnginx1}
mv ${_tmpnginx1} ${_inputdb1}
ed -s ${_inputdb1}<<\IN
1,/# START MAKE BAD BOTS GOOD ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END MAKE BAD BOTS GOOD ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/test_units/blacklist-user-agents.conf
/# START MAKE BAD BOTS GOOD ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END MAKE BAD BOTS GOOD ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/test_units/blacklist-user-agents.conf
q
IN
rm ${_inputdb1}

# --------------------------------
# BAD REFERERS - Create and Insert
# --------------------------------

echo "${bold}${yellow}-----------------------------"
echo "${bold}${green}Making all ${red}Bad Referrers ${green}GOOD"
echo "${bold}${yellow}-----------------------------"
printf "\n"


printf '%s\n' "$_start2" >> ${_tmpnginx2}
while IFS= read -r LINE
do
printf '\t%s\n' "${LINE}" >> ${_tmpnginx2}
done < ${_input2}
printf '%s\n' "$_end2"  >> ${_tmpnginx2}
mv ${_tmpnginx2} ${_inputdb2}
ed -s ${_inputdb2}<<\IN
1,/# START MAKE BAD REFERRERS GOOD ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END MAKE BAD REFERRERS GOOD ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/test_units/custom-bad-referrers.conf
/# START MAKE BAD REFERRERS GOOD ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END MAKE BAD REFERRERS GOOD ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/test_units/custom-bad-referrers.conf
q
IN
rm ${_inputdb2}
}

activateCustomBlacklists () {
echo "${bold}${green}------------------------------------------------"
echo "${bold}${green}Activating Users User-Agents Whitelist/Blacklist"
echo "${bold}${green}------------------------------------------------"
printf "\n"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/blacklist-user-agents.conf /etc/nginx/bots.d/blacklist-user-agents.conf
echo "${bold}${green}----------------------------------------------"
echo "${bold}${green}Activating Users Referrers Whitelist/Blacklist"
echo "${bold}${green}----------------------------------------------"
printf "\n"
sudo cp ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/custom-bad-referrers.conf /etc/nginx/bots.d/custom-bad-referrers.conf
}

testBadUserAgents () {
shuf -n 100 ${TRAVIS_BUILD_DIR}/_generator_lists/bad-user-agents.list > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-whitelist-test.tmp
sed 's/\\//g' ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-whitelist-test.tmp > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-whitelist-test.list
sudo rm ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-whitelist-test.tmp
sort -u ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-whitelist-test.list -o ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-whitelist-test.list
printf "\n"
echo "${bold}${magenta}---------------------------"
echo "${bold}${magenta}Testing 100 Random Bad Bots"
echo "${bold}${magenta}---------------------------"
IFS=$'\n'
file=${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-bots-for-whitelist-test.list
lines=$(cat ${file})
for line in ${lines}; do
   if
   curl -v -A "${line}" http://localhost:9000 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - ${red}${line} was ${bold}${green}ALLOWED"
   else
   echo "${bold}${red}FAILED - ${red}${line} was ${bold}${red}NOT ALLOWED"
   fi
done
IFS=""
}

testBadReferrers () {
shuf -n 100 ${TRAVIS_BUILD_DIR}/_generator_lists/bad-referrers.list > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-whitelist-test.tmp
sed 's/\\//g' ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-whitelist-test.tmp > ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-whitelist-test.list
sudo rm ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-whitelist-test.tmp
sort -u ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-whitelist-test.list -o ${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-whitelist-test.list
printf "\n"
echo "${bold}${magenta}----------------------------"
echo "${bold}${magenta}Testing 100 Random Referrers"
echo "${bold}${magenta}----------------------------"
IFS=$'\n'
file=${TRAVIS_BUILD_DIR}/.dev-tools/test_units/random-referrers-for-whitelist-test.list
lines=$(cat ${file})
for line in ${lines}; do
   if
   curl http://localhost:9000 -e "http://${line}" 2>&1 | grep -i 'Welcome'; then
   echo "${bold}${green}PASSED - ${red}${line} was ${bold}${green}ALLOWED"
   else
   echo "${bold}${red}FAILED - ${red}${line} was ${bold}${red}NOT ALLOWED"
   fi
done
IFS=""
}

backupConfFiles () {
printf "\n"
echo "${bold}${green}------------------------------------------------------------"
echo "${bold}${green}Make Backup all conf files and folders used during this test"
echo "${bold}${green}------------------------------------------------------------"
printf "\n"
sudo cp /etc/nginx/bots.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_whitelist/bots.d/
sudo cp /etc/nginx/conf.d/* ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_whitelist/conf.d/
sudo cp /etc/nginx/sites-available/default.vhost ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_whitelist/default.vhost
sudo cp /etc/nginx/nginx.conf ${TRAVIS_BUILD_DIR}/.dev-tools/_conf_files_whitelist/nginx.conf
}

# -----------
# Start Tests
# -----------

echo "${bold}${green}--------------------------"
echo "${bold}${green}Whitelisting Test Starting"
echo "${bold}${green}--------------------------"
printf "\n"

generateCustomBlacklists
activateCustomBlacklists
reloadNginX
waitforReload
run_curltest1
run_curltest2
testBadUserAgents
testBadReferrers
backupConfFiles

echo "${bold}${green}--------------------------"
echo "${bold}${green}Whitelisting Test Complete"
echo "${bold}${green}--------------------------"
printf "\n"

# ----------------------
# Exit With Error Number
# ----------------------

exit ${?}

# ------------------------------------------------------------------------------
# MIT License
# ------------------------------------------------------------------------------
# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza
# ------------------------------------------------------------------------------
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# ------------------------------------------------------------------------------
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# ------------------------------------------------------------------------------
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------

