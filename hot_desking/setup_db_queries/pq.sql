CREATE TABLE users (
    ID int,
    username varchar(255) NOT NULL,
    PRIMARY KEY (ID)
);

INSERT INTO users
    VALUES
    (1, 'Aleksander'),
    (2, 'Morty'),
    (3, 'Rick');
