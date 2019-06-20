#!/bin/bash
# robots.txt Web Sites Updater for the Nginx Ultimate Bad Bot Blocker
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

# THE SCRIPT
# 1. Save this to your folder where you want to execute it from 
# 2. Name the file updaterobots.sh
# 3. Make it executable | sudo chmod +x /usr/sbin/updaterobots.sh
# 4. Run it from Cron as root when you like 

# ************************
# Declare Folder Locations
# ************************

tmpfolder=/tmp
webfolder=/var/www

# ***********************
# Fetch Latest robots.txt
# ***********************

sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/robots.txt/robots.txt -O ${tmpfolder}/robots.txt

# **************************************************************************
# Loop through web directory, update robots.txt files and update permissions
# Just Comment out the updating of permissions if you do not want to do that
# **************************************************************************

for directory in $(find ${webfolder} -maxdepth 1 -type d)
do

  # Copy robots.txt file into folder
  sudo cp ${tmpfolder}/robots.txt ${directory}

  # Update the directory permissions for www-data / Comment out the next line if you don't want this.
  sudo chown -R www-data:www-data ${directory}

done

# ***********************
# Send Email Notification
# ***********************

# Put your own email address below and uncomment the line if you want an email notification
#echo "Done" | mail -s "Robots.txt Updated" someone@somewhere.com

exit ${?}