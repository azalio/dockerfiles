#!/bin/bash

# mkernelurl=http://links.puppetlabs.com/razor-microkernel-latest.tar
# mkerneltar=`basename $mkernelurl`
# repodir=/var/lib/razor/repo-store
# 
# # Setup the postgres DB if it hasnt been.
# if [[ ! -e /var/lib/pgsql/.bash_profile ]]; then
#      puppet apply /razor-postgres-install.pp
#      cd /opt/razor
#      cp config.yaml.sample config.yaml
#      sed -i 's/razor_prd/razor/' config.yaml
#      jruby bin/razor-admin -e production migrate-database
#      torquebox deploy --env production
# fi
# 
# # Install the Razor Microkernel, if it hasnt yet.
# if [[ ! -e $repodir/microkernel/vmlinuz0 ]]; then
#      cd $repodir
#      curl -LO $mkernelurl
#      tar xfva $mkerneltar
# fi
# 
# /etc/init.d/postgresql-9.6 start && \
#      torquebox run --bind-address=0.0.0.0
# 
# # exec /usr/sbin/init
/etc/init.d/postgresql-9.6 start
while ! service postgresql-9.6 status ; do sleep 1; done
sleep 60
/usr/sbin/razor-admin -e production migrate-database
service razor-server start
while true; do sleep 1000; done
