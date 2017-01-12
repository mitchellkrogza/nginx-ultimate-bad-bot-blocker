# Robots.txt Directives ONLY for People unable to use this Bot Blocker
## DO NOT use this on any of your sites if you are running the Bad Bot Blocker

The robots.txt file residing in this directory can be used to ADD onto your existing robots.txt file by placing this after anything you already have in your robots.txt file.

## Do NOT make this file the only contents of your robots.txt file !!!

If your existing robots.txt file looks like this:

>User-agent: *
>Allow: /wp-admin/admin-ajax.php

Then your new file will look like this:

>User-agent: *
>Allow: /wp-admin/admin-ajax.php
>User-agent: Acunetix
> Disallow:/ 
>User-agent: FHscan
> Disallow:/ 
>User-agent: masscan
> Disallow:/ 
>........ rest of file contents

# You use this at your own risk

This will only help stop some bad bots from gaining access to your site
this certainly does not provide nearly as much protection as the full
Nginx Bad Bot Blocker
