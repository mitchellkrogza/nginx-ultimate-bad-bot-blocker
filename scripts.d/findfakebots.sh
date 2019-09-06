#!/bin/sh
# FIND FAKE GOOGLEBOTS AND BINGBOTS FROM NGINX SERVER LOG FILES
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

# ---------------
# WHAT THIS DOES?
# ---------------------------------------------------------------------------------------------------------
# It extracts every single log line from all log files which claim to be Googlebot / bingbot
# This includes all valid Google and Bing bots too.
# These are extracted from your logs into new temporary log files. 
# These files are then processed with some magic to find only the fake bots which are then emailed to you.
# After the script has run and emailed you all temporary files are cleaned up and you original log files
# are not touched or modified in any way whatsoever.
# 
# It is lightning fast !!!
# 33.946s from start to finish for a full months worth of log files from 40 web sites.
# 
# THIS SCRIPT WILL PROCESS ALL CURRENT LOG FILES IN YOUR NGINX LOG FILE LOCATION
# This means it ONLY processes this months "current" log files which are xxxxxxxx-access.log
# It will NOT process rolled over log files ie xxxxxxxx-access.log.1 and xxxxxxx-access.log.2
# It is pointless looking for Fake Bots in older logs anyway as these guys change IP's frequently.
#
# This script does NOT touch or modify ANY of your real log files.
# ---------------------------------------------------------------------------------------------------------

# ----------------------
# REQUIREMENTS AND NOTES
# ----------------------
# - mutt (sending emails) - sudo apt install mutt
# - awk
# - nawk
# - sed
# - dig
# - USES: ANY existing Nginx log format that starts with '$remote_addr'

# ---------------------- 
# INSTALLATION AND USAGE
# ----------------------

# --------------------------------------------------------
# 1. STOP Mutt from storing all sent emails
# otherwise it creates an ever growing file called "sent"
# --------------------------------------------------------
#
# sudo nano /etc/Muttrc
# 
# ---------------------------------------
# 2. PASTE this at the bottom of the file
# ---------------------------------------
# 
# set copy = no
# set folder = ""
# 
# ----------------------------------------------------------
# 3. SAVE this script in your HOME folder as findfakebots.sh
# ----------------------------------------------------------
# 
# ------------------------------
# 4. MAKE this script executable 
# ------------------------------
# 
# sudo chmod +x findfakebots.sh
# 
# -------------------------------------
# 5. EDIT the USER SETTINGS block below
# -------------------------------------
# 
# ---------------------------
# 6. RUN the script with sudo
# ---------------------------
# 
# cd ${HOME}
# sudo ./findfakebots.sh
# 
# RUN FROM CRON as you like, make sure you have allowed your user to run sudo from CRON through visudo !!!
# You should only need to run this perhaps once a week.
#
# --------------------------
# 7. REPORTING YOUR FINDINGS
# --------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------
# When you see the email you will receive you will see a list of IP's detected and below that a list of the same IP's with their reverse DNS Names.
# Before you report them in this repo as issues you need to first get the whois details of each and log ONLY ONE IP per issue.
#
# See example: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/issues/293
#
# Your issue MUST include:
# - the whois output from https://www.ultratools.com/tools/ipWhoisLookupResult
# - An excerpt from your log file
# - DO NOT log issues with any IP's that resolve with 'dynamic' or 'adsl' in the reverse lookup it is pointless blocking dynamic addresses.
# ----------------------------------------------------------------------------------------------------------------------------------------------------

# -------------
# USER SETTINGS
# -------------

recipient="" # < ADD your own email address between the ""
nginxlogslocation=/var/log/nginx # < Location of your nginx log directory

# -----------------
# END USER SETTINGS
# -----------------

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# ------------------------------------
# DONT MODIFY ANYTHING BELOW THIS LINE
# ------------------------------------
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# ---------
# VARIABLES
# ---------

datenow=$(date +%F)
timenow=$(date +%T)

# -----------------
# TEMP FILES WE USE
# -----------------

googlelog=${nginxlogslocation}/googlebots.log
googlefile=${HOME}/googlebots.list
googleemailfile=${HOME}/fakegooglebots.txt
googletestfile=${HOME}/googlebots.tested
googlefakefile=${HOME}/googlebots.fake

binglog=${nginxlogslocation}/bingbots.log
bingfile=${HOME}/bingbots.list
bingemailfile=${HOME}/fakebingbots.txt
bingtestfile=${HOME}/bingbots.tested
bingfakefile=${HOME}/bingbots.fake

tempfile=${HOME}/file.tmp

# -----------------------------
# PROCESS ALL CURRENT LOG FILES
# -----------------------------

cd ${nginxlogslocation}

# FIND ALL GOOGLEBOTS AND WRITE THEM TO A NEW LOG FILE
for logfile in $(find . -type f -name '*access.log' -a ! -name '*access.log.'); do
	grep 'compatible\; Googlebot\/' ${logfile} >> ${googlelog}
done

# FIND ALL BINGBOTS AND WRITE THEM TO A NEW LOG FILE
for logfile in $(find . -type f -name '*access.log' -a ! -name '*access.log.'); do
	grep 'compatible\; bingbot\/' ${logfile} >> ${binglog}
done

# -----------------------------
# FIND AND TEST FAKE GOOGLEBOTS
# -----------------------------

# Prepare Latest File GoogleBots File
nawk '{print $1}' ${googlelog} > ${tempfile} && mv ${tempfile} ${googlefile}
# Sort the File for Duplicates
sort -u ${googlefile} -o ${googlefile}
# Test Each Fake Bot
while read line
do
        echo $line - `dig -x "$line" +short`
done < ${googlefile} > ${googletestfile}
# Print all Reverse DNS Results NOT Containing "Google" ie. Possible FAKE BOTS
awk '!/google/' ${googletestfile} > ${googlefakefile}
# Prepare our Email File
# Print list of IP's only first
nawk '{print $1}' ${googlefakefile} > ${tempfile} && mv ${tempfile} ${googleemailfile}
# Sort the File
sort -u ${googleemailfile} -o ${googleemailfile}
# Add Extra Info to Email File this section at bottom of email file includes the Reverse DNS Names we looked up
printf '\n-----------------------------------\nIP ADDRESSES WITH REVERSE DNS NAMES\n-----------------------------------\n\n' >> ${googleemailfile}
awk -F "-" '{print $1,$NF}' ${googlefakefile} >> ${googleemailfile}
# Print Message Date and Time at Top of Email
sed -i "1s/^/Possible Fake GoogleBots Detected\n$datenow - $timenow\n---------------------------------\n\n---------------------------------\nIP ADDRESSES FOUND\n---------------------------------\n/" ${googleemailfile}
# If our File is Empty we do ot Send an Email, OPtherwise we send the email
if [ -s "$googleemailfile" ]
then
# Email Me the Files
echo "Fake GoogleBots" | mutt -s "Fake GoogleBots" -a ${googleemailfile} -- ${recipient} 
else
    :
fi

# ---------------------------------
# END FIND AND TEST FAKE GOOGLEBOTS
# ---------------------------------

# ---------------------------
# FIND AND TEST FAKE BINGBOTS
# ---------------------------

# Prepare Latest File BingBots File
nawk '{print $1}' ${binglog} > ${tempfile} && mv ${tempfile} ${bingfile}
# Sort the File for Duplicates
sort -u ${bingfile} -o ${bingfile}
# Test Each Fake Bot
while read line
do
        echo $line - `dig -x "$line" +short`
done < ${bingfile} > ${bingtestfile}
# Print all Reverse DNS Results NOT Containing "Google" ie. Possible FAKE BOTS
awk '!/msn/' ${bingtestfile} > ${bingfakefile}
# Prepare our Email File
# Print list of IP's only first
nawk '{print $1}' ${bingfakefile} > ${tempfile} && mv ${tempfile} ${bingemailfile}
# Sort the File
sort -u ${bingemailfile} -o ${bingemailfile}
# Add Extra Info to Email File this section at ottom of email file includes the Reverse DNS Names we looked up
printf '\n-----------------------------------\nIP ADDRESSES WITH REVERSE DNS NAMES\n-----------------------------------\n\n' >> ${bingemailfile}
awk -F "-" '{print $1,$NF}' ${bingfakefile} >> ${bingemailfile}
# Print Message Date and Time at Top of Email
sed -i "1s/^/Possible Fake BingBots Detected\n$datenow - $timenow\n---------------------------------\n\n---------------------------------\nIP ADDRESSES FOUND\n---------------------------------\n/" ${bingemailfile}
# If our File is Empty we do ot Send an Email, OPtherwise we send the email
if [ -s "$bingemailfile" ]
then
# Email Me the Files
echo "Fake BingBots" | mutt -s "Fake Bing Bots" -a ${bingemailfile} -- ${recipient} 
else
    :
fi

# -------------------------------
# END FIND AND TEST FAKE BINGBOTS
# -------------------------------

# ---------------------------------------------------
# DELETE ALL TEMP FILES
# ---------------------------------------------------
# This does NOT delete any of your real server logs
# only the temp log files created by this script
# ---------------------------------------------------

sudo rm ${googlelog}
sudo rm ${binglog}
sudo rm ${googlefile}
sudo rm ${googleemailfile}
sudo rm ${googletestfile}
sudo rm ${googlefakefile}
sudo rm ${bingfile}
sudo rm ${bingemailfile}
sudo rm ${bingtestfile}
sudo rm ${bingfakefile}

# ----------------------
# EXIT WITH ERROR NUMBER
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


