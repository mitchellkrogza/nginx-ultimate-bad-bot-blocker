#!/bin/bash
# Write Build / Version Number into README.md 
# Created by: https://github.com/mitchellkrogza (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza

# Start time of script generation
start=$(date +%s.%N)
versionyear=$(date +%Y)
versionmonth=$(date +%m)
MY_GIT_TAG=V3.$versionyear.$versionmonth.$TRAVIS_BUILD_NUMBER

# Temporary database files we create
_inputdbA=/tmp/lastupdated.db
_tmpnginxA=tmpnginxA

# Start and End Strings to Search for to do inserts into template
_startmarker="####################"
_endmarker="#####################"

# PRINT VERSION INFORMATION INTO README.md
# ****************************************
LASTUPDATEIFS=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxA
runtime=$(python -c "print(${end} - ${start})")
printf "> VERSION: "$MY_GIT_TAG"" >> $_tmpnginxA
echo $_endmarker  >> $_tmpnginxA
IFS=$LASTUPDATEIFS
mv $_tmpnginxA $_inputdbA
ed -s $_inputdbA<<\IN
1,/####################/d
/#####################/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/README.md
/####################/x
.t.
.,/#####################/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/README.md
q
IN
rm $_inputdbA


exit 0
