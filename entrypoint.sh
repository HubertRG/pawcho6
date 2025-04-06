#!/bin/sh

node /usr/share/nginx/html/index.js &

nginx -g "daemon off;"