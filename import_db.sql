DROP TABLE IF EXISTS users;
PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL,
    -- questions_id INTEGER NOT NULL,

    -- FOREIGN KEY questions_id REFERENCES questions(id)
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY user_id REFERENCES users(id)
);

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY users_id REFERENCES users(id),
    FOREIGN KEY questions_id REFERENCES questions(id)
);

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    question_ref TEXT NOT NULL

    FOREIGN KEY question_id REFERENCES questions(id)



);

CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    likes TEXT NOT NULL
    user_like_ref INTEGER NOT NULL
    question_like_ref INTEGER NOT NULL
    
    FOREIGN KEY user_like_ref REFERENCES users(id)
    FOREIGN KEY question_like_ref REFERENCES questions(id)
);