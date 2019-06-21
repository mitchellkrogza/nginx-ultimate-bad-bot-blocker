#!/bin/bash
# Generator Script for the Nginx Ultimate Bad Bot Blocker
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

# MIT License

# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# ******************
# Set Some Variables
# ******************

YEAR=$(date +"%Y")
MONTH=$(date +"%m")
MY_GIT_TAG=V3.${YEAR}.${MONTH}.${TRAVIS_BUILD_NUMBER}
BAD_REFERRERS=$(wc -l < ${TRAVIS_BUILD_DIR}/_generator_lists/bad-referrers.list)
BAD_BOTS=$(wc -l < ${TRAVIS_BUILD_DIR}/_generator_lists/bad-user-agents.list)
_now="$(date)"

# *************************************
# Specify input lists for the generator
# *************************************

_input1=${TRAVIS_BUILD_DIR}/_generator_lists/good-user-agents.list
_input2=${TRAVIS_BUILD_DIR}/_generator_lists/allowed-user-agents.list
_input3=${TRAVIS_BUILD_DIR}/_generator_lists/limited-user-agents.list
_input4=${TRAVIS_BUILD_DIR}/_generator_lists/bad-user-agents.list
_input5=${TRAVIS_BUILD_DIR}/.dev-tools/referrers-regex-format.txt
_input6=${TRAVIS_BUILD_DIR}/_generator_lists/google-ip-ranges.list
_input7=${TRAVIS_BUILD_DIR}/_generator_lists/bing-ip-ranges.list
_input8=${TRAVIS_BUILD_DIR}/_generator_lists/wordpress-theme-detectors.list
_input9=${TRAVIS_BUILD_DIR}/_generator_lists/nibbler-seo.list
_input10=${TRAVIS_BUILD_DIR}/_generator_lists/cloudflare-ip-ranges.list
_input11=${TRAVIS_BUILD_DIR}/_generator_lists/bad-ip-addresses.list


# *******************************************************
# Declare temporary database files used during generation
# *******************************************************

_inputdbA=/tmp/version-information.db
_inputdb1=/tmp/good-user-agents.db
_inputdb2=/tmp/allowed-user-agents.db
_inputdb3=/tmp/limited-user-agents.db
_inputdb4=/tmp/bad-user-agents.db
_inputdb5=/tmp/bad-referrers.db
_inputdb6=/tmp/google-ip-ranges.db
_inputdb7=/tmp/bing-ip-ranges.db
_inputdb8=/tmp/wordpress-theme-detectors.db
_inputdb9=/tmp/nibbler-seo.db
_inputdb10=/tmp/cloudflare-ip-ranges.db
_inputdb11=/tmp/bad-ip-addresses.db

# **************************************************
# Declare temporary variables used during generation
# **************************************************

_nginx=${TRAVIS_BUILD_DIR}/.dev-tools/globalblacklist-testing.template
_tmpnginxA=_tmpnginxA
_tmpnginx1=_tmpnginx1
_tmpnginx2=_tmpnginx2
_tmpnginx3=_tmpnginx3
_tmpnginx4=_tmpnginx4
_tmpnginx5=_tmpnginx5
_tmpnginx6=_tmpnginx6
_tmpnginx7=_tmpnginx7
_tmpnginx8=_tmpnginx8
_tmpnginx9=_tmpnginx9
_tmpnginx10=_tmpnginx10
_tmpnginx11=_tmpnginx11

# *************************************************************
# Sort all input lists alphabetically and remove any duplicates
# *************************************************************

sort -u ${_input1} -o ${_input1}
sort -u ${_input2} -o ${_input2}
sort -u ${_input3} -o ${_input3}
sort -u ${_input4} -o ${_input4}
sort -u ${_input5} -o ${_input5}
sort -u ${_input6} -o ${_input6}
sort -u ${_input7} -o ${_input7}
sort -u ${_input8} -o ${_input8}
sort -u ${_input9} -o ${_input9}
sort -u ${_input10} -o ${_input10}

# ***************************************************************
# Start and End Strings to Search for to do inserts into template
# ***************************************************************

_start1="# START GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###"
_end1="# END GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###"
_start2="# START ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###"
_end2="# END ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###"
_start3="# START LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###"
_end3="# END LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###"
_start4="# START BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###"
_end4="# END BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###"
_start5="# START BAD REFERRERS ### DO NOT EDIT THIS LINE AT ALL ###"
_end5="# END BAD REFERRERS ### DO NOT EDIT THIS LINE AT ALL ###"
_start6="# START GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###"
_end6="# END GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###"
_start7="# START BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###"
_end7="# END BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###"
_start8="# START WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###"
_end8="# END WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###"
_start9="# START NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###"
_end9="# END NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###"
_start10="# START CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###"
_end10="# END CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###"
_start11="# START KNOWN BAD IP ADDRESSES ### DO NOT EDIT THIS LINE AT ALL ###"
_end11="# END KNOWN BAD IP ADDRESSES ### DO NOT EDIT THIS LINE AT ALL ###"
_startmarker="### VERSION INFORMATION #"
_endmarker="### VERSION INFORMATION ##"

# **********************************
# SET ALLOW OR DENY ACTION VARIABLES
# **********************************

_action1="0;"
_action2="1;"
_action3="2;"
_action4="3;"


# ************************************
# GOOD USER AGENTS - Create and Insert
# ************************************

printf '%s\n' "${_start1}" >> ${_tmpnginx1}
while IFS= read -r LINE
do
printf '\t"~*%s%s%s"\t\t%s\n' "\b" "${LINE}" "\b" "${_action1}" >> ${_tmpnginx1}
done < ${_input1}
printf '%s\n' "${_end1}"  >> ${_tmpnginx1}
mv ${_tmpnginx1} ${_inputdb1}
ed -s ${_inputdb1}<<\IN
1,/# START GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb1}

# ********************************
# ALLOWED BOTS - Create and Insert
# ********************************

printf '%s\n' "$_start2" >> ${_tmpnginx2}
while IFS= read -r LINE
do
printf '\t"~*%s%s%s"\t\t%s\n' "\b" "${LINE}" "\b" "$_action2" >> ${_tmpnginx2}
done < ${_input2}
printf '%s\n' "$_end2"  >> ${_tmpnginx2}
mv ${_tmpnginx2} ${_inputdb2}
ed -s ${_inputdb2}<<\IN
1,/# START ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb2}

# ********************************
# LIMITED BOTS - Create and Insert
# ********************************

printf '%s\n' "$_start3" >> ${_tmpnginx3}
while IFS= read -r LINE
do
printf '\t"~*%s%s%s"\t\t%s\n' "\b" "${LINE}" "\b" "$_action3" >> ${_tmpnginx3}
done < ${_input3}
printf '%s\n' "$_end3"  >> ${_tmpnginx3}
mv ${_tmpnginx3} ${_inputdb3}
ed -s ${_inputdb3}<<\IN
1,/# START LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb3}

# ******************************************************
# BAD BOTS with and Without Boundary - Create and Insert
# ******************************************************

printf '%s\n' "$_start4" >> ${_tmpnginx4}
while IFS= read -r LINE
do
printf '\t"~*%s%s"\t\t%s\n' "(?:\b|)${LINE}" "(?:|\s|,|\.|\b|\/)" "$_action4" >> ${_tmpnginx4}
#printf '\t"~*%s"\t\t%s\n' "${LINE}" "$_action4" >> ${_tmpnginx4}
done < ${_input4}
printf '%s\n' "$_end4"  >> ${_tmpnginx4}
mv ${_tmpnginx4} ${_inputdb4}
ed -s ${_inputdb4}<<\IN
1,/# START BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb4}


# ********************************
# BAD REFERERS - Create and Insert
# ********************************

printf '%s\n' "$_start5" >> ${_tmpnginx5}
while IFS= read -r LINE
do
printf '\t%s\n' "${LINE}" >> ${_tmpnginx5}
done < ${_input5}
printf '%s\n' "$_end5"  >> ${_tmpnginx5}
mv ${_tmpnginx5} ${_inputdb5}
ed -s ${_inputdb5}<<\IN
1,/# START BAD REFERRERS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END BAD REFERRERS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START BAD REFERRERS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END BAD REFERRERS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb5}

# ************************************
# GOOGLE IP RANGES - Create and Insert
# ************************************

printf '%s\n' "$_start6" >> ${_tmpnginx6}
while IFS= read -r LINE
do
printf '\t%s\t\t%s\n' "${LINE}" "$_action1" >> ${_tmpnginx6}
done < ${_input6}
printf '%s\n' "$_end6"  >> ${_tmpnginx6}
mv ${_tmpnginx6} ${_inputdb6}
ed -s ${_inputdb6}<<\IN
1,/# START GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb6}

# **********************************
# BING IP RANGES - Create and Insert
# **********************************

printf '%s\n' "$_start7" >> ${_tmpnginx7}
while IFS= read -r LINE
do
printf '\t%s\t\t%s\n' "${LINE}" "$_action1" >> ${_tmpnginx7}
done < ${_input7}
printf '%s\n' "$_end7"  >> ${_tmpnginx7}
mv ${_tmpnginx7} ${_inputdb7}
ed -s ${_inputdb7}<<\IN
1,/# START BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb7}

# *********************************************
# Wordpress Theme Detectors - Create and Insert
# *********************************************

printf '%s\n' "$_start8" >> ${_tmpnginx8}
while IFS= read -r LINE
do
printf '%s\n' "${LINE}" >> ${_tmpnginx8}
done < ${_input8}
printf '%s\n' "$_end8"  >> ${_tmpnginx8}
mv ${_tmpnginx8} ${_inputdb8}
ed -s ${_inputdb8}<<\IN
1,/# START WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb8}

# *******************************
# Nibbler SEO - Create and Insert
# *******************************

printf '%s\n' "$_start9" >> ${_tmpnginx9}
while IFS= read -r LINE
do
printf '\t%s\t\t%s\n' "${LINE}" "$_action2" >> ${_tmpnginx9}
done < ${_input9}
printf '%s\n' "$_end9"  >> ${_tmpnginx9}
mv ${_tmpnginx9} ${_inputdb9}
ed -s ${_inputdb9}<<\IN
1,/# START NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb9}

# ****************************************
# CLOUDFLARE IP RANGES - Create and Insert
# ****************************************

printf '%s\n' "$_start10" >> ${_tmpnginx10}
while IFS= read -r LINE
do
printf '\t%s\t\t%s\n' "${LINE}" "$_action1" >> ${_tmpnginx10}
done < ${_input10}
printf '%s\n' "$_end10"  >> ${_tmpnginx10}
mv ${_tmpnginx10} ${_inputdb10}
ed -s ${_inputdb10}<<\IN
1,/# START CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb10}

# ****************************************
# KNOWN BAD IP RANGES - Create and Insert
# ****************************************

printf '%s\n' "$_start11" >> ${_tmpnginx11}
while IFS= read -r LINE
do
printf '\t%s\t\t%s\n' "${LINE}" "$_action2" >> ${_tmpnginx11}
done < ${_input11}
printf '%s\n' "$_end11"  >> ${_tmpnginx11}
mv ${_tmpnginx11} ${_inputdb11}
ed -s ${_inputdb11}<<\IN
1,/# START KNOWN BAD IP ADDRESSES ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END KNOWN BAD IP ADDRESSES ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/# START KNOWN BAD IP ADDRESSES ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END KNOWN BAD IP ADDRESSES ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdb11}

# *******************************************************************************
# PRINT VERSION, SCRIPT RUNTIME and UPDATE INFORMATION INTO GLOBALBLACKLIST FILES
# *******************************************************************************

printf '%s\n%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s\n%s\n' "$_startmarker" "###################################################" "### Version: " "$MY_GIT_TAG" "### Updated: " "$_now" "### Bad Referrer Count: " "$BAD_REFERRERS" "### Bad Bot Count: " "$BAD_BOTS" "###################################################" "$_endmarker" >> ${_tmpnginxA}
mv ${_tmpnginxA} ${_inputdbA}
ed -s ${_inputdbA}<<\IN
1,/### VERSION INFORMATION #/d
/### VERSION INFORMATION ##/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
/### VERSION INFORMATION #/x
.t.
.,/### VERSION INFORMATION ##/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/.dev-tools/globalblacklist-testing.template
q
IN
rm ${_inputdbA}

# **************************************************
# Generate Additional Files and Copy Them to Folders
# **************************************************

sudo cp ${_nginx} ${TRAVIS_BUILD_DIR}/conf.d/globalblacklist-testing-version.conf

# **********************
# Exit With Error Number
# **********************

exit ${?}


# MIT License

# Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
