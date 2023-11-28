set -e

declare db_name="$1"
declare db_file_path="$2"

createdb $db_name

psql -d $db_name -c 'CREATE EXTENSION postgis; CREATE EXTENSION hstore;'

osm2pgsql -G --hstore --style openstreetmap-carto.style --tag-transform-script openstreetmap-carto.lua -d $db_name $db_file_path

psql -d $db_name -c 'ALTER SYSTEM SET jit=off;' -c 'SELECT pg_reload_conf();'

psql -d $db_name -f indexes.sql

sed -E -i.bak "s/ database: .*/ database: $db_name/" external-data.yml
rm external-data.yml.bak

scripts/get-external-data.py
