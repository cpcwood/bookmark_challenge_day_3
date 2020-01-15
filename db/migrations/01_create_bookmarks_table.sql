CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(60));
SELECT setval('bookmarks_id_seq', max(id)) FROM users;
