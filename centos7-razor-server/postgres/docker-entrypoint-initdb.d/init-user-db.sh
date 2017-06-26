#!/bin/bash
set -e

until psql -U "postgres" -c '\l'; do
	>&2 echo "Postgres is unavailable - sleeping"
	sleep 1
done

>&2 echo "Postgres is up - executing command"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER razor WITH PASSWORD 'mypass';
    CREATE DATABASE razor_prd;
    GRANT ALL PRIVILEGES ON DATABASE razor_prd TO razor;
EOSQL
