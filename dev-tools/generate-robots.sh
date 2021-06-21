#!/bin/bash
# Generator Script for the Nginx Ultimate Bad Bot Blocker
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

# Generate a robots.txt file for those unable to use the full Nginx Ultimate Bad Bot Blocker

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

# --------------
# File Variables
# --------------

_input1=./_generator_lists/bad-user-agents.list
_tmprobots=./tmp/robots.txt
_inputtmp=./dev-tools/_robots_input/robots.tmp
_output=./dev-tools/_robots_input/robots-input.txt

# ---------
# Variables
# ---------

YEAR=$(date +"%Y")
MONTH=$(date +"%m")
MY_GIT_TAG=V4.${YEAR}.${MONTH}.${TRAVIS_BUILD_NUMBER}
BAD_REFERRERS=$(wc -l < ./_generator_lists/bad-referrers.list)
BAD_BOTS=$(wc -l < ./_generator_lists/bad-user-agents.list)
_now="$(date)"
_startmarker="### Version Information #"
_endmarker="### Version Information ##"

# ---------
# FUNCTIONS
# ---------

generateRobotsFile () {
sudo truncate -s 0 ${_output}
# Use sed to prepare our new input file
cat ${_input1} | sed 's/\\ / /g' > ${_inputtmp} && mv ${_inputtmp} ${_output}
printf '###################################################################\n# The Ultimate robots.txt Bot and User-Agent Blocker\n# Copyright:\n# https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker\n###################################################################\n\n' >> "${_tmprobots}"
printf '%s\n%s\n%s%s\n%s%s\n%s%s\n%s\n%s\n\n%s\n%s\n%s\n' "$_startmarker" "###################################################" "### Version: " "$MY_GIT_TAG" "### Updated: " "$_now" "### Bad Bot Count: " "$BAD_BOTS" "###################################################" "$_endmarker" "User-agent: *" "Disallow: /wp-admin/" "Allow: /wp-admin/admin-ajax.php" >> "${_tmprobots}"
while IFS= read -r LINE
do
printf 'User-agent: %s\n%s\n' "${LINE}" "Disallow:/" >> "${_tmprobots}"
done < ${_output}
printf '\n' >> ${_tmprobots}
sudo cp ${_tmprobots} ./robots.txt/robots.txt
echo "${bold}${green}-------------------------------"
echo "${bold}${green}robots.txt Generation Completed"
echo "${bold}${green}-------------------------------"
printf "\n"
}

# ----------------
# Trigger Function
# ----------------

generateRobotsFile

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