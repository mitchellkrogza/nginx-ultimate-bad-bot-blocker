#CONFIGURATION INSTRUCTIONS FOR THE NGINX BAD BOT BLOCKER:
### PLEASE READ CONFIGURATION INSTRUCTIONS BELOW THOROUGHLY

##### Created by: https://github.com/mitchellkrogza
##### Copyright Mitchell Krog <mitchellkrog@gmail.com>
### Version 2.2017.05

#CONFIGURATION OF THE NGINX BAD BOT BLOCKER:
### PLEASE READ CONFIGURATION INSTRUCTIONS BELOW THOROUGHLY

**If you miss one step you will get an nginx EMERG error. This is normally a result of not downloading either blockbots.conf, ddos.conf, whitelist-ips.conf, whitelist-domains.conf or blacklist-user-agents.conf into your /etc/nginx/bots.d folder. If any of the include files are missing Nginx will EMERG and will not reload.**

#### AUTO INSTALLATION INSTRUCTIONS
To Make Sure you copy all the correct files you can now use a simple bash setup script for copying the files into the correct nginx folders for you:
See: https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/installnginxblocker.sh

**Please Note:** the bash installer script does not carry out STEP 7 of the manual configuration instructions for you. YOU MUST edit your any vhosts files  yourself and manually add the entries in STEP 7 or the blocker will not actually be protecting any sites.

## MANUAL INSTALLATION INSTRUCTIONS

##STEP 1:

**COPY THE GLOBALBLACKLIST.CONF FILE FROM THE REPO**

Copy the contents of **/conf.d/globalblacklist.conf** into your /etc/nginx/conf.d folder. 

`cd /etc/nginx/conf.d`

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf -O globalblacklist.conf`

##STEP 2: 

**COPY THE INCLUDE FILES FROM THE REPO**

- From your command line in Linux type

`sudo mkdir /etc/nginx/bots.d `

`cd /etc/nginx/bots.d`

- copy the blockbots.conf file into that folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blockbots.conf -O blockbots.conf`


- copy the ddos.conf file into the same folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/ddos.conf -O ddos.conf`

##STEP 3:

**WHITELIST ALL YOUR OWN DOMAIN NAMES AND IP ADDRESSES**

Whitelist all your own domain names and IP addresses. **Please note important changes**, this is now done using include files so that you do not have to keep reinserting your whitelisted domains and IP addresses every time you update.

`cd /etc/nginx/bots.d`

- copy the whitelist-ips.conf file into that folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-ips.conf -O whitelist-ips.conf`


- copy the whitelist-domains.conf file into the same folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-domains.conf -O whitelist-domains.conf`


Use nano, vim or any other text editor to edit both whitelist-ips.conf and whitelist-domains.conf to include all your own domain names and IP addresses that you want to specifically whitelist from the blocker script. 

When pulling any future updates now you can simply pull the latest globalblacklist.conf file and it will automatically include your whitelisted domains and IP addresses.

##STEP 4:

**BLACKLIST USING YOUR OWN CUSTOM USER-AGENT BLACKLIST**

Copy the custom User-Agents blacklist file into your /etc/nginx/bots.d folder

`cd /etc/nginx/bots.d`

- copy the blacklist-user-agents.conf file into the same folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blacklist-user-agents.conf -O blacklist-user-agents.conf`


Use nano, vim or any other text editor to edit (if needed) blacklist-user-agents.conf to include your own custom list of bad agents that are not included in the blocker like "omgilibot" which some people choose to block. 


##STEP 5:

**INCLUDE IMPORTANT SETTINGS IN NGINX.CONF**
**Also see SAMPLE-nginx.conf file in the root of this repository**

`cd /etc/nginx/conf.d`

- copy the botblocker-nginx-settings.conf file directly from the repo

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/botblocker-nginx-settings.conf -O botblocker-nginx-settings.conf`

**What is included in this settings file above for nginx?**
The important settings file above adds the rate limiting functions and hash_bucket settings for nginx for you. Below is what the file contains, you cn add these manually to your nginx.conf file if you so please but the include file above will do it for you ad nginx loads any .conf file in /etc/conf.d (See STEP 6)

> server_names_hash_bucket_size 64;

> server_names_hash_max_size 4096;

> limit_req_zone $binary_remote_addr zone=flood:50m rate=90r/s;

> limit_conn_zone $binary_remote_addr zone=addr:50m;

**PLEASE NOTE:** The above rate limiting rules are for the DDOS filter, it may seem like high values to you but for wordpress sites with plugins and lots of images, it's not. This will not limit any real visitor to your Wordpress sites but it will immediately rate limit any aggressive bot. Remember that other bots and user agents are rate limited using a different rate limiting rule at the bottom of the globalblacklist.conf file.

The server_names_hash settings allows Nginx Server to load this very large list of domain names and IP addresses into memory. You can tweak these settings to your own requirements.


##STEP 6: **VERY IMPORTANT**

**MAKE SURE** that your nginx.conf file contains the following include directive. If it's commented out make sure to uncomment it or none of this will work.

- `include /etc/nginx/conf.d/*`


##STEP 7: **VERY IMPORTANT**

**ADD INCLUDE FILES INTO A VHOST**

Open a site config file for Nginx (just one for now) and add the following lines.

##### VERY IMPORTANT NOTE: 

These includes MUST be added within a **server {}** block of a vhost otherwise you will get EMERG errors from Nginx.

- `include /etc/nginx/bots.d/blockbots.conf;`

- `include /etc/nginx/bots.d/ddos.conf;`

##STEP 8:

**TESTING YOUR NGINX CONFIGURATION**

`sudo nginx -t`

If you get no errors then you followed my instructions so now you can make the blocker go live with a simple.

`sudo service nginx reload`

The blocker is now active and working so now you can run some simple tests from another linux machine to make sure it's working.

##STEP 9:

**TESTING**

Run the following commands one by one from a terminal on another linux machine against your own domain name. 
**substitute yourdomain.com in the examples below with your REAL domain name**

`curl -A "googlebot" http://yourdomain.com`

Should respond with 200 OK

`curl -A "80legs" http://yourdomain.com`

`curl -A "masscan" http://yourdomain.com`

Should respond with: curl: (52) Empty reply from server

`curl -I http://yourdomain.com -e http://100dollars-seo.com`

`curl -I http://yourdomain.com -e http://zyzzcentral.ru`

Should respond with: curl: (52) Empty reply from server

The Nginx Ultimate Bot Blocker is now WORKING and PROTECTING your web sites !!!

##STEP 10:

**UPDATING THE NGINX BAD BOT BLOCKER** is now easy thanks to the automatic includes for whitelisting your own domain names.

Updating to the latest version is now as simple as:

`cd /etc/nginx/conf.d`

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf`

`sudo nginx -t`

`sudo service nginx reload` 

And you will be up to date with all your whitelisted domains included automatically for you now. 

# AUTO UPDATING:

See my latest auto updater bash script at:

https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/updatenginxblocker.sh

Relax now and sleep better at night knowing your site is telling all those baddies they are FORBIDDEN !!!


### PULL REQUESTS:
To contribute your own bad referers please add them into the https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/Pull%20Requests%20Here%20Please/badreferers.list file and then send a Pull Request (PR). 

##### **All additions will be checked for accuracy before being merged.**

### ISSUES:
Log any issues regarding incorrect listings or any other problems on the issues system and they will be investigated and removed if necessary. I responde very quickly to user problems and have helped countless users for days on end to get their bot blocker working. You could say I am mad (disputable) but I love helping people and do not ignore issues or people with problems getting this to work.