#!/bin/bash

# /**
#  * @version    1.8.3
#  * @package    Engintron for cPanel/WHM
#  * @author     Fotis Evangelou
#  * @url        https://engintron.com
#  * @copyright  Copyright (c) 2010 - 2017 Nuevvo Webware P.C. All rights reserved.
#  * @license    GNU/GPL license: https://www.gnu.org/copyleft/gpl.html
#  */

COUNTER="0"

function generate_https_vhosts {
	if [ -f /etc/nginx/utilities/https_vhosts.php ]; then
		RUN_CHECK=$(/usr/bin/php -c /dev/null /etc/nginx/utilities/https_vhosts.php)
		if [[ $RUN_CHECK == 1 ]]; then
			service nginx reload;
		fi
	fi
	sleep 10
}

while [ $COUNTER -lt 5 ]; do
	generate_https_vhosts
	COUNTER=$[$COUNTER+1]
done

exit 0
