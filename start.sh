#!/bin/bash

set -eu -o pipefail

if [[ ! -f /app/data/.initialized ]]; then
  echo "Fresh installation, setting up data directory..."
  install -d -D -m 0755 -o cloudron -g cloudron /app/data/log /app/data/lib/netdata/www /app/data/cache/netdata /app/data/lib/netdata /app/data/etc
  cp -a /etc/netdata/* /app/data/etc/
  chown -R cloudron:cloudron /app/data && chmod -R 777 /app/data  
  touch /app/data/.initialized
  echo "Init Done."
fi

exec /usr/sbin/netdata -c /app/data/etc/netdata.conf -u netdata -D 
