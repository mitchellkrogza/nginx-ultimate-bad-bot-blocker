#!/bin/bash
# Write Build / Version Number into README.md, AUTO-CONFIGURATION.md and MANUAL-CONFIGURATION.md files
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

YEAR=$(date +%Y)
MONTH=$(date +%m)
MY_GIT_TAG=V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER
BAD_REFERRERS=$(wc -l < $TRAVIS_BUILD_DIR/_generator_lists/bad-referrers.list)
BAD_BOTS=$(wc -l < $TRAVIS_BUILD_DIR/_generator_lists/bad-user-agents.list)

# **********************************
# Temporary database files we create
# **********************************

_inputdbA=/tmp/lastupdated.db
_tmpnginxA=tmpnginxA

# ***************************************************************
# Start and End Strings to Search for to do inserts into template
# ***************************************************************

_startmarker="##### Version Information #"
_endmarker="##### Version Information ##"

# ****************************************
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

# ****************************************************
# PRINT VERSION INFORMATION INTO AUTO-CONFIGURATION.md
# ****************************************************

LASTUPDATEIFS2=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxA
runtime=$(python -c "print(${end} - ${start})")
printf "********************************************\n#### Version: "$MY_GIT_TAG"\n#### Bad Referrer Count: "$BAD_REFERRERS"\n#### Bad Bot Count: "$BAD_BOTS"\n********************************************\n" >> $_tmpnginxA
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

# ******************************************************
# PRINT VERSION INFORMATION INTO MANUAL-CONFIGURATION.md
# ******************************************************

LASTUPDATEIFS3=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxA
runtime=$(python -c "print(${end} - ${start})")
printf "********************************************\n#### Version: "$MY_GIT_TAG"\n#### Bad Referrer Count: "$BAD_REFERRERS"\n#### Bad Bot Count: "$BAD_BOTS"\n********************************************\n" >> $_tmpnginxA
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