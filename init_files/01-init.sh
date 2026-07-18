#!/bin/bash

set -e

gogs_role=$(cat /run/secrets/gogs_pwd)
forgejo_role=$(cat /run/secrets/forgejo_pwd)


psql -v ON_ERROR_STOP=1 -v gogs_role=$gogs_role -v forgejo_role=$forgejo_role --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  ALTER ROLE gogs WITH PASSWORD :'gogs_role';
  ALTER ROLE forgejo WITH PASSWORD :'forgejo_role';
EOSQL