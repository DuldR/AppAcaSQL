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

DROP TABLE if exists questions_liked;

CREATE TABLE questions_liked
(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY
  (question_id) REFERENCES questions
  (id)
);



DROP TABLE if exists replies;

CREATE TABLE replies
(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  top_reply_id INTEGER,
  body TEXT,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (top_reply_id) REFERENCES replies(id)

);


INSERT INTO
  users (fname, lname)
VALUES
  ('Dingle', 'Dork'),
  ('Biggus', 'Dickus'),
  ('Fridge', 'Largemeat'),
  ('Stump', 'Chunkman'),
  ('Big', 'McLargeHuge');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Nani', "Omae wa mou, shindeiru", (SELECT id FROM users WHERE fname = 'Dingle' AND lname = 'Dork')),
  ('Funny', "He has a wife you know... Incontinentia Buttocks", (SELECT id FROM users WHERE fname = 'Biggus' AND lname = 'Dickus')),
  ('Brian', "Always look on the bright side of life.", 2);

INSERT INTO
  questions_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname='Dingle' AND lname='Dork'), (SELECT id FROM questions WHERE user_id = 1)),
  ((SELECT id FROM users WHERE fname='Biggus' AND lname='Dickus'), (SELECT id FROM questions WHERE user_id = 2)),
  ((SELECT id FROM users WHERE fname='Fridge' AND lname='Largemeat'), 2),
  ((SELECT id FROM users WHERE fname='Stump' AND lname='Chunkman'), 2)
  ;

INSERT INTO
  questions_liked
  (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname='Dingle' AND lname='Dork'), 2),
  ((SELECT id FROM users WHERE fname='Biggus' AND lname='Dickus'), 2),
  ((SELECT id FROM users WHERE fname='Fridge' AND lname='Largemeat'), 2),
  ((SELECT id FROM users WHERE fname='Stump' AND lname='Chunkman'), 1),
  ((SELECT id FROM users WHERE fname='Stump' AND lname='Chunkman'), 2),
  ((SELECT id FROM users WHERE fname='Fridge' AND lname='Largemeat'), 1),
  ((SELECT id FROM users WHERE fname='Big' AND lname='McLargeHuge'), 2)
  ;

INSERT INTO
  replies (user_id, question_id, top_reply_id, body)
VALUES
  ((SELECT id FROM users WHERE fname='Dingle' AND lname='Dork'), (SELECT id FROM questions WHERE questions.user_id = 1), NULL, "NANI SHITERU NO?"),
  ((SELECT id FROM users WHERE fname='Biggus' AND lname='Dickus'), (SELECT id FROM questions WHERE questions.user_id = 1), 1, "Oh? You're approaching me?");