#!/bin/bash
# Travis CI Code Adapted and Modified from 4 Sources
# Thanks go out to: 
# https://github.com/tburry/travis-nginx-test
# https://github.com/alrra/travis-after-all 
# https://github.com/shoonoise/lua-nginx-statistics
# https://github.com/nlindblad/nlindblad.github.io
# Without a combination of your Travis CI tests for Nginx I would never have got it working.

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
if [ "$PHP_VERSION" = 'hhvm' ] || [ "$PHP_VERSION" = 'hhvm-nightly' ]
then
    HHVM_CONF="$DIR/nginx/hhvm.ini"

    tpl "$DIR/hhvm.tpl.ini" "$HHVM_CONF"

    cat "$HHVM_CONF"

    hhvm \
        --mode=daemon \
        --config="$HHVM_CONF"
else
    PHP_FPM_BIN="$HOME/.phpenv/versions/$PHP_VERSION/sbin/php-fpm"
    PHP_FPM_CONF="$DIR/nginx/php-fpm.conf"

    # Build the php-fpm.conf.
    tpl "$DIR/php-fpm.tpl.conf" "$PHP_FPM_CONF"

    # Start php-fpm
    "$PHP_FPM_BIN" --fpm-config "$PHP_FPM_CONF"
fi

# Build the default nginx config files.
tpl "$DIR/nginx.tpl.conf" "$DIR/nginx/nginx.conf"
tpl "$DIR/fastcgi.tpl.conf" "$DIR/nginx/fastcgi.conf"
tpl "$DIR/ddos.tpl.conf" "$DIR/nginx/ddos.conf"
tpl "$DIR/blockbots.tpl.conf" "$DIR/nginx/blockbots.conf"
tpl "$DIR/whitelist-ips.tpl.conf" "$DIR/nginx/bots.d/whitelist-ips.conf"
tpl "$DIR/whitelist-domains.tpl.conf" "$DIR/nginx/bots.d/whitelist-domains.conf"
tpl "$DIR/globalblacklist.tpl.conf" "$DIR/nginx/globalblacklist.conf"
tpl "$DIR/default-site.tpl.conf" "$DIR/nginx/sites-enabled/default-site.conf"

# Start nginx.
nginx -c "$DIR/nginx/nginx.conf"