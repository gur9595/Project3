
-- 회원 테이블
create table membership(
    id VARCHAR(30) not null,
    name VARCHAR(30) not null,
    pass VARCHAR(30) not null,
    tel VARCHAR(30),
    mobile VARCHAR(30) not null,
    email VARCHAR(30) not null,
    zip VARCHAR(30) not null,
    addr VARCHAR(30) not null,
    joinDate datetime default current_timestamp,
    authority VARCHAR(30) DEFAULT 'normal',
    primary KEY(id)
);

DROP TABLE membership;

insert into membership(id,name,pass,tel,mobile,email,zip,addr) 
VALUES('hong1','홍길동','1234','02-5555-5555','010-2222-2222','hong1@naver.com','1111-2222','아이티벤처타워');


select id from membership where NAME='상구' and email='gur9595@naver.com';





























