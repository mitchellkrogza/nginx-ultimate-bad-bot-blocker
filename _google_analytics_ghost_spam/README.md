<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/_logo_nginx_bad_bot_blocker.png" alt="Stopping Google Analytics Ghost Spam with the Nginx Ultimate Bad Bot Spam Referrer Blocker"/><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![DUB](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/LICENSE.md)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![GitHub release](https://img.shields.io/github/release/mitchellkrogza/nginx-ultimate-bad-bot-blocker.svg)](https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/releases/latest)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/>[![Build Status](https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker.svg?branch=master)](https://travis-ci.org/mitchellkrogza/nginx-ultimate-bad-bot-blocker)<img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/spacer.jpg"/><a href='https://twitter.com/ubuntu101za'><img src='https://img.shields.io/twitter/follow/ubuntu101za.svg?style=social&label=Follow' alt='Follow @ubuntu101za'></a>

# EASY CONFIGURATION INSTRUCTIONS FOR STOPPING GOOGLE ANALYTICS "GHOST" SPAM

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
### <a href="https://github.com/mitchellkrogza/Stop.Google.Analytics.Ghost.Spam.HOWTO" target="_blank">Google Analytics "Ghost Spam" Explained</a>

Simply using the Nginx blocker does not stop Google Analytics ghost referral spam because they are hitting Analytics directly and not always necessarily touching your website. 

You should use regex filters in Analytics to create Segmnets and prevent ghost referral spam.

For this there are several google-exclude-0*.txt files which have been created for you and they are updated at the same time when the Nginx Blocker is updated. As the list grows there will be more exclude files created.

************************************************
## To stop Ghost Spam on On Analytics
************************************************

Follow the step by step visual instructions below to add these google-exclude files as segments to your web site.

<table style="width:100%;margin:0;">
  <tr>
    <td align="left"><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/google-analytics-ghost-spam-01.jpg" alt="Google Analytics - Adding Segments to Stop Ghost Spam"/></td>
  </tr>
  <tr>
    <td align="left"><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/google-analytics-ghost-spam-02.jpg" alt="Google Analytics - Adding Segments to Stop Ghost Spam"/></td>
  </tr>
  <tr>
    <td align="left"><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/google-analytics-ghost-spam-03.jpg" alt="Google Analytics - Adding Segments to Stop Ghost Spam"/></td>
  </tr>
  <tr>
    <td align="left"><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/google-analytics-ghost-spam-04.jpg" alt="Google Analytics - Adding Segments to Stop Ghost Spam"/></td>
  </tr>
  <tr>
    <td align="left"><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/google-analytics-ghost-spam-05.jpg" alt="Google Analytics - Adding Segments to Stop Ghost Spam"/></td>
  </tr>
  <tr>
    <td align="left"><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/google-analytics-ghost-spam-06.jpg" alt="Google Analytics - Adding Segments to Stop Ghost Spam"/></td>
  </tr>
  <tr>
    <td align="left"><img src="https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/blob/master/.assets/google-analytics-ghost-spam-07.jpg" alt="Google Analytics - Adding Segments to Stop Ghost Spam"/></td>
  </tr>
</table>

************************************************
## BLOCKING SPAM DOMAINS USING GOOGLE SEARCH CONSOLE / WEBMASTER TOOLS 
(How to use the google-disavow.txt file)

I have added the creation of a Google Disavow text file called google-disavow.txt. This file can be used in Google's Webmaster Tools to block all these domains out as spammy or bad links. Use with caution.

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
