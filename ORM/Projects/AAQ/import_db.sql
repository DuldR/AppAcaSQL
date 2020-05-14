DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL

);

DROP TABLE if exists questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Dingle', 'Dork'),
  ('Biggus', 'Dickus');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Nani', "Omae wa mou, shindeiru", (SELECT id FROM users WHERE fname = 'Dingle' AND lname = 'Dork')),
  ('Funny', "He has a wife you know... Incontinentia Buttocks", (SELECT id FROM users WHERE fname = 'Biggus' AND lname = 'Dickus'));
