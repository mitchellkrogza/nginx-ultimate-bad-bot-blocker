#!/bin/bash
# Generator Script for NGinx Ultimate Bad Bot Blocker
# REPO: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker
# Copyright Mitchell Krog - mitchellkrog@gmail.com

# *******************************
# Input and Output File Variables
# *******************************

outputfile=${TRAVIS_BUILD_DIR}/_generator_lists/bad-ip-addresses.list

# **************
# Temp Variables
# **************

tmp=${TRAVIS_BUILD_DIR}/_generator_lists/tmp.list

# **********************************************
# Fetch our feed(s) and append to our input file
# **********************************************

fetch () {
    sudo wget https://raw.githubusercontent.com/mitchellkrogza/Suspicious.Snooping.Sniffing.Hacking.IP.Addresses/master/ips.list -O ${outputfile}
}

# *************************************************
# Prepare our input lists and remove any duplicates
# *************************************************

initiate () {

    # Prepare Feed 1
    sort -u ${outputfile} -o ${outputfile}
    grep '[^[:blank:]]' < ${outputfile} > ${tmp}
    sudo mv ${tmp} ${outputfile}
	sudo dos2unix ${outputfile}

}

# *****************
# Trigger Functions
# *****************

fetch
initiate

# **********************
# Exit With Error Number
# **********************

exit ${?}
