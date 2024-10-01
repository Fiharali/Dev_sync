CREATE TABLE public.users
(
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    prenom VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    userType userType NOT NULL
);





CREATE TYPE userType AS ENUM ('USER', 'MANAGER');



select * from users;


drop  table  users;

ALTER TABLE users
   add  column  userType varchar(255);



