#!/bin/bash
# Write Build / Version Number into README.md 
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
_tmpnginxA=tmpnginxA

# Start and End Strings to Search for to do inserts into template
_startmarker="##### Version Information #"
_endmarker="##### Version Information ##"

# PRINT VERSION INFORMATION INTO README.md
# ****************************************
LASTUPDATEIFS=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxA
runtime=$(python -c "print(${end} - ${start})")
printf "********************************************\n#### Version: "$MY_GIT_TAG"\n#### Bad Referrer Count: "$BAD_REFERRERS"\n#### Bad Bot Count: "$BAD_BOTS"\n********************************************\n" >> $_tmpnginxA
echo $_endmarker  >> $_tmpnginxA
IFS=$LASTUPDATEIFS
mv $_tmpnginxA $_inputdbA
ed -s $_inputdbA<<\IN
1,/##### Version Information #/d
/##### Version Information ##/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/README.md
/##### Version Information #/x
.t.
.,/##### Version Information ##/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/README.md
q
IN
rm $_inputdbA

# PRINT VERSION INFORMATION INTO AUTO-CONFIGURATION.md
# ****************************************************
LASTUPDATEIFS2=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxA
runtime=$(python -c "print(${end} - ${start})")
printf "********************************************\n# Version: "$MY_GIT_TAG"\n********************************************\n" >> $_tmpnginxA
echo $_endmarker  >> $_tmpnginxA
IFS=$LASTUPDATEIFS2
mv $_tmpnginxA $_inputdbA
ed -s $_inputdbA<<\IN
1,/##### Version Information #/d
/##### Version Information ##/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/AUTO-CONFIGURATION.md
/##### Version Information #/x
.t.
.,/##### Version Information ##/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/AUTO-CONFIGURATION.md
q
IN
rm $_inputdbA

# PRINT VERSION INFORMATION INTO MANUAL-CONFIGURATION.md
# ******************************************************
LASTUPDATEIFS3=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxA
runtime=$(python -c "print(${end} - ${start})")
printf "********************************************\n# Version: "$MY_GIT_TAG"\n********************************************\n" >> $_tmpnginxA
echo $_endmarker  >> $_tmpnginxA
IFS=$LASTUPDATEIFS3
mv $_tmpnginxA $_inputdbA
ed -s $_inputdbA<<\IN
1,/##### Version Information #/d
/##### Version Information ##/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/MANUAL-CONFIGURATION.md
/##### Version Information #/x
.t.
.,/##### Version Information ##/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/MANUAL-CONFIGURATION.md
q
IN
rm $_inputdbA


exit 0
