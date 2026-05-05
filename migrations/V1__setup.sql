CREATE DOMAIN "text/html" as text;

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
create role test_admin  login password 'password';
create role test_editor  login password 'password';
create role test_subscriber  login password 'password';
create role test_anon  login password 'password';



grant web_admin to test_admin;
grant web_editor to test_editor;
grant web_subscriber to test_subscriber;
grant web_anon to test_anon;

CREATE TABLE users (
    id uuid primary key default gen_random_uuid(),
    email TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE users ENABLE ROW LEVEL SECURITY;


create table pages (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null, -- '/about'
  title text,
  template text,             -- 'default', 'blog', etc.
  content jsonb,
  owner_id uuid,
  status text default 'draft'
);

ALTER TABLE pages ENABLE ROW LEVEL SECURITY;
grant select on pages to web_anon;
grant insert, update on pages to web_editor;
grant delete on pages to web_admin;

create policy "public can read published pages"
on pages
for select
to web_anon
using (status = 'published' OR pg_has_role(current_user, 'web_admin', 'member'));

create policy "editors can insert pages"
on pages
for insert
to web_editor
with check (true);

create policy "editors can update pages"
on pages
for update
to web_editor
using (true)
with check (true);

-- Functions
-- create or replace function get_users(pageid integer) 
-- returns text
-- language plpgsql
-- security invoker
-- as $$

-- declare
--   result text;
-- begin
--   select email into result
--   from users
--   where id = pageid;

--   if result is null then
--     result = 'not found';
--   end if;
--   return result;
-- end;
-- $$;

create or replace function index(pageid integer) returns "text/html" as $$
  select $html$
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>ok this is my own title</title>
    </head>
    <body>
      <main class="container">
        <article>
          <h1 style="text-align: center;">
            passing stuff
          </h1>
		  $html$
		  || pageid ||
		  $html$
        </article>
      </main>
    </body>
    </html>
  $html$;
$$ language sql;