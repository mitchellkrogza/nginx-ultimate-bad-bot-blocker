#!/bin/bash
# Generator Script for the Nginx Ultimate Bad Bot Blocker
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

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
MY_GIT_TAG=V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER
BAD_REFERRERS=$(wc -l < $TRAVIS_BUILD_DIR/_generator_lists/bad-referrers.list)
BAD_BOTS=$(wc -l < $TRAVIS_BUILD_DIR/_generator_lists/bad-user-agents.list)

# *************************************
# Specify input lists for the generator
# *************************************

_input1=$TRAVIS_BUILD_DIR/_generator_lists/good-user-agents.list
_input2=$TRAVIS_BUILD_DIR/_generator_lists/allowed-user-agents.list
_input3=$TRAVIS_BUILD_DIR/_generator_lists/limited-user-agents.list
_input4=$TRAVIS_BUILD_DIR/_generator_lists/bad-user-agents.list
_input5=$TRAVIS_BUILD_DIR/_generator_lists/bad-referrers.list
_input6=$TRAVIS_BUILD_DIR/_generator_lists/google-ip-ranges.list
_input7=$TRAVIS_BUILD_DIR/_generator_lists/bing-ip-ranges.list
_input8=$TRAVIS_BUILD_DIR/_generator_lists/wordpress-theme-detectors.list
_input9=$TRAVIS_BUILD_DIR/_generator_lists/nibbler-seo.list
_input10=$TRAVIS_BUILD_DIR/_generator_lists/cloudflare-ip-ranges.list

# *******************************************************
# Declare temporary database files used during generation
# *******************************************************

_inputdbA=/tmp/version-information.db
_inputdb1=/tmp/good-user-agents.db
_inputdb2=/tmp/allowed-user-agents.db
_inputdb3=/tmp/limited-user-agents.db
_inputdb4=/tmp/bad-user-agents.db
_inputdb5=/tmp/bad-referers.db
_inputdb6=/tmp/google-ip-ranges.db
_inputdb7=/tmp/bing-ip-ranges.db
_inputdb8=/tmp/wordpress-theme-detectors.db
_inputdb9=/tmp/nibbler-seo.db
_inputdb10=/tmp/cloudflare-ip-ranges.db

# **************************************************
# Declare temporary variables used during generation
# **************************************************

_nginx=$TRAVIS_BUILD_DIR/travisCI/globalblacklist.template
_tmpnginxA=tmpnginxA
_tmpnginx1=tmpnginx1
_tmpnginx2=tmpnginx2
_tmpnginx3=tmpnginx3
_tmpnginx4=tmpnginx4
_tmpnginx5=tmpnginx5
_tmpnginx6=tmpnginx6
_tmpnginx7=tmpnginx7
_tmpnginx8=tmpnginx8
_tmpnginx9=tmpnginx9
_tmpnginx10=tmpnginx10

# *************************************************************
# Sort all input lists alphabetically and remove any duplicates
# *************************************************************

sort -u $_input1 -o $_input1
sort -u $_input2 -o $_input2
sort -u $_input3 -o $_input3
sort -u $_input4 -o $_input4
sort -u $_input5 -o $_input5
sort -u $_input6 -o $_input6
sort -u $_input7 -o $_input7
sort -u $_input8 -o $_input8
sort -u $_input9 -o $_input9
sort -u $_input10 -o $_input10

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
_start5="# START BAD REFERERS ### DO NOT EDIT THIS LINE AT ALL ###"
_end5="# END BAD REFERERS ### DO NOT EDIT THIS LINE AT ALL ###"
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
_startmarker="### Version Information #"
_endmarker="### Version Information ##"

# **********************************
# SET ALLOW OR DENY ACTION VARIABLES
# **********************************

ACTION1="0;"
ACTION2="1;"
ACTION3="2;"
ACTION4="3;"


# ************************************
# GOOD USER AGENTS - Create and Insert
# ************************************

GOODBOTSIFS=$IFS
IFS=$'\n'
echo $_start1 >> $_tmpnginx1
for line in $(cat $_input1); do
printf "\t\"~${line}\"\t\t$ACTION1\n" >> $_tmpnginx1
done
echo $_end1  >> $_tmpnginx1
IFS=$GOODBOTSIFS
mv $_tmpnginx1 $_inputdb1
ed -s $_inputdb1<<\IN
1,/# START GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END GOOD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb1

# ********************************
# ALLOWED BOTS - Create and Insert
# ********************************

ALLOWEDBOTSIFS=$IFS
IFS=$'\n'
echo $_start2 >> $_tmpnginx2
for line in $(cat $_input2); do
printf "\t\"~${line}\"\t\t$ACTION2\n" >> $_tmpnginx2
done
echo $_end2  >> $_tmpnginx2
IFS=$ALLOWEDBOTSIFS
mv $_tmpnginx2 $_inputdb2
ed -s $_inputdb2<<\IN
1,/# START ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END ALLOWED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb2

# ********************************
# LIMITED BOTS - Create and Insert
# ********************************

LIMITEDBOTSIFS=$IFS
IFS=$'\n'
echo $_start3 >> $_tmpnginx3
for line in $(cat $_input3); do
printf "\t\"~${line}\"\t\t$ACTION3\n" >> $_tmpnginx3
done
echo $_end3  >> $_tmpnginx3
IFS=$LIMITEDBOTSIFS
mv $_tmpnginx3 $_inputdb3
ed -s $_inputdb3<<\IN
1,/# START LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END LIMITED BOTS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb3

# ****************************
# BAD BOTS - Create and Insert
# ****************************

BADBOTSIFS=$IFS
IFS=$'\n'
echo $_start4 >> $_tmpnginx4
for line in $(cat $_input4); do
printf "\t\"~*${line}\"\t\t$ACTION4\n" >> $_tmpnginx4
done
echo $_end4  >> $_tmpnginx4
IFS=$BADBOTSIFS
mv $_tmpnginx4 $_inputdb4
ed -s $_inputdb4<<\IN
1,/# START BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END BAD BOTS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb4

# ********************************
# BAD REFERERS - Create and Insert
# ********************************

BADREFERER=$IFS
IFS=$'\n'
echo $_start5 >> $_tmpnginx5
for line in $(cat $_input5); do
printf "\t\"~*${line}\"\t\t$ACTION2\n" >> $_tmpnginx5
done
echo $_end5  >> $_tmpnginx5
IFS=$BADREFERER
mv $_tmpnginx5 $_inputdb5
ed -s $_inputdb5<<\IN
1,/# START BAD REFERERS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END BAD REFERERS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START BAD REFERERS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END BAD REFERERS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb5

# ************************************
# GOOGLE IP RANGES - Create and Insert
# ************************************

GOOGLE=$IFS
IFS=$'\n'
echo $_start6 >> $_tmpnginx6
for line in $(cat $_input6); do
printf "\t${line}\t\t$ACTION1\n" >> $_tmpnginx6
done
echo $_end6  >> $_tmpnginx6
IFS=$GOOGLE
mv $_tmpnginx6 $_inputdb6
ed -s $_inputdb6<<\IN
1,/# START GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END GOOGLE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb6

# **********************************
# BING IP RANGES - Create and Insert
# **********************************

BING=$IFS
IFS=$'\n'
echo $_start7 >> $_tmpnginx7
for line in $(cat $_input7); do
printf "\t${line}\t\t$ACTION1\n" >> $_tmpnginx7
done
echo $_end7  >> $_tmpnginx7
IFS=$BING
mv $_tmpnginx7 $_inputdb7
ed -s $_inputdb7<<\IN
1,/# START BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END BING IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb7

# *********************************************
# Wordpress Theme Detectors - Create and Insert
# *********************************************

WPTHEME=$IFS
IFS=$'\n'
echo $_start8 >> $_tmpnginx8
for line in $(cat $_input8); do
printf "\t${line}\n" >> $_tmpnginx8
done
echo $_end8  >> $_tmpnginx8
IFS=$WPTHEME
mv $_tmpnginx8 $_inputdb8
ed -s $_inputdb8<<\IN
1,/# START WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END WP THEME DETECTORS ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb8

# *******************************
# Nibbler SEO - Create and Insert
# *******************************

NIBBLER=$IFS
IFS=$'\n'
echo $_start9 >> $_tmpnginx9
for line in $(cat $_input9); do
printf "\t${line}\t\t$ACTION2\n" >> $_tmpnginx9
done
echo $_end9  >> $_tmpnginx9
IFS=$NIBBLER
mv $_tmpnginx9 $_inputdb9
ed -s $_inputdb9<<\IN
1,/# START NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END NIBBLER ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb9

# ****************************************
# CLOUDFLARE IP RANGES - Create and Insert
# ****************************************

CLOUDFLARE=$IFS
IFS=$'\n'
echo $_start10 >> $_tmpnginx10
for line in $(cat $_input10); do
printf "\t${line}\t\t$ACTION1\n" >> $_tmpnginx10
done
echo $_end10  >> $_tmpnginx10
IFS=$CLOUDFLARE
mv $_tmpnginx10 $_inputdb10
ed -s $_inputdb10<<\IN
1,/# START CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/d
/# END CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/# START CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/x
.t.
.,/# END CLOUDFLARE IP RANGES ### DO NOT EDIT THIS LINE AT ALL ###/-d
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdb10


# *******************************************************************************
# PRINT VERSION, SCRIPT RUNTIME and UPDATE INFORMATION INTO GLOBALBLACKLIST FILES
# *******************************************************************************

LASTUPDATEIFS=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxA
printf "###################################################\n### Version: "$MY_GIT_TAG"\n### Updated: "$now"\n### Bad Referrer Count: "$BAD_REFERRERS"\n### Bad Bot Count: "$BAD_BOTS"\n###################################################\n" >> $_tmpnginxA
echo $_endmarker  >> $_tmpnginxA
IFS=$LASTUPDATEIFS
mv $_tmpnginxA $_inputdbA
ed -s $_inputdbA<<\IN
1,/### Version Information #/d
/### Version Information ##/,$d
,d
.r /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
/### Version Information #/x
.t.
.,/### Version Information ##/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/travisCI/globalblacklist.template
q
IN
rm $_inputdbA

# **************************************************
# Generate Additional Files and Copy Them to Folders
# **************************************************

#sudo cp $_input1 $TRAVIS_BUILD_DIR/_generator_lists/good-user-agents.list
#sudo cp $_input2 $TRAVIS_BUILD_DIR/_generator_lists/allowed-user-agents.list
#sudo cp $_input3 $TRAVIS_BUILD_DIR/_generator_lists/limited-user-agents.list
#sudo cp $_input4 $TRAVIS_BUILD_DIR/_generator_lists/bad-user-agents.list
#sudo cp $_input5 $TRAVIS_BUILD_DIR/_generator_lists/bad-referrers.list
#sudo cp $_input6 $TRAVIS_BUILD_DIR/_generator_lists/google-ip-ranges.list
#sudo cp $_input7 $TRAVIS_BUILD_DIR/_generator_lists/bing-ip-ranges.list
#sudo cp $_input8 $TRAVIS_BUILD_DIR/_generator_lists/wordpress-theme-detectors.list
#sudo cp $_input9 $TRAVIS_BUILD_DIR/_generator_lists/nibbler-seo.list
#sudo cp $_input10 $TRAVIS_BUILD_DIR/_generator_lists/cloudflare-ip-ranges.list
sudo cp $_nginx $TRAVIS_BUILD_DIR/conf.d/globalblacklist.conf
sudo cp $_nginx $TRAVIS_BUILD_DIR/_sample_config_files/Engintron_for_cPanel_WHM_Configuration_Example/etc/nginx/conf.d/globalblacklist.conf

exit 0


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