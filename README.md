### If this helps you [You can buy me a beer](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BKF9XT6WHATLG):beer: or send some cheese for my mouse [![gitcheese.com](https://api.gitcheese.com/v1/projects/92bf5669-7d2c-447d-baa4-216ac9e720a6/badges)](https://www.gitcheese.com/app/#/projects/92bf5669-7d2c-447d-baa4-216ac9e720a6/pledges/create)

<table style="width:100%;margin:0;">
  <tr>
    <td align="left"><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/nginx-ultimate-bad-bot-referrer-blocker.png" alt="Nginx Ultimate Bad Bot Spam Referrer Blocker - Nginx Block Bad Bots, Vulnerability Scanners, Malware and Adware, Malicious Sites, Spam Referrers, Bad Referrers, Spam Blocker with DDOS, Wordpress Theme Detector Blocking and Fail2Ban Jail for Repeat Offenders"/></td>
    <td align="right"><a href="https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker" target="_blank"><img src="https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker.svg?branch=master"/></a></td>
  </tr>
</table>

# Nginx Bad Bot and User-Agent Blocker, Spam Referrer Blocker, Anti DDOS, Bad IP Blocker and Wordpress Theme Detector Blocker
##### The Ultimate Nginx Bad Bot, User-Agent, Spam Referrer Blocker, Adware, Malware and Ransomware Blocker, Clickjacking Blocker, Click Re-Directing Blocker and Bad IP Blocker with Anti DDOS System, Nginx Rate Limiting and Wordpress Theme Detector Blocking

### Version 2.2017.04

##### Created by: https://github.com/mitchellkrogza
##### Copyright Mitchell Krog <mitchellkrog@gmail.com>

- **[Configuration instructions are here](#configuration-of-the-nginx-bad-bot-blocker)**
- For Nginx Web Server - https://www.nginx.com/
- See sample Nginx Vhost config at: (Please read full instructions too) https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/NGINX-SSL-Site-Config-Example.md
- Includes the creation of a google-exclude.txt file for creating filters / segments in Google Analytics (see instructions lower down)
- Includes the creation of a google-disavow.txt file for use in Google Webmaster Tools (see instructions lower down)

### WHY BLOCK BAD BOTS ?

#####Bad bots are:

-    Bad Referrers 
-    Bad User-Agent Strings
-    Spam Referrers
-    Spam Bots and Bad Bots
-    Sites Linked to Lucrative Malware, Adware and Ransomware Clickjacking Campaigns
-    Vulnerability scanners
-    Gambling and Porn Web Sites
-    E-mail harvesters
-    Content scrapers
-    Aggressive bots that scrape content
-    Image Hotlinking Sites and Image Thieves
-    Bots or Servers linked to viruses or malware
-    Government surveillance bots
-    Botnet Attack Networks (Mirai)
-    Known Wordpress Theme Detectors (Updated Regularly)
-    SEO companies that your competitors use to try improve their SEO
-    Link Research and Backlink Testing Tools
-    Stopping Google Analytics Ghost Spam
-    Browser Adware and Malware (Yontoo etc)

(4520 bad referers, spam referrers, user-agents, bad bots, bad IP's, porn, gambling and clickjacking sites, seo companies and counting)

###To contribute your own bad referers 
please add them into the https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/Pull%20Requests%20Here%20Please/badreferers.list file and then send a Pull Request (PR). 

#### **All additions will be checked for accuracy before being merged.**

### Issues:
Log any issues regarding incorrect listings or any other problems on the issues system and they will be investigated and removed if necessary. I responde very quickly to user problems and have helped countless users for days on end to get their bot blocker working. You could say I am mad (disputable) but I love helping people and do not ignore issues or people with problems getting this to work.

### If this helps you why not [buy me a beer](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BKF9XT6WHATLG):beer: or send some cheese for my mouse [![gitcheese.com](https://api.gitcheese.com/v1/projects/92bf5669-7d2c-447d-baa4-216ac9e720a6/badges)](https://www.gitcheese.com/app/#/projects/92bf5669-7d2c-447d-baa4-216ac9e720a6/pledges/create)

# Welcome to the Ultimate Nginx Bad Bot, User-Agent, Spam Referrer Blocker, Adware, Malware and Ransomware Blocker, Click-Jacking Blocker, Click-Redirect Blocker and Bad IP Blocker with Anti DDOS System, Nginx Rate Limiting and Wordpress Theme Detector Blocking.

Bots attempt to make themselves look like other software or web sites by disguising their user agent.  Their user agent names may look harmless, perfectly legitimate even. 

For example, "^Java" but according to Project Honeypot, it's actually one of the most dangerous BUT a lot of legitimate bots out there have "Java" in their user agent string so the approach taken by many to block "Java" is not only ignorant but also blocking out very legitimate crawlers including some of Google's and Bing's and makes it very clear to me that those people writing bot blocking scripts seldom ever test them. 

Spam Referrers and Spam Domain Names use very clever techniques to hop off your sites running very lucrative click-jacking and click-redirecting campaigns which serve ads to unsuspecting people browsing the web or even planting malware, adware or ransomware into their browsers which then become part of their lucrative network of bots. 

This Bot Blocker includes hundreds of domain names and IP addresses that most people will not even see in their Nginx logs. This comes as a result of all my sites running of SSL and using Content-Security-Policy (CSP) which blocks things before they even get to Nginx and I have picked up and continue to pick up some of the worst domains and bots out there. 

A massive amount of Porn, Gambling and Fake News web sites are also blocked in this blocker script which also grows at a rapid pace.

Unfortunately most bot blocker scripts out there are simply copy and pasted from other people's scripts and made  to look like their own work. This one  was inspired by the one created by https://github.com/mariusv and I  contributed to that project but went off into a totally new layout, cleaned it up big time and started from scratch. It is now a completely independent project. It's clean, it works and has been thoroughly tested.

### THE BASICS

This nginx bad bot bot blocker list is designed to be a global Nginx include file and uses the Nginx map $http_user_agent, map $http_referer and geo $validate_client directives.

This way the .conf file is loaded once into memory by Nginx and is available to all web 
sites that you operate. You simply need to use an Include statement in an Nginx vhost conf file.

My methods uses **no complex regex** other than the Name of the Bot. Nginx case matching will do the rest.  You can use Regex if you like but it's NOT needed and I proved it by testing with the Chrome extension User-Agent Switcher for Chrome. (handy util and a must for everyone to test these kinds of blocking scripts)

- The user agent "Aboundex" is found without using "~*Aboundex" ... which means a case insensitive match and is much simpler for anyone to maintain than other lists using complicated and messy Regex patterns.

- If we have a rule, like "~*Image\ Stripper" and a bot decides to change its User-Agent string to "NOT Image Stripper I Promise" he is picked up regardless and blocked immediately. 

I only capitalise bot names in my list for ease of reading and maintenance, remember its 
not case-sensitive so will catch any combination like "Bot" "bOt" and "bOT".

For those of you who SUCK with Regex my Nginx Bad Bot Blocker is your saviour !!!

### IT'S CENTRALISED:

The beauty of this is that it is one central file used by all your web sites.
This means there is only place to make amendments ie. adding new bots that you
discover in your log files. Any changes are applied immediately to all sites after
a simple "sudo service nginx reload". But of course always do a sudo nginx -t to test
any config changes before you reload.

### IT IS TINY AND LIGHTWEIGHT

The file is tiny in size. At the time of this writing and the first public commit of this
the file size including all the commenting "which nginx ignores" currently at **a mere 135 kb in size** and already containing over 4500 bad domains and IP addresses. It is so lightweight that Nginx does not even know it's there. It already contains thousands of entries - total updated at the top of this README. 

### IT IS ACCURATE AND IS FALSE POSITIVE PROOF

Unlike many other bad bot blockers out there for Nginx and Apache where people simply copy and paste lists from others, this list has been built from the ground up and tested thoroughly and I mean thoroughly for now over 10 months. It comes from actual server logs that are monitored daily and there are at least 3-10 new additions to this file almost daily.

It has also been throughly tested for false positives using months of constant and regular testing and monitoring of log files. 

All web sites listed in the bad referers are checked one by one before they are even added. Simply copying  anything that look suspicious in your log file and adding it to a blocker like this without actually seeing  what it is first .... well it's foolish to say the least.

### DROP THEM AND THAT'S IT

Nginx has a lovely error called 444 which just literally drops the connection. All these rules issue a 444 response so if a rule matches, the requesting IP simply get's no response and it would appear that your  server does not exist to them or appears to be offline. 

A test with curl using one of the test command line's documented in the /conf.d/globalblacklist.conf file will give a simple "curl: (52) Empty reply from server" and that's the reply the bad referrers and bots get.

### RATE LIMITING FUNCTIONALITY BUILT IN

For bot's or spiders that you still want to allow but want to limit their visitation rate, you can use the  built in rate limiting functions I have included. The file is extensively commented throughout so you should figure it out otherwise simply message me if you are having problems. 


#CONFIGURATION OF THE NGINX BAD BOT BLOCKER:
### PLEASE READ CONFIGURATION INSTRUCTIONS BELOW THOROUGHLY

##Step 1:

**COPY THE GLOBALBLACKLIST.CONF FILE FROM THE REPO**

Copy the contents of **/conf.d/globalblacklist.conf** into your /etc/nginx/conf.d folder. 

`cd /etc/nginx/conf.d`

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf`

##Step 2: 

**COPY THE INCLUDE FILES FROM THE REPO**

- From your command line in Linux type

`sudo mkdir /etc/nginx/bots.d `

`cd /etc/nginx/bots.d`

- copy the blockbots.conf file into that folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blockbots.conf`


- copy the ddos.conf file into the same folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/ddos.conf`

##Step 3:

**WHITELIST ALL YOUR OWN DOMAIN NAMES AND IP ADDRESSES**

Whitelist all your own domain names and IP addresses. **Please note important changes**, this is now done using include files so that you do not have to keep reinserting your whitelisted domains and IP addresses every time you update.

`cd /etc/nginx/bots.d`

- copy the whitelist-ips.conf file into that folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-ips.conf`


- copy the whitelist-domains.conf file into the same folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-domains.conf`

Use nano, vim or any other text editor to edit both whitelist-ips.conf and whitelist-domains.conf to include all your own domain names and IP addresses that you want to specifically whitelist from the blocker script. 

When pulling any future updates now you can simply pull the latest globalblacklist.conf file and it will automatically include your whitelisted domains and IP addresses.


##Step 4:

**INCLUDE IMPORTANT SETTINGS IN NGINX.CONF**

- From your linux command line type

- `sudo nano /etc/nginx/nginx.conf`

#####Add the following settings and rate limiting zones near the top of your nginx.conf file. This is both for the Anti DDOS rate limiting filter and for allowing Nginx to load this very large set of domain names into memory. 
**see SAMPLE-nginx.conf file in the root of this repository**

- `server_names_hash_bucket_size 64;`

- `server_names_hash_max_size 4096;`

- `limit_req_zone $binary_remote_addr zone=flood:50m rate=90r/s;`

- `limit_conn_zone $binary_remote_addr zone=addr:50m;`

**Make sure** that your nginx.conf file contains the following include directive. If it's commented out make sure to uncomment it.

- `include /etc/nginx/conf.d/*`

**PLEASE NOTE:** The above rate limiting rules are for the DDOS filter, it may seem like high values to you but for wordpress sites with plugins and lots of images, it's not. This will not limit any real visitor to your Wordpress sites but it will immediately rate limit any aggressive bot. Remember that other bots and user agents are rate limited using a different rate limiting rule at the bottom of the globalblacklist.conf file.

The server_names_hash settings allows Nginx Server to load this very large list of domain names and IP addresses into memory.

##Step 5:

**ADD INCLUDE FILES INTO A VHOST**

Open a site config file for Nginx (just one for now) and add the following lines.
##### VERY IMPORTANT: these includes MUST be added within a server {} block otherwise you will get EMERG errors from Nginx.

- `include /etc/nginx/bots.d/blockbots.conf;`

- `include /etc/nginx/bots.d/ddos.conf;`

##Step 6:

**TESTING YOUR NGINX CONFIGURATION**

`sudo nginx -t`

If you get no errors then you followed my instructions so now you can make the blocker go live with a simple.

`sudo service nginx reload`

The blocker is now active and working so now you can run some simple tests from another linux machine to make sure it's working.

##Step 7:

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

##Step 6:

**UPDATING THE NGINX BAD BOT BLOCKER** is now easy thanks to the automatic includes for whitelisting your own domain names.

Updating to the latest version is now as simple as:

`cd /etc/nginx/conf.d`

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf`

`sudo nginx -t`

`sudo service nginx reload` 

And you will be up to date with all your whitelisted domains included automatically for you now. 

Relax now and sleep better at night knowing your site is telling all those baddies FORBIDDEN !!!


## FEATURES OF THE NGINX BAD BOT BLOCKER:

- Extensive Lists of Bad and Known Bad Bots and Scrapers (updated almost daily)
- Blocking of Spam Referrer Domains and Web Sites
- Blocking of SEO data collection companies like Semalt.com, Builtwith.com, WooRank.com and many others (updated regularly)
- Blocking of clickjacking Sites linked to Adware, Malware and Ransomware
- Blocking of Porn and Gambling Web Sites who use Lucrative Ways to Earn Money through Serving Ads by hopping off your domain names and web sites.
- Blocking of Bad Domains and IP's that you cannot even see in your Nginx Logs. Thanks to the Content Security Policy (CSP) on all my SSL sites I can see things trying to pull resources off my sites before they even get to Nginx and get blocked by the CSP.
- Anti DDOS Filter and Rate Limiting of Agressive Bots
- Alphabetically ordered for easier maintenance (Pull Requests Welcomed)
- Commented sections of certain important bots to be sure of before blocking
- Includes the IP range of Cyveillance who are known to ignore robots.txt rules
  and snoop around all over the Internet.
- Whitelisting of Google, Bing and Cloudflare IP Ranges
- Whitelisting of your own IP Ranges that you want to avoid blocking by mistake.
- Ability to add other IP ranges and IP blocks that you want to block out.
- If its out there and it's bad it's already in here and BLOCKED !!

## WARNING:

- Please understand why you are using this before you even use this.
- Please do not simply copy and paste without understanding what this is doing.
- Do not become a copy and paste Linux "Guru", learn things properly before you use them and always test everything you do one step at a time.
 
## ANOTHER WARNING:
  **Make sure to add all your own IP addresses** the white list section near the bottom of the globalblacklist.conf file !!!!

## MONITOR WHAT YOU ARE DOING:

**MAKE SURE to monitor your web site logs** after implementing this. I suggest you first load this into one site and monitor it for any possible false positives before putting this into production on all your web sites.

Do not sit like an ostrich with your head in the sand, being a responsible server operator and web site owner means you must monitor your logs frequently. A reason many of you ended up here in the first place because you saw nasty looking stuff in your Nginx log files.
 
Also monitor your logs daily for new bad referers and user-agent strings that you want to block. Your best source of adding to this list is your own server logs, not mine.
 
Feel free to contribute bad referers from your own logs to this project by sending a Pull Request (PR). You can however rely on this list to keep out 99% of the baddies out there.
 
## HOW TO MONITOR YOUR LOGS DAILY (The Easy Way):

**With great thanks and appreciation to**
https://blog.nexcess.net/2011/01/21/one-liners-for-apache-log-files/

To monitor your top referer's for a web site's log file's on a daily basis use the following simple cron jobs which will email you a list of top referer's / user agents every morning from a particular web site's log files. This is an example for just one cron job for one site. Set up multiple one's for each one you want to monitor. Here is a cron that runs at 8am every morning and emails me the stripped down log of referers. When I say stripped down, the domain of the site and other referers like Google and Bing are stripped from the results. Of course you must change the log file name, domain name and your email address in the examples below. The second cron for collecting User agents does not do any stripping out of any referers but you can add that functionality if you like copying the awk statement !~ from the first example.

##### Cron for Monitoring Daily Referers on Nginx

`00 08 * * * tail -10000 /var/log/nginx/mydomain-access.log | awk '$11 !~ /google|bing|yahoo|yandex|mywebsite.com/' | awk '{print $11}' | tr -d '"' | sort | uniq -c | sort -rn | head -1000 | mail - s "Top 1000 Referers for Mydomain.com" me@mydomain.com`

##### Cron for Monitoring Daily User Agents on Nginx

`00 08 * * * tail -50000 /var/log/nginx/mydomain-access.log | awk '{print $12}' | tr -d '"' | sort | uniq -c | sort -rn | head -1000 | mail -s "Top 1000 Agents for Mydomain.com" me@mydomain.com`

##Stopping Google Analytics 'ghost' spam

Simply using the Nginx blocker does not stop Google Analytics ghost referral spam 
because they are hitting Analytics directly and not always necessarily touching your website. 

You should use regex filters in Analytics to prevent ghost referral spam.
For this a simple google-exclude.txt file has been created for you and it is updated at the same time when the Nginx Blocker is updated.

##To stop Ghost Spam on On Analytics
Navigate to your Google Analytics Admin panel and add a Segment. (New Segment > Advanced > Conditions)

This will need to be done on each and every site where you want this filter to be in effect. 

Google has a stupid limit on the length of the regex so you need to break it up into multiple exclude filters 


| Filter          | Session       | Include                                  |
| :-------------: |:-------------:|:----------------------------------------:|
| Hostname        | matches regex | ```yourwebsite\.com|www\.yourwebsite\.com``` |

| Filter          | Session       | Exclude                                                       |
| :-------------: |:-------------:|:-------------------------------------------------------------:|
| Hostname        | matches regex | Copy the entire contents from [google-exclude.txt](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/google-exclude.txt) to this field |

#Or Even Better Check Out RefererSpamBlocker

Rather check out the awesome [Referer Spam Blocker](https://referrerspamblocker.com)
for Google Analytics which uses a collaborated source of spam domains and automatically adds all the filters to your Analytics sites for you in 2 easy clicks and it is FREE.

##Blocking Spam Domains Using Google Webmaster Tools

I have added the creation of a Google Disavow text file called google-disavow.txt. This file can be used in Google's Webmaster Tools to block all these domains out as spammy or bad links. Use with caution.

## Blocking Agressive Bots at Firewall Level Using Fail2Ban

I have added a custom Fail2Ban filter and action that I have written which monitors your Nginx logs for bots that generate a large number of 444 errors. This custom jail for Fail2Ban will scan logs over a 1 week period and ban the offender for 24 hours.
It helps a great deal in keeping out some repeat offenders and preventing them from filling up your log files with 444 errors.
See the Fail2Ban folder for instructions on configuring this great add on for the Nginx Bad Bot Blocker.

## Blocking Bad Bots and User-Agents Strings for those who cannot use this full blocker?
Lots of people are at the peril of their hosting company and do not have root access to the server running behind their web site. If this is your situation check out the automatically generated robots.txt file which will help you to some degree to keep a lot of Bad Bots and User-Agents out of your sites.

## Blocking Spam Referrers Strings for those who cannot use this full blocker?
Lots of people are at the peril of their hosting company and do not have root access to the server running behind their web site. If this is your situation check out the automatically generated .htaccess versions of the Spam Referrer Blocker which can be found in this repository https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker/tree/master/.htaccess this .htaccess method (FOR APACHE SITES ONLY) will help you to keep all the Spam Referrers in this blocker out of your site. This is mentioned here as a lot of people using CPanel systems think they are sitting behind an Nginx server but in reality are actually running on an Apache Server sitting behind an Nginx Proxy Server. .htaccess does not work on Nginx sites.

# IT FORKING WORKS !!!
## Just Enjoy now what the Nginx Bad Bot Blocker Can Do For You and Your Web Sites.

### If this helped you why not [buy me a beer](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BKF9XT6WHATLG):beer: or send some cheese for my mouse [![gitcheese.com](https://api.gitcheese.com/v1/projects/92bf5669-7d2c-447d-baa4-216ac9e720a6/badges)](https://www.gitcheese.com/app/#/projects/92bf5669-7d2c-447d-baa4-216ac9e720a6/pledges/create)

#MIT License

##Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
##https://github.com/mitchellkrogza

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

##### Some other free projects

- https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker
- https://github.com/mitchellkrogza/Fail2Ban-Blacklist-JAIL-for-Repeat-Offenders-with-Perma-Extended-Banning
- https://github.com/mitchellkrogza/fail2ban-useful-scripts
- https://github.com/mariusv/nginx-badbot-blocker
