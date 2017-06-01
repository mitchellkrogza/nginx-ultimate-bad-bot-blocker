#!/bin/bash
# Travis CI Code to Configure Nginx
set -e
set -x

DIR=$(realpath $(dirname "$0"))
USER=$(whoami)
PHP_VERSION=$(phpenv version-name)
ROOT=$(realpath "$DIR/..")
PORT=9000
SERVER="/tmp/php.sock"

function tpl {
    sed \
        -e "s|{DIR}|$DIR|g" \
        -e "s|{USER}|$USER|g" \
        -e "s|{PHP_VERSION}|$PHP_VERSION|g" \
        -e "s|{ROOT}|$ROOT|g" \
        -e "s|{PORT}|$PORT|g" \
        -e "s|{SERVER}|$SERVER|g" \
        < $1 > $2
}

# Make some working directories.
mkdir "$DIR/nginx"
mkdir "$DIR/nginx/sites-enabled"
mkdir "$DIR/nginx/bots.d"
mkdir "$DIR/var"

# Configure the PHP handler.
    PHP_FPM_BIN="$HOME/.phpenv/versions/$PHP_VERSION/sbin/php-fpm"
    PHP_FPM_CONF="$DIR/nginx/php-fpm.conf"

    # Build the php-fpm.conf.
    tpl "$DIR/php-fpm.tpl.conf" "$PHP_FPM_CONF"

    # Start php-fpm
    "$PHP_FPM_BIN" --fpm-config "$PHP_FPM_CONF"

# Build the default nginx config files.
tpl "$DIR/nginx.tpl.conf" "$DIR/nginx/nginx.conf"
tpl "$DIR/fastcgi.tpl.conf" "$DIR/nginx/fastcgi.conf"
tpl "$DIR/ddos.tpl.conf" "$DIR/nginx/ddos.conf"
tpl "$DIR/blockbots.tpl.conf" "$DIR/nginx/blockbots.conf"
tpl "$DIR/whitelist-ips.tpl.conf" "$DIR/nginx/bots.d/whitelist-ips.conf"
tpl "$DIR/whitelist-domains.tpl.conf" "$DIR/nginx/bots.d/whitelist-domains.conf"
tpl "$DIR/blacklist-user-agents.tpl.conf" "$DIR/nginx/bots.d/blacklist-user-agents.conf"
tpl "$DIR/bad-referrer-words.tpl.conf" "$DIR/nginx/bots.d/bad-referrer-words.conf"
tpl "$DIR/custom-bad-referrers.tpl.conf" "$DIR/nginx/bots.d/custom-bad-referrers.conf"
tpl "$DIR/blacklist-ips.tpl.conf" "$DIR/nginx/bots.d/blacklist-ips.conf"
tpl "$DIR/botblocker-nginx-settings.tpl.conf" "$DIR/nginx/botblocker-nginx-settings.conf"
tpl "$DIR/globalblacklist.tpl.conf" "$DIR/nginx/globalblacklist.conf"
tpl "$DIR/default-site.tpl.conf" "$DIR/nginx/sites-enabled/default-site.conf"

# Start nginx.
nginx -c "$DIR/nginx/nginx.conf"