CREATE DOMAIN "text/html" as text;

-- Roles for postREST
CREATE ROLE authenticator LOGIN NOINHERIT NOCREATEDB NOCREATEROLE NOSUPERUSER password '${REST_PASSWORD}';
CREATE ROLE anonymous NOLOGIN;
CREATE ROLE webuser NOLOGIN;
grant webuser to authenticator;

-- Roles
create role web_admin NOLOGIN;
create role web_editor NOLOGIN;
create role web_subscriber NOLOGIN;
create role web_anon noinherit NOLOGIN;

-- Grant all the roles for web users;
grant web_anon to web_subscriber;
grant web_subscriber to web_editor;
grant web_editor to web_admin;

-- Test users
create role test_admin  login password '${DB_USER_PASSWORD}';
create role test_editor  login password '${DB_USER_PASSWORD}';
create role test_subscriber  login password '${DB_USER_PASSWORD}';
create role test_anon  login password '${DB_USER_PASSWORD}';


grant web_admin to test_admin;
grant web_editor to test_editor;
grant web_subscriber to test_subscriber;
grant web_anon to test_anon;
