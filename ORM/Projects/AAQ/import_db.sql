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

DROP TABLE if exists questions_follows;

CREATE TABLE questions_follows
(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);



DROP TABLE if exists replies;

CREATE TABLE replies
(
  id INTEGER PRIMARY KEY,
  rtitle TEXT NOT NULL,
  rbody TEXT NOT NULL,
  parentreply INTEGER NOT NULL

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

INSERT INTO
  questions_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname='Dingle' AND lname='Dork'), (SELECT id FROM questions WHERE user_id = 1)),
  ((SELECT id FROM users WHERE fname='Biggus' AND lname='Dickus'), (SELECT id FROM questions WHERE user_id = 2))
  ;
