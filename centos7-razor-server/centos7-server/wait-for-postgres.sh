#!/bin/bash
# wait-for-postgres.sh

set -e

host="postgres"
cmd="/opt/puppetlabs/bin/razor-admin -e production migrate-database"

until PGPASSWORD=mypass psql -h "$host" -U razor razor_prd -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd

sed -i "/wait-for-postgres/d" /etc/rc.local
