# EASY AUTO CONFIGURATION INSTRUCTIONS FOR THE NGINX BAD BOT BLOCKER:
### PLEASE READ CONFIGURATION INSTRUCTIONS BELOW THOROUGHLY :exclamation:

##### Created by: https://github.com/mitchellkrogza
##### Copyright Mitchell Krog <mitchellkrog@gmail.com>

##### Version Information #
********************************************
# Version: V3.2017.06.540
********************************************
##### Version Information ##

## Update Notification System

Please subscribe your email address to the mailing list at **https://groups.google.com/forum/#!forum/nginx-ultimate-bad-bot-blocker**
or simply send a blank email to **nginx-ultimate-bad-bot-blocker+subscribe@googlegroups.com** to subscribe.
Please make sure you are subscribed to notifications to be notified when the blocker is updated and also to be notified when any important or mission critical changes take place.

## Please follow the instructions below step by step :exclamation:

- This is our new preferred method of installation which is now done through a set of shell scripts contributed to this repo by Stuart Cardall @itoffshore who is one of the Alpine Linux package maintainers. 

- The instructions below are for a quick and painfree installation process which downloads all required files for the blocker and the scripts include adding the required includes to your nginx.conf and nginx .vhost files. The setup script assumes your vhost config files are located in /etc/nginx/sites-available/ and each vhost config file ends with a file extension of .vhost

- For manual installation instructions please see - Please see: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/MANUAL-CONFIGURATION.md

- Both setup-ngxblocker & install-ngxblocker can be configured with custom installation / update locations from the command line. Run the scripts with --help or -h to view options.

## STEP 1:

Download the install, setup and update scripts to your /usr/sbin/ directory and make the scripts executable

```
cd /usr/sbin
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O install-ngxblocker
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/setup-ngxblocker -O setup-ngxblocker
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/update-ngxblocker -O update-ngxblocker
sudo chmod +x install-ngxblocker
sudo chmod +x setup-ngxblocker
sudo chmod +x update-ngxblocker
```

**Both setup-ngxblocker & install-ngxblocker can be configured with custom installation / update locations from the command line. 
Run the scripts with --help or -h to view options.**

## STEP 2:

Now run the install-ngxblocker script in DRY-MODE which will show you what changes it will make and what files it will download for you. This is only a DRY-RUN so no changes are being made yet.

```
cd /usr/sbin
sudo ./install-ngxblocker
```

This will show you output as follows of the changes that will be made 
**(NOTE: this is only a DRY-RUN no changes have been made)**

```
Checking url: https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/include_filelist.txt

** Dry Run ** | -x or --exec to download files


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
```

**Both setup-ngxblocker & install-ngxblocker can be configured with custom installation / update locations from the command line. 
Run the scripts with --help or -h to view options.**

## STEP 3:

Now run the install script with the -x parameter to download all the necessary files from the repository:

```
cd /usr/sbin/
sudo ./install-ngxblocker -x
```

This will give you the following output:

```
Checking url: https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/include_filelist.txt


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
```

The required files have now been downloaded to the correct folders on Nginx for you direct from the repository.

**Both setup-ngxblocker & install-ngxblocker can be configured with custom installation / update locations from the command line. 
Run the scripts with --help or -h to view options.**

## STEP 4:

Now run the setup-ngxblocker script in DRY-MODE which will show you what changes it will make and what files it will download for you. This is only a DRY-RUN so no changes are being made yet.

```
cd /usr/sbin/
sudo ./setup-ngxblocker
```

This will give you output as follows (this output below assumes your nginx.conf file already has the default include of /etc/nginx/conf.d/*)
All Nginx installations I know of have this default include in the nginx.conf file distributed with all versions.

```
Checking url: https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/include_filelist.txt

** Dry Run ** | not updating files | -x or --exec to change files

INFO:      /etc/nginx/conf.d/* detected               => /etc/nginx/nginx.conf
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/default.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/default.vhost
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/site1.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/site1.com.vhost
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/site3.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/site3.com.vhost
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/site2.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/site2.com.vhost

Whitelisting ip:  x.x.x.x    => /etc/nginx/bots.d/whitelist-ips.conf
```

This script also whitelists your IP in the whitelist-ips.conf file for you. 
Further IP's or IP ranges can be added to your customizable whitelits-ips.conf file located in /etc/nginx/bots.d/whitelist-ips.conf.

**Both setup-ngxblocker & install-ngxblocker can be configured with custom installation / update locations from the command line. 
Run the scripts with --help or -h to view options.**

## STEP 5:

Now run the setup script with the -x parameter to make all the necessary changes to your nginx.conf (if required) and also to add the required includes into all your vhost files. 

This setup-ngxblocker script assumes that all your vhost files located in /etc/nginx/sites-available end in an extension .vhost. It is good practice to make all your vhost config files end with a .vhost extension but if you prefer to stick what you already have eg .conf you can simply modify line 10 of setup-ngxblocker to the appropriate extension you use for your vhost files.

For instance if your vhost files end in .conf you will change this line in setup-ngxblocker as follows:

`VHOST_EXT="conf`

So now let's run the setup script and let it make all the changes we need to make the Bot Blocker active on all your sites.

```
cd /usr/sbin/
sudo ./setup-ngxblocker -x
```

You will see output as follows:

```
Checking url: https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/include_filelist.txt

INFO:      /etc/nginx/conf.d/* detected               => /etc/nginx/nginx.conf
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/default.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/default.vhost
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/site1.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/site1.com.vhost
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/site3.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/site3.com.vhost
inserting: include /etc/nginx/bots.d/blockbots.conf;  => /etc/nginx/sites-available/site2.com.vhost
inserting: include /etc/nginx/bots.d/ddos.conf;       => /etc/nginx/sites-available/site2.com.vhost

Whitelisting ip:  x.x.x.x    => /etc/nginx/bots.d/whitelist-ips.conf
```

You will note it has done the includes in all the .vhost files on my test bed server and also whitelisted your own IP address in the whitelist-ips.conf file for you. Further IP's or IP ranges can be added to your customizable whitelits-ips.conf file located in /etc/nginx/bots.d/whitelist-ips.conf.

What this setup script has done has added the following include statements into your .vhost files for you.

```
# Bad Bot Blocker
include /etc/nginx/bots.d/ddos.conf;
include /etc/nginx/bots.d/blockbots.conf;
```

**Both setup-ngxblocker & install-ngxblocker can be configured with custom installation / update locations from the command line. 
Run the scripts with --help or -h to view options.**

## STEP 6:

Now test your nginx configuration

`sudo nginx -t`

and you should see

```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

## STEP 7: 

Now simply reload / restart Nginx and the Bot Blocker will immediately be active and protecting all your web sites.

`sudo service nginx reload`

or

`sudo service nginx restart`

That's it, the blocker is now active and protecting your sites from thousands of malicious bots and domains.

## STEP 8:

Now setup cron to automatically update the blocker for you every day so you always have the latest up to date protection.

`sudo crontab -e`

Add the following line at the end of your crontab file

`00 22 * * * /usr/sbin/update-ngxblocker` 

This will update the blocker every night for you at 10 PM.
If you want it to update more frequently (as sometimes I push out 3-4 updates a day) you can set it as follows to run the cron every 8 hours.

`00 */8 * * * /usr/sbin/update-ngxblocker`       

That's it, the blocker will automatically keep itself up to date and also reload Nginx once it has downloaded the latest version of the globalblacklist.conf file.

## STEP 9:

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

### If this helps you why not [buy me a beer](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BKF9XT6WHATLG):beer:

## STEP 10: (TEST THAT IT IS WORKING)

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

### Coding makes me very thirsty [why not buy me a beer](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BKF9XT6WHATLG):beer: