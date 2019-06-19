# Fail2Ban Blacklist for Repeat Error 444 and 403 Offenders of Nginx (action.d)
#### also includes wp-login attack filter using [nginx-limit-req] - see lower down

************************************************
## Help Support This Project 

[<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/kofi4.png" alt="Buy me Coffee" width="300"/>](https://ko-fi.com/mitchellkrog)

************************************************
### Version: 1.1

# Add on for Nginx Ultimate Bad Bot, User-Agent and Spam Referrer Blocker

[![NGINX ULTIMATE BAD BOT BLOCKER](https://img.shields.io/badge/NGINX%20-%20ULTIMATE%20BAD%20BOT%20BLOCKER%20%E2%9B%94-blue.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker)

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
- Tested On: Fail2Ban 0.9.3 > 0.10.2
- Server: Ubuntu 16.04.2 / Ubuntu 18.04.2
- Firewall: IPTables
************************************************

## Dependancies: 

- requires nginxrepeatoffender.conf in /etc/fail2ban/filter.d folder
- requires nginxrepeatoffender.conf in /etc/fail2ban/action.d folder
- requires jail settings called [nginxrepeatoffender]
- requires nginx.repeatoffender file in /etc/fail2ban

Create With:

`sudo touch /etc/fail2ban/nginx.repeatoffender`

`chmod +x /etc/fail2ban/nginx.repeatoffender`

************************************************
## Drawbacks: 

Only works with IPTables

************************************************
:exclamation::exclamation::exclamation:
## Important Configuration Notes:

**You MUST have your file paths and default status for "enabled" declared by means of the recommended include in your [INCLUDES] section of your jail.conf or jail.local otherwise fail2ban will fail reloading when it cannot find the location `apache_access_log` or `nginx_access_log` you can also hard code log locations in your jail settings but this NOT a recommended or good practice. Your jail.local or jail.conf should have the includes as below.**

```
[INCLUDES]
before = paths-common.conf
enabled - false
```
or
```
[INCLUDES]
before = paths-debian.conf
enabled - false
```

**Please Note:**

Above we have the recommended default of "enabled = false" this is recommended good practice. 
It disables all jails until you enable each one manually. 

**To DEBUG Fail2Ban when it will not reload PLEASE follow the following commands in this exact order. Then post your error messages in a NEW ISSUE. ONLY post the last 3-4 lines where the error starts NOT the whole log message.**

`sudo service fail2ban stop`

`sudo fail2ban-client -vvv -x stop`

`sudo fail2ban-client -vvv -x start`

The 3rd step runs fail2ban in verbose client mode and will point you to the exact location where Fail2Ban stopped loading. Once you have this error message copy ONLY the last 3-4 lines and post them in a new ISSUE although if you read the message you shold quickly understand why you broke Fail2Ban and why it is not loading.

Once you have the error message or have fixed your error you just restart Fail2Ban as follows:

`sudo service fail2ban restart`

************************************************
## DOES NOT WORK - MY FAIL2BAN WON'T RESTART???

**Yes it does work**, if you followed the instructions that is. It works and has been tested on almost every version of Fail2Ban.
The most IMPORTANT steps of DEBUGGING Fail2Ban and why it fails reloading are posted just above this message. 
For your convenience I will post them again as they are extremely important steps for debugging Fail2Ban not only for this jail but any jail.

`sudo service fail2ban stop`

`sudo fail2ban-client -vvv -x stop`

`sudo fail2ban-client -vvv -x start`

************************************************
## Based on: 

The Recidive Jail from Fail2Ban

This custom filter and action for Fail2Ban will monitor your Nginx logs and perma-ban
any IP address that has generated far too many 444 or 403 errors over a 1 week period
and ban them for 1 day. This works like a charm as an add-on for my Nginx Bad
Bot Blocker which takes care of generating the 444 or 403 errors based on the extensive
list of Bad Referers, Bots, Scrapers and IP addresses that it covers. This provides short
block periods of one day which is enough to keep agressive bots from filling up your log files.
See - https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker for more info on the Nginx Bad Bot Blocker

This custom action requires a custom jail in your jail.local file for Fail2Ban

Your jail file would be configured as follows

```
[nginxrepeatoffender]
enabled = true
logpath = %(nginx_access_log)s
filter = nginxrepeatoffender
banaction = nginxrepeatoffender
bantime  = 86400   ; 1 day
findtime = 604800   ; 1 week
maxretry = 20
```

************************************************
# Blocking wp-login.php attacks on Wordpress Sites

See the included /filter.d/nginx-limit-req.conf jail and filter for detecting and blocking wp-login attacks
The original /filter.d/nginx-limit-req.conf file from Fail2Ban is included including a /filter.d/nginx-limit-req.local file with the settings you need to detect and block wp-logins.
An example of the jail settings for your jail.local file is included in the jail.local sample.
This works great at picking up wp-login attacks.
Be sure to add the rate limiting zone to your nginx.conf as per instructions in /filter.d/nginx-limit-req.local

************************************************
# HAS YOUR WEB SITE BEEN HACKED?

[![Contact me for help](https://img.shields.io/badge/Contact%20-%20me%20for%20help%20%F0%9F%9A%91-blue.svg)](mailto:mitchellkrog@gmail.com) to help you clean up and secure your web site. 

************************************************
### SOME OTHER AWESOME FREE PROJECTS

- https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker
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

## Help Support This Project 

[<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/kofi4.png" alt="Buy me Coffee" width="300"/>](https://ko-fi.com/mitchellkrog)

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
