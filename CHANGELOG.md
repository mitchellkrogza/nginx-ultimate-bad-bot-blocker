# CHANGELOG - Nginx Bad Bot Blocker

### 2017-06-21
- Fixed formatting of font size of Versioning information written into Readme Files
- Added count totals into Readme files for amount of bad referrers and bots being protected against.

### 2017-06-06
- Did some house cleaning on folder names
- Moved all sample config files into _sample_config_files folder
- Renamed Fail2Ban folder to _fail2ban_addon
- Moved repo logo file into _assets folder
- Fixed Travis CI scripts to adjust to new folder locations for when it runs it's build [PASSED]

### 2017-05-25
- Unfortunately my father passed away on the 5th of May after a 5 month long battle with a very aggressive cancer. It's been keeping me very busy with funerals and all sorts of other arrangements but life carries on and so does this Bot Blocker. I must say this project helps me keep my mind off things.
- Added New Preferred AUTO Installation Instructions using the script from Stuart Cardall @itoffshore into README.md
- Added New AUTO-CONFIGURATION.md instructions file.
- Renamed CONFIGURATION.md to MANUAL-CONFIGURATION.md
- Renamed Logo File
- Version / Build Numbering Format Changed in preparation for new Travis CI build tests.
- My New Travis CI build testing based on the scripts from Stuart Cardall will be coming through shortly. This will ensure thorough testing by Travis CI of our auto installation instructions using Stuart's amazing scripts. Thank you once again Stuart @itoffshore for your great contributions to this project.
- I end off this update today by wishing my father Vernon, God Speed - https://web.facebook.com/vernon.krog Forever in my heart, dreams and memories.

### 2017-04-21
- Updated install-ngxblocker script from Stuart Cardall @itoffshore
- Fixed updating globalblacklist.conf in EnginTron example folder

### 2017-04-20 (MAJOR VERSION UPDATE) - V2.2017.07

- New include files introduced:

- blacklist-ips.conf
- bad-referrer-words.conf
- custom-bad-referrers.conf

- New include file bad-referrer-words.conf allows total control and customization of scanning for bad referrer words
- New include file blacklist-ips.conf allows total control and customization over which IP addresses and IP Ranges you want to block
- New include file custom-bad-referrers.conf allows adding own custom bad referrer domains you wish to block.

- Cyveillance and Berkeley Scanner Blocks have been moved into blacklist-ips.conf

- **VERY IMPORTANT** - Without the existence of the new include files blacklist-ips.conf, bad-referrer-words.conf and custom-bad-referrers.conf include files Nginx will FAIL RELOADING with EMERG :exclamation:

- PLEASE READ UPDATED CONFIGURATION INSTRUCTIONS :exclamation: :exclamation: :exclamation:

- AUTO UPDATE SCRIPT WILL FAIL NGINX RELOAD WITHOUT THE NEW INCLUDE FILES !!!! :exclamation: :exclamation: :exclamation:

- Please subscribe your email address to the mailing list at **https://groups.google.com/forum/#!forum/apache-ultimate-bad-bot-blocker**
or simply send a blank email to **apache-ultimate-bad-bot-blocker+subscribe@googlegroups.com** to subscribe.
**Please make sure you are subscribed to notifications** to be notified when the blocker is updated and also to be notified when any important or mission critical changes like this take place.
- Also follow me on twitter @ubuntu101za for update notifications

### 2017-04-19
- Introduced better Regex patterns for Good and Bad Bots to prevent false positives.
- Regex Changes on Bad Bots Section to Case Insensitive Matching
- Regex Change on Good Bots Section to Exact Matching
- Fixed some Duplicated Bots Issues
- Added Help and Examples for People using EnginTron/CPanel/WHM systems.

### 2017-04-16
- Happy Easter !!! :rabbit:
- New setup-ngxblocker script contributed by Stuart Cardall @itoffshore. The script will try to insert the new configuration below any existing includes in your config files. If the search string is not found the inserts are made at the end of the start search range. Thank you @itoffshore for this contribution.
- installnginxblocker.sh renamed to install-ngxblocker for consistency
- updatenginxblocker.sh renamed to update-ngxblocker for consistency
- Readme and Configuration File Updates

### 2017-04-11
- Introduced Repo Email Notification Mailing List
- Please subscribe your email address to the mailing list at **https://groups.google.com/forum/#!forum/nginx-ultimate-bad-bot-blocker**
or simply send a blank email to **nginx-ultimate-bad-bot-blocker+subscribe@googlegroups.com** to subscribe.
Please make sure you are subscribed to notifications to be notified when the blocker is updated and also to be notified when any important or mission critical changes take place.

### 2017-03-02
- V2.2017.05 - Added New Include Method for Including your own custom list of Bad User-Agents
  or Bots that you want to permanently block.
  - **You must now have an (/etc/nginx/bots.d/blacklist-user-agents.conf) file or you will get and Nginx EMERG error**
  - Introduced New Bash Installer Script to Ease Installation of this Bad Bot Blocker
  - Also introduced new include file (/etc/nginx/conf.d/botblocker-nginx-settings.conf) for including the rate limiting zones and server_hash settings for you in your nginx.conf file
  **[Please read updated configuration instructions](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/CONFIGURATION.md)**

### 2017-02-16
- V2.2017.04 - Added new include file methods for whitelisting your own domains and IP addresses.
  No more having to remember to include your own IP ranges with any future update.
  **[Please read updated configuration instructions](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/CONFIGURATION.md)**

### 2017-02-08
- V2.2017.03 - Added Travis CI Build Checking and Various Readme File Updates

### 2017-02-06
- V2.2017.02 - Added Whitelisting of Cloudflare IP Ranges

### 2017-01-29
- Changed formatting of globalblacklist.conf, some sections like semalt and miraibot merged into other sections for easier maintenance.
- Additional notes, testing instructions and commenting added in globalblacklist.conf file

### 2016-12-17
- Removed "CPython" from bad bots list. This user agent string "python-requests/2.5.3 CPython/2.7.9 Linux/3.16.0-4-amd64" is used by a valid Google Feed Parser called "UniversalFeedParser/5.2.1 +https://code.google.com/p/feedparser/"

### 2016-12-14
- Removed "python-requests" from bad bots list. This user agent string "python-requests/2.5.3 CPython/2.7.9 Linux/3.16.0-4-amd64" is used by a valid Google Feed Parser called "UniversalFeedParser/5.2.1 +https://code.google.com/p/feedparser/"

### 2016-12-11
- Added some repetitively bad IP's
- Added extensive blocking for builtwith.com SEO analysis company that scrapes, accumulates and sells SEO web data. Have blocked all their domains and IP's including other domains linked to the owner. Also spent hours digging for IP's linked to this site that were very nicely hidden but through some research I uncovered them. www.builtwith.com DOES obey removal instructions at https://builtwith.com/removals and it is immediate BUT for those who have never heard of builtwith.com or even know their sites are indexed and new sites are being indexed and used by your competitors to outrank you, I have sufficient blocks in place to prevent them ever accessing your Nginx/Apache server. I suggest you FIRST see if your site is indexed, then request removal of each site which requires you to place a simple .html file in your webroot and once that is done, then update to the latest version of the script which will block them indexing new sites from thereon out. I will keep a watch on them and add new IP's as they change.
- In progress on growing the BAD IP block list which will be based off repetetive 444 errors from the bad referer domains in the blocker. These bad IP's will be auto added into the blocker and I will generate plain text IP lists and IP tables rules too which can be updated frequently to block them at firewall level and keep your web logs even cleaner.

### 2016-12-04
- Added creation of a Google Disavow File - google-disavow.txt
- New Bad Referers Added

### 2016-12-03
- Added Over 205 New Bad Referer Domains
- Added google-exclude.txt file for stopping Ghost Spam on your Google Analytics
- Readme Updated with Instructions on using google-exclude.txt

### 2016-12-02 	
- Added Block List for Nibble SEO
- Added Block List for Wordpress Theme Detectors
