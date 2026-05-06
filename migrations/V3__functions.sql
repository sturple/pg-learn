
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