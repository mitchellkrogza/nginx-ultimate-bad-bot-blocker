#!/bin/bash
echo "Testing 50 Random Bots"
IFS=$'\n'
file=/home/mitchellkrog/GIT/nginx-ultimate-bad-bot-blocker/.dev-tools/test_units/random-bots-for-test.list
lines=$(cat $file)
#echo ${lines}
for line in $lines; do
   if
   curl -v -A "${line}" http://localhost 2>&1 | grep -i '(52)'; then 
   echo "$(tput setaf 1)BAD BOT DETECTED - $(tput setaf 2)TEST PASSED"
   else
   echo "$(tput setaf 1)BAD REFERRER NOT DETECTED - TEST FAILED"
   curl -v -A "${line}" http://localhost 2>&1
   fi
done
