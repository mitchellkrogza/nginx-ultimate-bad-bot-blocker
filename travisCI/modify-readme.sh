#!/bin/bash
# Write Build / Version Number into README.md 
# Created by: https://github.com/mitchellkrogza (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza

# Start time of script generation
versionyear=$(date +%Y)
versionmonth=$(date +%m)
MY_GIT_TAG=V3.$versionyear.$versionmonth.$TRAVIS_BUILD_NUMBER

# Set Temporary database and variables
_inputdbA=/tmp/lastupdated.db
_tmpnginxA=tmpnginxA

# Start and End Strings to Search for to do inserts into template
_startmarker=">>>"
_endmarker="<<<"

# PRINT VERSION INFORMATION INTO GLOBALBLACKLIST FILE 1
# *****************************************************
VERSIONUMBER=$IFS
IFS=$'\n'
echo $_startmarker >> $_tmpnginxA
printf " Version: "$MY_GIT_TAG "" >> $_tmpnginxA
echo $_endmarker  >> $_tmpnginxA
IFS=$VERSIONUMBER
mv $_tmpnginxA $_inputdbA
ed -s $_inputdbA<<\IN
1,/>>>/d
/<<</,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/README.md
/>>>/x
.t.
.,/<<</-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/README.md
q
IN
rm $_inputdbA

exit 0
