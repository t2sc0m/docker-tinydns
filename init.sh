#!/bin/bash

# nonblocking loop for docker stop
trap 'exit 0' SIGTERM

# compile initial zone file
cd /etc/service/tinydns/root
make

# start daemontools
run_svscan() {
  echo "Starting svscan.." >&2
  svscan /etc/service &
}

# watch & update tinydns data file
watch_for_changes() {
  echo "Watching for tinydns data file changes.." >&2
  cd /etc/service/tinydns/root
  
  while true; do
    test data -nt data.cdb && \
    ( make && pkill -HUP -u tinydns && \
    touch data data.cdb && \
    echo "Reloading TinyDNS" >&2 ) || echo -n "." >&2
    sleep 5
  done
}

run_svscan
watch_for_changes
