INSERT into users (email) VALUES
('bill@gmail.com'),
('jane@gmail.com'),
('alf@gmail.com'),
('punkybrewster@gmail.com');

INSERT into pages (slug, title, content, status) VALUES
('home', 'This is my home page', '{"content": "<h2>Heading2</h2><p>This is my paragraph</p>", "tags" : ["home", "pages"]}', 'published' ),
('about', 'About Page', '{"content": "<h2>About</h2>", "tags" : ["about", "pages"]}', 'published' ),
('contact', 'contact Page', '{"content": "<h2>contact</h2>", "tags" : ["contact", "pages"]}', 'draft' );

