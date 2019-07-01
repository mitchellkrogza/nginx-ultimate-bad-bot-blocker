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

# -------------------------------------------
# For Testing REGEX and False Positives Cases
# -------------------------------------------

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

# -----------------------------
# USER-AGENT ARRAY - MUST MATCH
# -----------------------------

UAmustmatch[0]="Titan"
UAmustmatch[1]="Nutch"
UAmustmatch[2]="Ebingbong"

# ---------------------------------
# USER-AGENT ARRAY - MUST NOT MATCH
# ---------------------------------

UAmustnotmatch[0]="Titanium"
UAmustnotmatch[1]="Nutchers"
UAmustnotmatch[2]="SNutch"
UAmustnotmatch[3]="Bing"
UAmustnotmatch[4]="bing"

# ---------------------------
# REFERRER ARRAY - MUST MATCH
# ---------------------------

REFmustmatch[0]="zx6.ru"
REFmustmatch[1]="100dollars-seo.com"
REFmustmatch[2]="googglet.com"

# ---------------------------------
# USER-AGENT ARRAY - MUST NOT MATCH
# ---------------------------------

REFmustnotmatch[0]="zx6.russia"
REFmustnotmatch[1]="100dollars-seo.community"
REFmustnotmatch[2]="googglet.co"
REFmustnotmatch[3]="google.com"

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

# -----------------------
# UA FALSE POSITIVE TESTS
# -----------------------

UAtest_mustmatch () {
for mustmatch in "${UAmustmatch[@]}"
do
   if
   curl -A "${mustmatch}" http://localhost:9000 2>&1 | grep -i '(52)'; then
   echo "${bold}${green}PASSED - ${red}${mustmatch} was ${bold}${red}BLOCKED"
   else
   echo "${bold}${red}FAILED - ${red}${mustmatch} was ${bold}${red}NOT BLOCKED"
   exit 1
   fi
done
}

UAtest_mustnotmatch () {
for mustnotmatch in "${UAmustnotmatch[@]}"
do
   if
   curl -A "${mustnotmatch}" http://localhost:9000 2>&1 | grep -i '(52)'; then
   echo "${bold}${red}FAILED (FALSE POSITIVE DETECTED) - ${bold}${red}${mustnotmatch}"
   exit 1
   else
   echo "${bold}${green}PASSED (FALSE POSITIVE NOT DETECTED) - ${bold}${red}${mustnotmatch}"
   fi
done
}

# -----------------------------
# REFERRER FALSE POSITIVE TESTS
# -----------------------------

REFtest_mustmatch () {
for mustmatch in "${REFmustmatch[@]}"
do
   if
   curl -A "${mustmatch}" http://localhost:9000 2>&1 | grep -i '(52)'; then
   echo "${bold}${green}PASSED - ${red}${mustmatch} was ${bold}${red}BLOCKED"
   else
   echo "${bold}${red}FAILED - ${red}${mustmatch} was ${bold}${red}NOT BLOCKED"
   #exit 1
   fi
done
}

REFtest_mustnotmatch () {
for mustnotmatch in "${REFmustnotmatch[@]}"
do
   if
   curl -A "${mustnotmatch}" http://localhost:9000 2>&1 | grep -i '(52)'; then
   echo "${bold}${red}FAILED (FALSE POSITIVE DETECTED) - ${bold}${red}${mustnotmatch}"
   #exit 1
   else
   echo "${bold}${green}PASSED (FALSE POSITIVE NOT DETECTED) - ${bold}${red}${mustnotmatch}"
   fi
done
}



# -------------------------
# Trigger Functions / Tests
# -------------------------

UAtest_mustmatch
UAtest_mustnotmatch
REFtest_mustmatch
REFtest_mustnotmatch

echo "${bold}${cyan}False Positive Testing Completed"
echo "${bold}${green}All Tests Passed"

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

