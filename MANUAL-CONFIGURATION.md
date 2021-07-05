<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/_logo_nginx_bad_bot_blocker.png" alt="Nginx Ultimate Bad Bot Spam Referrer Blocker - Nginx Block Bad Bots, Vulnerability Scanners, Malware and Adware, Malicious Sites, Spam Referrers, Bad Referrers, Spam Blocker with DDOS, Wordpress Theme Detector Blocking and Fail2Ban Jail for Repeat Offenders"/><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![DUB](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/LICENSE.md)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![GitHub release](https://img.shields.io/github/release/mitchellkrogza/nginx-ultimate-bad-bot-blocker.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/releases/latest)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![Build Status](https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker.svg?branch=master)](https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/><a href='https://twitter.com/ubuntu101za'><img src='https://img.shields.io/twitter/follow/ubuntu101za.svg?style=social&label=Follow' alt='Follow @ubuntu101za'></a>

# MANUAL CONFIGURATION INSTRUCTIONS FOR THE NGINX BAD BOT BLOCKER:
### PLEASE READ CONFIGURATION INSTRUCTIONS BELOW THOROUGHLY :exclamation:

_______________
#### Version: V4.2021.07.2452
#### Bad Referrers Blocked: [7066](https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/_generator_lists/bad-referrers.list)
#### Bad User-Agents (Bots) Blocked: [615](https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/_generator_lists/bad-user-agents.list)
#### Fake Googlebots Blocked: [217](https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/_generator_lists/fake-googlebots.list)
____________________

## Help Support This Project 

[![Help me out with a mug of beer](https://img.shields.io/badge/Help%20-%20me%20out%20with%20a%20mug%20of%20%F0%9F%8D%BA-blue.svg)](https://paypal.me/mitchellkrog/) or [![Help me feed my cat](https://img.shields.io/badge/Help%20-%20me%20feed%20my%20hungry%20cat%20%F0%9F%98%B8-blue.svg)](https://paypal.me/mitchellkrog/)

************************************************
- Created by: https://github.com/mitchellkrogza for use on Nginx Web Server https://www.nginx.com/
- Copyright Mitchell Krog <mitchellkrog@gmail.com>

Not Using Nginx? See the [![Get the APACHE ULTIMATE BAD BOT BLOCKER](https://img.shields.io/badge/APACHE%20-%20ULTIMATE%20BAD%20BOT%20BLOCKER%20%E2%9B%94-blue.svg)](https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker)

************************************************
### Update Notification System - Stay up to date on New Builds and Major Feature Changes 

It is important to please <a href="https://groups.google.com/forum/#!forum/nginx-ultimate-bad-bot-blocker">subscribe your email address to the mailing list</a> or <a href="mailto:nginx-ultimate-bad-bot-blocker+subscribe@googlegroups.com">simply send a blank email here</a> to subscribe.

Please make sure you are subscribed to notifications to be notified when the blocker is updated and also to be notified when any important or mission critical (potentially breaking) changes take place.

##### Also follow me on twitter @ubuntu101za for update notifications

<a href='https://twitter.com/ubuntu101za'><img src='https://img.shields.io/twitter/follow/ubuntu101za.svg?style=social&label=Follow' alt='Follow @ubuntu101za'></a>

************************************************
### PLEASE READ CONFIGURATION INSTRUCTIONS BELOW THOROUGHLY :exclamation:

**If you miss one step you will get an nginx EMERG :exclamation: error. This is normally a result of not downloading either blockbots.conf, ddos.conf, whitelist-ips.conf, whitelist-domains.conf, bad-referrer-words.conf, custom-bad-referrers.conf, blacklist-user-agents.conf or blacklist-ips.conf into your /etc/nginx/bots.d folder. If any of the include files are missing Nginx will EMERG and will not reload.**

************************************************
## AUTO INSTALLATION INSTRUCTIONS

It is **HIGHLY SUGGESTED** to please use the <a href="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/AUTO-CONFIGURATION.md">auto installation scripts</a> created by Stuart Cardall @itoffshore

Please see: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/AUTO-CONFIGURATION.md

************************************************
## MANUAL INSTALLATION INSTRUCTIONS
************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-1.png"/>

**COPY THE GLOBALBLACKLIST.CONF FILE FROM THE REPO**

Copy the contents of **/conf.d/globalblacklist.conf** into your /etc/nginx/conf.d folder. 

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf -O /etc/nginx/conf.d/globalblacklist.conf`

If your Linux distribution does not have wget you can replace the wget commands above using curl as follows:

`curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf -o /etc/nginx/conf.d/globalblacklist.conf`

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-2.png"/>

**COPY THE INCLUDE FILES FROM THE REPO**

- From your command line in Linux type

`sudo mkdir /etc/nginx/bots.d `

- copy the all the following files into that folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blockbots.conf -O /etc/nginx/bots.d/blockbots.conf`
`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/ddos.conf -O /etc/nginx/bots.d/ddos.conf`

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-3.png"/>

**WHITELIST ALL YOUR OWN DOMAIN NAMES AND IP ADDRESSES**

Whitelist all your own domain names and IP addresses. **Please note important changes**, this is now done using include files so that you do not have to keep reinserting your whitelisted domains and IP addresses every time you update.

- copy the whitelist-ips.conf file into that folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-ips.conf -O /etc/nginx/bots.d/whitelist-ips.conf`


- copy the whitelist-domains.conf file into the same folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-domains.conf -O /etc/nginx/bots.d/whitelist-domains.conf`


Use nano, vim or any other text editor to edit both whitelist-ips.conf and whitelist-domains.conf to include all your own domain names and IP addresses that you want to specifically whitelist from the blocker script. 
When pulling any future updates now your domains and IP whitelists will not be overwritten.

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-4.png"/>

**BLACKLIST USING YOUR OWN CUSTOM USER-AGENT BLACKLIST**

Copy the custom User-Agents blacklist file into your /etc/nginx/bots.d folder

- copy the blacklist-user-agents.conf file from the repository

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blacklist-user-agents.conf -O /etc/nginx/bots.d/blacklist-user-agents.conf`


Use nano, vim or any other text editor to edit (if needed) blacklist-user-agents.conf to include your own custom list of bad agents that are not included in the blocker like "omgilibot" which some people choose to block. 
When pulling any future updates now your custom User-Agents blacklist will not be overwritten.

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-5.png"/>

**BLACKLIST USING YOUR OWN CUSTOM BAD REFERRERS**

Copy the custom bad referrers blacklist file into your /etc/nginx/bots.d folder

- copy the custom-bad-referrers.conf file from the repository

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/custom-bad-referrers.conf -O /etc/nginx/bots.d/custom-bad-referrers.conf`

Use nano, vim or any other text editor to edit (if needed) custom-bad-referrers.conf to include your own custom list of bad referrer domains that are not included in the blocker. 
When pulling any future updates now your custom referrers list will not be overwritten.

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-6.png"/>

**BLACKLIST IPS AND IP RANGES USING YOUR OWN CUSTOM LIST**

Copy the custom IP blacklist file into your /etc/nginx/bots.d folder

- copy the blacklist-ips.conf file from the repository

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blacklist-ips.conf -O /etc/nginx/bots.d/blacklist-ips.conf`

Use nano, vim or any other text editor to edit (if needed) blacklist-ips.conf to include your own custom list of IP Addresses and IP Ranges that you wish to block.  
When pulling any future updates now your custom IP blacklist will not be overwritten.

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-7.png"/>

**DOWNLOAD CUSTOM BAD REFERRER WORDS INCLUDE FILE FOR CUSTOMIZED SCANNING OF BAD WORDS**

Copy the custom bad referrer words include file into your /etc/nginx/bots.d folder

- copy the bad-referrer-words.conf file from the repository

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/bad-referrer-words.conf -O /etc/nginx/bots.d/bad-referrer-words.conf`

Use nano, vim or any other text editor to edit the bad-referrer-words.conf file as you like. 
When pulling any future updates now your custom bad referrer words list will not be overwritten.


************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-8.png"/>

**INCLUDE IMPORTANT SETTINGS IN NGINX.CONF**
**Also see SAMPLE-nginx.conf file in the root of this repository**

- copy the botblocker-nginx-settings.conf file directly from the repo

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/botblocker-nginx-settings.conf -O /etc/nginx/conf.d/botblocker-nginx-settings.conf`

**What is included in this settings file above for nginx?**
The important settings file above adds the rate limiting functions and hash_bucket settings for nginx for you. Below is what the file contains, you cn add these manually to your nginx.conf file if you so please but the include file above will do it for you ad nginx loads any .conf file in /etc/conf.d (See STEP 6)

> server_names_hash_bucket_size 64;

> server_names_hash_max_size 4096;

> limit_req_zone $binary_remote_addr zone=flood:50m rate=90r/s;

> limit_conn_zone $binary_remote_addr zone=addr:50m;

**PLEASE NOTE:** The above rate limiting rules are for the DDOS filter, it may seem like high values to you but for wordpress sites with plugins and lots of images, it's not. This will not limit any real visitor to your Wordpress sites but it will immediately rate limit any aggressive bot. Remember that other bots and user agents are rate limited using a different rate limiting rule at the bottom of the globalblacklist.conf file.

The server_names_hash settings allows Nginx Server to load this very large list of domain names and IP addresses into memory. You can tweak these settings to your own requirements.


************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-9.png"/>
**VERY IMPORTANT**

**MAKE SURE** that your nginx.conf file contains the following include directive. If it's commented out make sure to uncomment it or none of this will work.

- `include /etc/nginx/conf.d/*;`


************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-10.png"/>
**VERY IMPORTANT**

**ADD INCLUDE FILES INTO A VHOST**

Open a site config file for Nginx (just one for now) and add the following lines.

##### VERY IMPORTANT NOTE: 

These includes MUST be added within a **server {}** block of a vhost otherwise you will get EMERG errors from Nginx.

- `include /etc/nginx/bots.d/blockbots.conf;`

- `include /etc/nginx/bots.d/ddos.conf;`

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-11b.png"/>

**TESTING YOUR NGINX CONFIGURATION**

`sudo nginx -t`

If you get no errors then you followed my instructions so now you can make the blocker go live with a simple.

`sudo service nginx reload`

The blocker is now active and working so now you can run some simple tests from another linux machine to make sure it's working.

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-12.png"/>

**TESTING**

Run the following commands one by one from a terminal on another linux machine against your own domain name. 
**substitute yourdomain.com in the examples below with your REAL domain name**

`curl -A "googlebot" http://yourdomain.com`

Should respond with 200 OK

`curl -A "80legs" http://yourdomain.com`

`curl -A "masscan" http://yourdomain.com`

Should respond with: curl: (52) Empty reply from server

`curl -I http://yourdomain.com -e http://100dollars-seo.com`

`curl -I http://yourdomain.com -e http://zx6.ru`

Should respond with: curl: (52) Empty reply from server

The Nginx Ultimate Bot Blocker is now WORKING and PROTECTING your web sites !!!

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-13.png"/>

**UPDATING THE NGINX BAD BOT BLOCKER** is now easy thanks to the automatic includes for whitelisting your own domain names.

Updating to the latest version is now as simple as:

`cd /etc/nginx/conf.d`

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf -O /etc/nginx/conf.d/globalblacklist.conf`

`sudo nginx -t`

`sudo service nginx reload` 

And you will be up to date with all your whitelisted domains included automatically for you now. 

************************************************
# AUTO UPDATING:

See the latest auto updater bash script at:

https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/update-ngxblocker

With great thanks to Stuart Cardall (https://github.com/itoffshore) for improving on it to be truly universal to other distro's.

Relax now and sleep better at night knowing your site is telling all those baddies they are FORBIDDEN !!!

************************************************
### PULL REQUESTS / CORRECTIONS / FALSE POSITIVES:

[![Log an Issue](https://img.shields.io/badge/LOG%20-%20an%20issue%20%F0%9F%9A%A6-blue.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/issues) or to contribute your own bad referers, bots or to make corrections to any incorrectly blocked bots or domains please fork a copy of this repository and send pull requests on the <a href="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/tree/master/_generator_lists">individual files located here</a> and then send a pull request (PR).

##### All Additions, Removals and Corrections will all be checked for accuracy before being merged into main blocker.

************************************************
### ISSUES:

[![Log an Issue](https://img.shields.io/badge/LOG%20-%20an%20issue%20%F0%9F%9A%A6-blue.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/issues) regarding incorrect listings or any other problems on the issues system and they will be investigated and removed if necessary. I responde very quickly to user problems and have helped countless users for days on end to get their bot blocker working. You could say I am mad (disputable) but I love helping people and do not ignore issues or people with problems getting this to work.

************************************************
# HAS YOUR WEB SITE BEEN HACKED?

[![Contact me for help](https://img.shields.io/badge/Contact%20-%20me%20for%20help%20%F0%9F%9A%91-blue.svg)](mailto:mitchellkrog@gmail.com) to help you clean up and secure your web site. 

************************************************
### SOME OTHER AWESOME FREE PROJECTS

- https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker
- https://github.com/mitchellkrogza/Badd-Boyz-Hosts
- https://github.com/mitchellkrogza/Ultimate.Hosts.Blacklist
- https://github.com/mitchellkrogza/Stop.Google.Analytics.Ghost.Spam.HOWTO
- https://github.com/mitchellkrogza/The-Big-List-of-Hacked-Malware-Web-Sites
- https://github.com/mitchellkrogza/fail2ban-useful-scripts
- https://github.com/mitchellkrogza/linux-server-administration-scripts
- https://github.com/mitchellkrogza/Travis-CI-Nginx-for-Testing-Nginx-Configuration
- https://github.com/mitchellkrogza/Travis-CI-for-Apache-For-Testing-Apache-and-PHP-Configurations
- https://github.com/mitchellkrogza/Fail2Ban-Blacklist-JAIL-for-Repeat-Offenders-with-Perma-Extended-Banning
- https://github.com/funilrys/PyFunceble
- https://github.com/funilrys/dead-hosts
- https://github.com/mitchellkrogza/The-Big-List-of-Hacked-Malware-Web-Sites
- https://github.com/mitchellkrogza/Suspicious.Snooping.Sniffing.Hacking.IP.Addresses
- https://github.com/mitchellkrogza/Fail2Ban.WebExploits

************************************************
### ALSO CHECKOUT THE NEW BIG LIST OF HACKED MALWARE & WORDPRESS WEB SITES

This repository contains a list of all web sites I come across that are hacked with malware. 
Most site owners are unaware their sites have been hacked and are being used to plant malware.

Check it out at: https://github.com/mitchellkrogza/The-Big-List-of-Hacked-Malware-Web-Sites

************************************************
### INTO PHOTOGRAPHY?

Come drop by and visit me at [mitchellkrog.com](https://mitchellkrog.com) or [Facebook](https://www.facebook.com/MitchellKrogPhotography) or Follow Me on Twitter <a href='https://twitter.com/MitchellKrog'><img src='https://img.shields.io/twitter/follow/MitchellKrog.svg?style=social&label=Follow' alt='Follow @MitchellKrog'></a>

************************************************
### ACKNOWLEDGMENTS & CONTRIBUTORS:

Many Thanks to those contributing to this project.

Many parts of the generator scripts and code running behind this project have been adapted from snippets from hundreds of sources. 
In fact it is so hard to mention everyone but here are a few key people whose little snippets of code have helped me introduce new features all the time. Show them some love and check out some of their projects too.

- Stuart Cardall - https://github.com/itoffshore (Install, Update and Setup Scripts & Alpine Linux Package Maintainer)
- Nissar Chababy - https://github.com/funilrys/funceble (Excellent script for checking ACTIVE, INACTIVE and EXPIRED Domain Names)
- Marius Voila https://github.com/mariusv
- Cătălin Mariș https://github.com/alrra
- deformhead https://github.com/deformhead
- bluedragonz https://github.com/bluedragonz
- Alexander https://github.com/shoonois
- Steven Black https://github.com/StevenBlack
- Fail2Ban - https://github.com/fail2ban
- Stevie-Ray Hartog https://github.com/Stevie-Ray
- Sir Athos from StackOverFlow - http://stackoverflow.com/users/2245910/sir-athos (help with Travis Build Tagging and Committing)
- StackOverflow - http://stackoverflow.com/ (bash scripts from hundreds of questions and answers)
- SuperUser - http://superuser.com/ (snippets from various questions and answers)

If you believe your name should be here, drop me a line.

************************************************
### Writing Code like this takes lots of time !!

Thousand of hours of programming and testing have gone into this project, show some love

[![Help me out with a mug of beer](https://img.shields.io/badge/Help%20-%20me%20out%20with%20a%20mug%20of%20%F0%9F%8D%BA-blue.svg)](https://paypal.me/mitchellkrog/) or [![Help me feed my cat](https://img.shields.io/badge/Help%20-%20me%20feed%20my%20hungry%20cat%20%F0%9F%98%B8-blue.svg)](https://paypal.me/mitchellkrog/)

<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/zuko.png"/>

************************************************
# MIT License

## Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
## https://github.com/mitchellkrogza

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
