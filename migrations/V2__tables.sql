
CREATE TABLE users (
    id uuid primary key default gen_random_uuid(),
    email TEXT UNIQUE,
    username TEXT UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
GRANT ALL privileges on TABLE users to web_anon; 

-- ALTER TABLE users ENABLE ROW LEVEL SECURITY;



create table pages (
  id uuid primary key default gen_random_uuid(),
  site integer NOT NULL, 
  slug text unique not null, -- '/about'
  title text,
  template text default 'default',             -- 'default', 'blog', etc.
  content text,
  meta jsonb,
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
