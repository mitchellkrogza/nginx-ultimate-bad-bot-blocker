#!/bin/bash
# Write Build Number Information into globalblacklist.conf 
# Created by: https://github.com/mitchellkrogza (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza

# Start time of script generation
start=$(date +%s.%N)
versionyear=$(date +%Y)
versionmonth=$(date +%m)
MY_GIT_TAG=V3.$versionyear.$versionmonth.$TRAVIS_BUILD_NUMBER
BAD_REFERRERS=$(wc -l < /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/_generator_lists/bad-referrers.list)
BAD_BOTS=$(wc -l < /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/_generator_lists/bad-user-agents.list)

# Temporary database files we create
_inputdbA=/tmp/lastupdated.db

# Declare Nginx template and temp variables
_tmpnginxA=tmpnginxA
_tmpnginxB=tmpnginxB

# Start and End Strings to Search for to do inserts into template
_startmarker="### Version Information #"
_endmarker="### Version Information ##"

# PRINT VERSION INFORMATION INTO GLOBALBLACKLIST FILE 1
# *****************************************************
LASTUPDATEIFS=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxA
runtime=$(python -c "print(${end} - ${start})")
printf "###################################################\n### Version: "$MY_GIT_TAG"\n### Updated: "$now"\n### Generated In: "$runtime" seconds\n### Bad Referrer Count: "$BAD_REFERRERS"\n### Bad Bot Count: "$BAD_BOTS"\n###################################################\n" >> $_tmpnginxA
echo $_endmarker  >> $_tmpnginxA
IFS=$LASTUPDATEIFS
mv $_tmpnginxA $_inputdbA
ed -s $_inputdbA<<\IN
1,/### Version Information #/d
/### Version Information ##/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/conf.d/globalblacklist.conf
/### Version Information #/x
.t.
.,/### Version Information ##/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/conf.d/globalblacklist.conf
q
IN
rm $_inputdbA

# PRINT VERSION INFORMATION INTO GLOBALBLACKLIST FILE 2
# *****************************************************
LASTUPDATE2IFS=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxB
runtime=$(python -c "print(${end} - ${start})")
printf "###################################################\n### Version: "$MY_GIT_TAG"\n### Updated: "$now"\n### Generated In: "$runtime" seconds\n### Bad Referrer Count: "$BAD_REFERRERS"\n### Bad Bot Count: "$BAD_BOTS"\n###################################################\n" >> $_tmpnginxB
echo $_endmarker  >> $_tmpnginxB
IFS=$LASTUPDATE2IFS
mv $_tmpnginxB $_inputdbA
ed -s $_inputdbA<<\IN
1,/### Version Information #/d
/### Version Information ##/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/_sample_config_files/Engintron_for_cPanel_WHM_Configuration_Example/etc/nginx/conf.d/globalblacklist.conf
/### Version Information #/x
.t.
.,/### Version Information ##/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/_sample_config_files/Engintron_for_cPanel_WHM_Configuration_Example/etc/nginx/conf.d/globalblacklist.conf
q
IN
rm $_inputdbA

exit 0
