CREATE TABLE peeps(id SERIAL PRIMARY KEY, body VARCHAR(140), datetimeposted timestamp default CURRENT_TIMESTAMP, user_id INTEGER REFERENCES users (id) ON DELETE CASCADE);