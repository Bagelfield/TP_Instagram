CREATE DATABASE Instagram;
USE Instagram;

CREATE TABLE Users(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    avatar VARCHAR(100),
    bio VARCHAR(400),
    UNIQUE(username)
);

CREATE TABLE Post(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    url VARCHAR(200) NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE RESTRICT
);

CREATE TABLE LikePost(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    UNIQUE(post_id,user_id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Post(id) ON DELETE CASCADE
);

CREATE TABLE Comment(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    msg VARCHAR(400),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(post_id) REFERENCES Post(id) ON DELETE CASCADE
);

CREATE TABLE LikeComment(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    comment_id INT NOT NULL,
    user_id INT NOT NULL,
    UNIQUE(comment_id,user_id),
    FOREIGN KEY(user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY(comment_id) REFERENCES Comment(id) ON DELETE CASCADE
);

ALTER TABLE Users MODIFY avatar VARCHAR(10000);
ALTER TABLE Post MODIFY url VARCHAR(10000);
ALTER TABLE Comment DROP COLUMN nb_like;
ALTER TABLE Post DROP COLUMN nb_like;

SELECT Comment.msg, Users.username FROM Comment INNER JOIN Users ON Comment.user_id=Users.id;
SELECT Comment.msg, Post.url FROM Comment INNER JOIN Post ON Comment.post_id=Post.id;
SELECT Post.url, Users.username FROM Post INNER JOIN Users ON Post.user_id=Users.id;
SELECT Comment.msg, Users.username FROM Comment INNER JOIN Users ON Comment.user_id=Users.id WHERE Comment.post_id=48;
SELECT Users.id FROM Post INNER JOIN Users ON Post.user_id=Users.id WHERE Post.id=48;

SELECT Users.username, Comment.msg, Post.url FROM Users INNER JOIN Comment ON Users.id=Comment.user_id INNER JOIN Post ON Comment.post_id=Post.id WHERE Users.id=(SELECT Users.id FROM Post INNER JOIN Users ON Post.user_id=Users.id WHERE Post.id=48);
SELECT Users.username, Post.url, Comment.msg FROM Users INNER JOIN Post ON Users.id=Post.user_id INNER JOIN Comment ON Post.id=Comment.post_id WHERE Users.id=(SELECT Users.id FROM Post INNER JOIN Users ON Post.user_id=Users.id WHERE Post.id=48);

SELECT Users.username, Post.url, Comment.msg FROM Comment
INNER JOIN Users ON Comment.user_id=Users.id
INNER JOIN Post ON Post.user_id=Comment.user_id WHERE Users.id=(SELECT Users.id FROM Post INNER JOIN Users ON Post.user_id=Users.id WHERE Post.id=48) AND Post.id=Comment.post_id;

SELECT COUNT(post_id) FROM LikePost WHERE LikePost.post_id=39;