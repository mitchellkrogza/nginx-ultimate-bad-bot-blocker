#CONFIGURATION OF THE NGINX BAD BOT BLOCKER:
### PLEASE READ CONFIGURATION INSTRUCTIONS BELOW THOROUGHLY

##### Created by: https://github.com/mitchellkrogza
##### Copyright Mitchell Krog <mitchellkrog@gmail.com>

##Step 1:
Copy the contents of **/conf.d/globalblacklist.conf** into your /etc/nginx/conf.d folder. 

`cd /etc/nginx/conf.d`

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/conf.d/globalblacklist.conf`

##Step 2: 

- From your command line in Linux type

`sudo mkdir /etc/nginx/bots.d `

`cd /etc/nginx/bots.d`

- copy the blockbots.conf file into that folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/blockbots.conf`


- copy the ddos.conf file into the same folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/ddos.conf`

##Step 3:

Whitelist all your own domain names and IP addresses. **Please note important changes**, this is now done using include files so that you do not have to keep reinserting your whitelisted domains and IP addresses every time you update.

`cd /etc/nginx/bots.d`

- copy the whitelist-ips.conf file into that folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-ips.conf`


- copy the whitelist-domains.conf file into the same folder

`sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/bots.d/whitelist-domains.conf`

Use nano, vim or any other text editor to edit both whitelist-ips.conf and whitelist-domains.conf to include all your own domain names and IP addresses that you want to specifically whitelist from the blocker script. 

When pulling any future updates now you can simply pull the latest globalblacklist.conf file and it will automatically include your whitelisted domains and IP addresses.


##Step 4:

- From your linux command line type

- `sudo nano /etc/nginx/nginx.conf`

#####Add the following settings and rate limiting zones near the top of your nginx.conf file. This is both for the Anti DDOS rate limiting filter and for allowing Nginx to load this very large set of domain names into memory. 
**see SAMPLE-nginx.conf file in the root of this repository**

- `server_names_hash_bucket_size 64;`

- `server_names_hash_max_size 4096;`

- `limit_req_zone $binary_remote_addr zone=flood:50m rate=90r/s;`

- `limit_conn_zone $binary_remote_addr zone=addr:50m;`

**Make sure** that your nginx.conf file contains the following include directive

- `include /etc/nginx/conf.d/*`

**PLEASE NOTE:** The above rate limiting rules are for the DDOS filter, it may seem like high values to you but for wordpress sites with plugins and lots of images, it's not. This will not limit any real visitor to your Wordpress sites but it will immediately rate limit any aggressive bot. Remember that other bots and user agents are rate limited using a different rate limiting rule at the bottom of the globalblacklist.conf file.

The server_names_hash settings allows Nginx Server to load this very large list of domain names and IP addresses into memory.

##Step 5:

Open a site config file for Nginx (just one for now) and add the following lines.
##### VERY IMPORTANT: these includes MUST be added within a server {} block otherwise you will get EMERG errors from Nginx.

- `include /etc/nginx/bots.d/blockbots.conf;`

- `include /etc/nginx/bots.d/ddos.conf;`

##Step 6:

sudo nginx -t (make sure it returns no errors and if none then)
sudo service nginx reload