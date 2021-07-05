<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/_logo_nginx_bad_bot_blocker.png" alt="Nginx Ultimate Bad Bot Spam Referrer Blocker - Nginx Block Bad Bots, Vulnerability Scanners, Malware and Adware, Malicious Sites, Spam Referrers, Bad Referrers, Spam Blocker with DDOS, Wordpress Theme Detector Blocking and Fail2Ban Jail for Repeat Offenders"/><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![DUB](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/LICENSE.md)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![GitHub release](https://img.shields.io/github/release/mitchellkrogza/nginx-ultimate-bad-bot-blocker.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/releases/latest)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![Build Status](https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker.svg?branch=master)](https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/><a href='https://twitter.com/ubuntu101za'><img src='https://img.shields.io/twitter/follow/ubuntu101za.svg?style=social&label=Follow' alt='Follow @ubuntu101za'></a>

# EASY AUTO CONFIGURATION INSTRUCTIONS FOR THE NGINX BAD BOT BLOCKER:
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
## Please follow the instructions below step by step :exclamation:

- This is our new preferred method of installation which is now done through a set of shell scripts contributed to this repo and maintained by Stuart Cardall @itoffshore who is one of the Alpine Linux package maintainers. 

- The instructions below are for a quick and painfree installation process which downloads all required files for the blocker and the scripts include adding the required includes to your nginx.conf and nginx .vhost files. The setup script assumes your vhost config files are located in /etc/nginx/sites-available/ and each vhost config file ends with a file extension of .vhost

- For manual installation instructions please see - Please see: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/MANUAL-CONFIGURATION.md

- setup-ngxblocker, install-ngxblocker and update-ngxblocker can all be configured with custom installation / update locations from the command line. **(See Step 11 of the instructions to show you how use these scripts and non-standard Nginx locations)**

- Run any of the setup, install or update scripts with --help or -h to view options.
************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-1.png"/>

Download install-ngxblocker to your /usr/local/sbin/directory and make the script executable.

```
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O /usr/local/sbin/install-ngxblocker
sudo chmod +x /usr/local/sbin/install-ngxblocker
```

If your Linux distribution does not have wget you can replace the wget command above using curl as follows:

```
curl -sL https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -o /usr/local/sbin/install-ngxblocker
```

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-2.png"/>

Now run the install-ngxblocker script in DRY-MODE which will show you what changes it will make and what files it will download for you. This is only a DRY-RUN so no changes are being made yet. 

The install-ngxblocker downloads all required files including the setup and update scripts.

```
cd /usr/local/sbin
sudo ./install-ngxblocker
```

This will show you output as follows of the changes that will be made 
**(NOTE: this is only a DRY-RUN no changes have been made)**

```
Checking url: https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/include_filelist.txt

** Dry Run ** | not updating files | run  as 'install-ngxblocker -x' to install files.

Creating directory: /etc/nginx/bots.d

REPO = https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master

Downloading [FROM]=>  [REPO]/conf.d/globalblacklist.conf            [TO]=>  /etc/nginx/conf.d/globalblacklist.conf
Downloading [FROM]=>  [REPO]/conf.d/botblocker-nginx-settings.conf  [TO]=>  /etc/nginx/conf.d/botblocker-nginx-settings.conf

REPO = https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master

Downloading [FROM]=>  [REPO]/bots.d/blockbots.conf              [TO]=>  /etc/nginx/bots.d/blockbots.conf
Downloading [FROM]=>  [REPO]/bots.d/ddos.conf                   [TO]=>  /etc/nginx/bots.d/ddos.conf
Downloading [FROM]=>  [REPO]/bots.d/whitelist-ips.conf          [TO]=>  /etc/nginx/bots.d/whitelist-ips.conf
Downloading [FROM]=>  [REPO]/bots.d/whitelist-domains.conf      [TO]=>  /etc/nginx/bots.d/whitelist-domains.conf
Downloading [FROM]=>  [REPO]/bots.d/blacklist-user-agents.conf  [TO]=>  /etc/nginx/bots.d/blacklist-user-agents.conf
Downloading [FROM]=>  [REPO]/bots.d/blacklist-ips.conf          [TO]=>  /etc/nginx/bots.d/blacklist-ips.conf
Downloading [FROM]=>  [REPO]/bots.d/bad-referrer-words.conf     [TO]=>  /etc/nginx/bots.d/bad-referrer-words.conf
Downloading [FROM]=>  [REPO]/bots.d/custom-bad-referrers.conf   [TO]=>  /etc/nginx/bots.d/custom-bad-referrers.conf

REPO = https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master

Downloading [FROM]=>  [REPO]/setup-ngxblocker      [TO]=>  /usr/local/sbin/setup-ngxblocker
Downloading [FROM]=>  [REPO]/update-ngxblocker     [TO]=>  /usr/local/sbin/update-ngxblocker
```

**setup-ngxblocker, install-ngxblocker and update-ngxblocker can all be configured with custom installation / update locations from the command line.** 

**Run any of the setup, install or update scripts with --help or -h to view options.**

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-3.png"/>

Now run the install script with the -x parameter to download all the necessary files from the repository:

```
cd /usr/local/sbin/
sudo ./install-ngxblocker -x
```

This will give you the following output:

```
Checking url: https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/include_filelist.txt

Creating directory: /etc/nginx/bots.d

REPO = https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master

Downloading [FROM]=>  [REPO]/conf.d/globalblacklist.conf            [TO]=>  /etc/nginx/conf.d/globalblacklist.conf...OK
Downloading [FROM]=>  [REPO]/conf.d/botblocker-nginx-settings.conf  [TO]=>  /etc/nginx/conf.d/botblocker-nginx-settings.conf...OK

REPO = https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master

Downloading [FROM]=>  [REPO]/bots.d/blockbots.conf              [TO]=>  /etc/nginx/bots.d/blockbots.conf...OK
Downloading [FROM]=>  [REPO]/bots.d/ddos.conf                   [TO]=>  /etc/nginx/bots.d/ddos.conf...OK
Downloading [FROM]=>  [REPO]/bots.d/whitelist-ips.conf          [TO]=>  /etc/nginx/bots.d/whitelist-ips.conf...OK
Downloading [FROM]=>  [REPO]/bots.d/whitelist-domains.conf      [TO]=>  /etc/nginx/bots.d/whitelist-domains.conf...OK
Downloading [FROM]=>  [REPO]/bots.d/blacklist-user-agents.conf  [TO]=>  /etc/nginx/bots.d/blacklist-user-agents.conf...OK
Downloading [FROM]=>  [REPO]/bots.d/blacklist-ips.conf          [TO]=>  /etc/nginx/bots.d/blacklist-ips.conf...OK
Downloading [FROM]=>  [REPO]/bots.d/bad-referrer-words.conf     [TO]=>  /etc/nginx/bots.d/bad-referrer-words.conf...OK
Downloading [FROM]=>  [REPO]/bots.d/custom-bad-referrers.conf   [TO]=>  /etc/nginx/bots.d/custom-bad-referrers.conf...OK

REPO = https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master

Downloading [FROM]=>  [REPO]/setup-ngxblocker      [TO]=>  /usr/local/sbin/setup-ngxblocker...OK
Downloading [FROM]=>  [REPO]/update-ngxblocker     [TO]=>  /usr/local/sbin/update-ngxblocker...OK
```

All the required files have now been downloaded to the correct folders on Nginx for you direct from the repository.

**MAKE SURE you set your setup and update scripts to be executable by running the following two commands. This is important before continuing with Step 4 and onwards.**

```
sudo chmod +x /usr/local/sbin/setup-ngxblocker
sudo chmod +x /usr/local/sbin/update-ngxblocker
```

**setup-ngxblocker, install-ngxblocker and update-ngxblocker can all be configured with custom installation / update locations from the command line.** 

**Run any of the setup, install or update scripts with --help or -h to view options.**

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-4.png"/>

Now run the setup-ngxblocker script in DRY-MODE which will show you what changes it will make and what files it will download for you. This is only a DRY-RUN so no changes are being made yet.

```
cd /usr/local/sbin/
sudo ./setup-ngxblocker
```

This will give you output as follows (this output below assumes your nginx.conf file already has the default include of /etc/nginx/conf.d/*)
All Nginx installations I know of have this default include in the nginx.conf file distributed with all versions.

```
Checking url: https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/include_filelist.txt

** Dry Run ** | not updating files | run  as 'setup-ngxblocker -x' to setup files.

INFO:      /etc/nginx/conf.d/* detected               => /etc/nginx/nginx.conf
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/mydomain2.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/mydomain2.com.vhost
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/mydomain1.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/mydomain1.com.vhost

Whitelisting ip:  x.x.x.x  => /etc/nginx/bots.d/whitelist-ips.conf
```

This script also whitelists your IP in the whitelist-ips.conf file for you. 
Further IP's or IP ranges can be added to your customizable whitelits-ips.conf file located in /etc/nginx/bots.d/whitelist-ips.conf.

**setup-ngxblocker, install-ngxblocker and update-ngxblocker can all be configured with custom installation / update locations from the command line.** 

**Run any of the setup, install or update scripts with --help or -h to view options.**


************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-5.png"/>

Now run the setup script with the -x parameter to make all the necessary changes to your nginx.conf (if required) and also to add the required includes into all your vhost files. 

This setup-ngxblocker script assumes that all your vhost files located in /etc/nginx/sites-available end in an extension .vhost. It is good practice to make all your vhost config files end with a .vhost extension but if you prefer to stick what you already have eg .conf you can simply modify run setup-ngxblocker using the `-e` parameter to specify the extension you use for your vhost files.

For instance if your vhost files end in .conf you will change this execute setup-ngxblocker with an additional command line parameter as follows:

`sudo ./setup-ngxblocker -x -e conf`

So now let's run the setup script and let it make all the changes we need to make the Bot Blocker active on all your sites.

```
cd /usr/local/sbin/
sudo ./setup-ngxblocker -x
```

You will see output as follows:

```
Checking url: https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/include_filelist.txt

INFO:      /etc/nginx/conf.d/* detected               => /etc/nginx/nginx.conf
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/mydomain2.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/mydomain2.com.vhost
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/mydomain1.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/mydomain1.com.vhost

Whitelisting ip:  x.x.x.x  => /etc/nginx/bots.d/whitelist-ips.conf
```

You will note it has done the includes in all the .vhost files on my test bed server and also whitelisted your own IP address in the whitelist-ips.conf file for you. Further IP's or IP ranges can be added to your customizable whitelits-ips.conf file located in /etc/nginx/bots.d/whitelist-ips.conf.

What this setup script has done has simply added the following include statements into your .vhost files for you, it also adds /etc/nginx/conf.d/* to the includes in nginx.conf (if not already in nginx.conf), otherwise, the whole script will fail.

```
# Bad Bot Blocker
include /etc/nginx/bots.d/ddos.conf;
include /etc/nginx/bots.d/blockbots.conf;
```

**setup-ngxblocker, install-ngxblocker and update-ngxblocker can all be configured with custom installation / update locations from the command line.** 

**Run any of the setup, install or update scripts with --help or -h to view options.**

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-6.png"/>

Now test your nginx configuration

`sudo nginx -t`

and you should see

```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-7.png"/>

Now simply reload / restart Nginx and the Bot Blocker will immediately be active and protecting all your web sites.

`sudo nginx -t && sudo nginx -s reload`

or

`sudo service nginx restart`

That's it, the blocker is now active and protecting your sites from thousands of malicious bots and domains.

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-8.png"/>

Now setup cron to automatically update the blocker for you every day so you always have the latest up to date protection.

`sudo crontab -e`

Add the following line at the end of your crontab file. Note adding the `-e` command line parameter to specify your email address where the update report is sent to. Obviously substitute `yourname@youremail.com` with your real email address or you will not receive the email when the script has updated.

`00 22 * * * sudo /usr/local/sbin/update-ngxblocker -e yourname@youremail.com` 

This will update the blocker every night for you at 10 PM.

If you want it to update more frequently (as sometimes I push out 3-4 updates a day) you can set it as follows to run the cron every 8 hours, although just once a day is more than enough.

`00 */8 * * * sudo /usr/local/sbin/update-ngxblocker -e yourname@youremail.com`       

If you don't want any email notification after an update (not advisable in case Nginx ever has an EMERG when reloading), then simply run your cron as follows. 

`00 */8 * * * sudo /usr/local/sbin/update-ngxblocker -n`       

That's it, the blocker will automatically keep itself up to date and also reload Nginx once it has downloaded the latest version of the globalblacklist.conf file.

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-9.png"/>

You can now customize any of the following files below to suit your environment or requirements. These include files never get modified during an update using the auto update script above so whatever customizations you do here will never be overwritten during an update.

```
/etc/nginx/bots.d/whitelist-ips.conf
/etc/nginx/bots.d/whitelist-domains.conf
/etc/nginx/bots.d/blacklist-user-agents.conf
/etc/nginx/bots.d/blacklist-ips.conf
/etc/nginx/bots.d/bad-referrer-words.conf
/etc/nginx/bots.d/custom-bad-referrers.conf
```

Let's say for some "obscure" reason you actually want to block GoogleBot from accessing your site. You would simply add it to the /etc/nginx/bots.d/blacklist-user-agents.conf file and it will over-ride the default whitelist for GoogleBot. the same applies to any other bots that are whitelisted by default.

All include files are commented for your convenience.

************************************************
## If This This Project helped you out, help support it 

[![Help me out with a mug of beer](https://img.shields.io/badge/Help%20-%20me%20out%20with%20a%20mug%20of%20%F0%9F%8D%BA-blue.svg)](https://paypal.me/mitchellkrog/) or [![Help me feed my cat](https://img.shields.io/badge/Help%20-%20me%20feed%20my%20hungry%20cat%20%F0%9F%98%B8-blue.svg)](https://paypal.me/mitchellkrog/)

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-10.png"/>

(TEST THAT IT IS WORKING)

**TESTING**

Run the following commands one by one from a terminal on another linux machine against your own domain name. 
**substitute yourdomain.com in the examples below with your REAL domain name**

`curl -A "Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" http://yourdomain.com`

`curl -A "Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)" http://yourdomain.com`

**Should respond with 200 OK**

`curl -A "Xenu Link Sleuth/1.3.8" http://yourdomain.com`

`curl -A "Mozilla/5.0 (compatible; AhrefsBot/5.2; +http://ahrefs.com/robot/)" http://yourdomain.com`

**Should respond with: curl: (52) Empty reply from server**

`curl -I http://yourdomain.com -e http://100dollars-seo.com`

`curl -I http://yourdomain.com -e http://zx6.ru`

**Should respond with: curl: (52) Empty reply from server**

The Nginx Ultimate Bot Blocker is now WORKING and PROTECTING your web sites !!!

************************************************
<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/step-11.png"/>

#### OPTIONAL
**INSTALLING THE BLOCKER TO NON-STANDARD NGINX FOLDER LOCATIONS**

Some people build Nginx themselves and do not end up having the standard nginx folder locations at `/etc/nginx`

For users like this you can run the install-ngblocker, setup-ngxblocker and update-ngblocker specifying your
folder location in the command lines as follows.

`sudo ./install-ngxblocker -x -c /usr/local/nginx/conf.d -b /usr/local/nginx/bots.d`

`sudo ./setup-ngxblocker -x -c /usr/local/nginx/conf.d -b /usr/local/nginx/bots.d`

`sudo ./update-ngxblocker -c /usr/local/nginx/conf.d -b /usr/local/nginx/bots.d -e yourname@youremail.com`

This will automatically put the files into the locations you specify, it will do the includes into your vhosts using your custom locations  and when update-ngblocker pulls a new update it will also now automatically re-write the "Include" sections inside the globalblacklist.conf file your own custom locations. Thanks again to Stuart Cardall @itoffshore for his contributions of these excellent scripts.

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
