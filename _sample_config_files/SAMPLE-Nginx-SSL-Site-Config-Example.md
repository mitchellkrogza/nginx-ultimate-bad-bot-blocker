<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/_logo_nginx_bad_bot_blocker.png" alt="Nginx Ultimate Bad Bot Spam Referrer Blocker - Nginx Block Bad Bots, Vulnerability Scanners, Malware and Adware, Malicious Sites, Spam Referrers, Bad Referrers, Spam Blocker with DDOS, Wordpress Theme Detector Blocking and Fail2Ban Jail for Repeat Offenders"/><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![DUB](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/LICENSE.md)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![GitHub release](https://img.shields.io/github/release/mitchellkrogza/nginx-ultimate-bad-bot-blocker.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/releases/latest)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![Build Status](https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker.svg?branch=master)](https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/><a href='https://twitter.com/ubuntu101za'><img src='https://img.shields.io/twitter/follow/ubuntu101za.svg?style=social&label=Follow' alt='Follow @ubuntu101za'></a>

# NGINX Sample SSL configuration file for the NGINX Ultimate Bad Bot Blocker using a Free SSL Certificate from Let's Encrypt

The sample NGINX configuration below is for an SSL site and includes the very important http (port 80) redirect to https (Port 443) which a lot of people tend to forget about. The configuration example below uses a Free SSL certificate from https://letsencrypt.org

Make sure to test and reload nginx when you make changes. `sudo nginx -t` and if no errors then `sudo service nginx reload`

************************************************
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
## To Test Bad Referers

Then you must test running the following from the command line of another unix machine.

`curl -I https://yourdomain.com -e http://100dollars-seo.com`

`curl -I https://yourdomain.com -e http://xxxrus.org`

`curl -I https://yourdomain.com -e https://100dollars-seo.com`

`curl -I https://yourdomain.com -e https://sexobzor.info`

`curl -I https://yourdomain.com -e ftp://sexobzor.info`

You will get an empty reply meaning the Nginx Bad Bot Blocker is working. You will also notice if a bad referer comes from http://, https:// or even ftp:// it is blocked due to the special regex in this blocker which ignores whether it comes from http://, https:// or even ftp:// it is detected and BLOCKED !!!

Then try the following commands against your http site

`curl -I http://yourdomain.com -e http://100dollars-seo.com`

`curl -I http://yourdomain.com -e http://xxxrus.org`

`curl -I http://yourdomain.com -e https://100dollars-seo.com`

`curl -I http://yourdomain.com -e https://sexobzor.info`

You should see the response give you a 301 redirect:

```
HTTP/1.1 301 Moved Permanently
Location: https://yourdomain.com/
```

This means it is redirecting all http traffic (port 80) to https (port 443). At this point most bad bots and bad referrers give up and will not even bother to follow the redirect. If they do however they will get blocked. 

**NOTE:**
I have overridden this behavior in the example below by also adding the include into the port80 site's configuration section before the Redirect conditions take effect. Which means bots and bad referers hitting your http site will get blocked and will not even be shown the redirect to your https site.

************************************************
## To Test Bad User Agents

To test further, install User-Agent Switcher for Chrome, set up a few bad bots like 80legs, masscan, AhrefsBot and switch to them while viewing your site in Chrome and you will see 403 Forbidden errors meaning the Nginx Bad Bot Blocker is working.

Or again using for those who love the command line. On another unix machine try some of these.

`curl -A "80Legs" https://yourdomain.com`

`curl -A "websucker" https://yourdomain.com`

`curl -A "masscan" https://yourdomain.com`

`curl -A "WeBsuCkEr" https://yourdomain.com`

`curl -A "WeB suCkEr" https://yourdomain.com`

`curl -A "Exabot" https://yourdomain.com`

You will get 403 forbidden responses on all of them meaning the Nginx Bad Bot Blocker is working 100%. You will also notice if a bot like websucker changes it's name to WeBsuCkEr it is detected regardless due to the wonderful case insensitive matching regex of this blocker. Test against any bot or referrer string in the bot blocker and you will always get a 403 forbidden. 

************************************************
## To Test Good User Agents

Try some of these from the command line of another unix machine and you will see that good bots specified in the Nginx Bad Bot blocker are granted access.

`curl -A "GoogleBot" https://yourdomain.com`

`curl -A "BingBot" https://yourdomain.com`

Now you can rest knowing your site is protected against over 4000 and growing bad bots and spam referrers and allowing all the good one's through. 

Enjoy it and what this will do for your web site.
 
************************************************
## Make sure to keep your /etc/conf.d/globalblacklist.conf file up to date 

New referrers and bots are added every other day. Each time you update **MAKE SURE** to copy your whitelist section of IP addresses into the new file. A set of generator scripts are coming soon which will ease this burden for you allowing you to pull daily from the GIT repo and compile the scripts on your server automatically including your whitelisted IP's each time. These generator scripts are coming soon so please be patient as they have to be thoroughly tested for public use before I release them. <a href="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/update-ngxblocker">Use the fabulous auto-update script here.</a>

(See at very bottom of this page for all the Cloudflare IP ranges you should be whitelisting if you are on Cloudflare)

************************************************
#EXAMPLE Nginx SSL site configuration file. (/etc/nginx/sites-available/yourdomain.com")

```
server {
	# SSL configuration
	listen 443 ssl http2;
	root /var/www/yourdomain.com;
	server_name yourdomain.com www.yourdomain.com;
	charset UTF-8;
	# Logging for the SSL version of our site
	access_log /var/log/nginx/yourdomain.com-access.log;
	error_log /var/log/nginx/yourdomain.com-error.log;

	# SSL Configuration
	# First include our certificates and chain of trust - Using Let's Encrypt Free SSL
	ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;
	ssl_trusted_certificate /etc/letsencrypt/live/yourdomain.com/chain.pem;
	# Diffie-Hellman parameter for DHE ciphersuites, recommended 2048 bits
	ssl_dhparam /etc/nginx/ssl/dhparam.pem;
	ssl_session_timeout 1d;
	ssl_session_cache shared:SSL:128m;
	ssl_session_tickets off;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
	# ciphers recommended by https://mozilla.github.io/server-side-tls/ssl-config-generator/
	ssl_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS';
	ssl_prefer_server_ciphers on;
	add_header Strict-Transport-Security "max-age=31536000; includeSubDomains";
	ssl_stapling on;
	ssl_stapling_verify on;

	# Include our X- Headers for Browser Cross-Sniffing
        add_header X-Frame-Options SAMEORIGIN;
        add_header X-Content-Type-Options nosniff;
        add_header X-XSS-Protection "1; mode=block";


	# ADD THE NGINX BAD BOT BLOCKER HERE (Please read full setup instructions)
	include /etc/nginx/bots.d/blockbots.conf;
	include /etc/nginx/bots.d/ddos.conf;

	# Include Any Custom Configurations and Location Directives Here

# END OF SSL HOST CONFIG - CLOSING BRACE BELOW THIS LINE
}
server {
    # NOW WE REDIRECT ALL PORT 80 TRAFFIC TO PORT 443
	listen 80;
	server_name yourdomain.com www.yourdomain.com;
	# Block Bad Bots even before they even get redirected
	include /etc/nginx/bots.d/blockbots.conf;
	include /etc/nginx/bots.d/ddos.conf;
      return 301 https://yourdomain.com$request_uri;
    # HAVE SEPARATE LOGGING FOR PORT 80 (otherwise use same log location as SSL site)
	access_log /var/log/nginx/yourdomain.com-80-access.log;
	error_log /var/log/nginx/yourdomain.com-80-error.log;
# END OF HTTP PORT 80 HOST CONFIG - CLOSING BRACE BELOW THIS LINE
}
```

************************************************
## CHECK FOR FREE IF YOUR WEB SITE IS COMPROMISED OR BLACKLISTED

<a href="https://www.gravityscan.com/" target="_blank"><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/gravity-scan-by-wordfence.png" alt="Check if your web site is blacklisted, hacked or compromised using the awesome Free GravityScan tool"/></a>

************************************************
# HAS YOUR WEB SITE BEEN HACKED?

[![Contact me for help](https://img.shields.io/badge/Contact%20-%20me%20for%20help%20%F0%9F%9A%91-blue.svg)](mailto:mitchellkrog@gmail.com) to help you clean up and secure your web site. 

************************************************
### SOME OTHER AWESOME FREE PROJECTS

- https://github.com/mitchellkrogza/apache-ultimate-bad-bot-blocker
- https://github.com/mitchellkrogza/Badd-Boyz-Hosts
- https://github.com/mitchellkrogza/Stop.Google.Analytics.Ghost.Spam.HOWTO
- https://github.com/mitchellkrogza/The-Big-List-of-Hacked-Malware-Web-Sites
- https://github.com/mitchellkrogza/fail2ban-useful-scripts
- https://github.com/mitchellkrogza/linux-server-administration-scripts
- https://github.com/mitchellkrogza/Travis-CI-Nginx-for-Testing-Nginx-Configuration
- https://github.com/mitchellkrogza/Travis-CI-for-Apache-For-Testing-Apache-and-PHP-Configurations
- https://github.com/mitchellkrogza/Fail2Ban-Blacklist-JAIL-for-Repeat-Offenders-with-Perma-Extended-Banning
- https://github.com/funilrys/funceble

************************************************
### ALSO CHECKOUT THE NEW BIG LIST OF HACKED MALWARE & WORDPRESS WEB SITES

This repository contains a list of all web sites I come across that are hacked with malware. 
Most site owners are unaware their sites have been hacked and are being used to plant malware.

Check it out at: https://github.com/mitchellkrogza/The-Big-List-of-Hacked-Malware-Web-Sites

************************************************
### INTO PHOTOGRAPHY?

Come drop by and visit me at https://mitchellkrog.com or <a href='https://twitter.com/MitchellKrog'><img src='https://img.shields.io/twitter/follow/MitchellKrog.svg?style=social&label=Follow' alt='Follow @MitchellKrog'></a>

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
