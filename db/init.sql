-- custom init.sql

-- create schema
\cd /docker-entrypoint-initdb.d
\i schema/locations.sql

-- test data
\i data/test_data.sql
