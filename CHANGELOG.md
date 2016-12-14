#CHANGELOG - Nginx Bad Bot Blocker

###2016-12-14
- Removed "python-requests" from bad bots list. Used by google cloud and a few other legitimate web services.

###2016-12-11
- Added some repetitively bad IP's
- Added extensive blocking for builtwith.com SEO analysis company that scrapes, accumulates and sells SEO web data. Have blocked all their domains and IP's including other domains linked to the owner. Also spent hours digging for IP's linked to this site that were very nicely hidden but through some research I uncovered them. www.builtwith.com DOES obey removal instructions at https://builtwith.com/removals and it is immediate BUT for those who have never heard of builtwith.com or even know their sites are indexed and new sites are being indexed and used by your competitors to outrank you, I have sufficient blocks in place to prevent them ever accessing your Nginx/Apache server. I suggest you FIRST see if your site is indexed, then request removal of each site which requires you to place a simple .html file in your webroot and once that is done, then update to the latest version of the script which will block them indexing new sites from thereon out. I will keep a watch on them and add new IP's as they change.
- In progress on growing the BAD IP block list which will be based off repetetive 444 errors from the bad referer domains in the blocker. These bad IP's will be auto added into the blocker and I will generate plain text IP lists and IP tables rules too which can be updated frequently to block them at firewall level and keep your web logs even cleaner.

###2016-12-04
- Added creation of a Google Disavow File - google-disavow.txt
- New Bad Referers Added

###2016-12-03
- Added Over 205 New Bad Referer Domains
- Added google-exclude.txt file for stopping Ghost Spam on your Google Analytics
- Readme Updated with Instructions on using google-exclude.txt

###2016-12-02 	
- Added Block List for Nibble SEO
- Added Block List for Wordpress Theme Detectors