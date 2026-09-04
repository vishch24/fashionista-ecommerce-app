#!/bin/bash
set -e
pg_restore \
  --dbname="$POSTGRES_DB" \
  --username="$POSTGRES_USER" \
  --no-owner \
  --no-privileges \
  /docker-entrypoint-initdb.d/ecommerce.dump