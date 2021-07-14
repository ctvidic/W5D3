DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;
PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    question_ref_id INTEGER NOT NULL,
    user_ref_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    parent_reply_id INTEGER,

    FOREIGN KEY (question_ref_id) REFERENCES questions(id),
    FOREIGN KEY (user_ref_id) REFERENCES users(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    likes TEXT NOT NULL,
    user_like_ref_id INTEGER NOT NULL,
    question_like_ref_id INTEGER NOT NULL,
    
    FOREIGN KEY (user_like_ref_id) REFERENCES users(id),
    FOREIGN KEY (question_like_ref_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('Ned', 'Ned'),
    ('Kush', 'Ned'),
    ('Earl', 'Ned');


INSERT INTO
    questions (title, body, author_id)
VALUES
    ('Ned Question', 'NED NED NED', (SELECT id FROM users WHERE fname = 'Ned'));