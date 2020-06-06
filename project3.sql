
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

select pass from membership WHERE id='hihi' and NAME='상구' and email='gur9595@naver.com';

CREATE TABLE multi_board(
	num INT NOT NULL auto_increment,
	title VARCHAR(100) not null,
	content text not null,
	id varchar(30) not null,
	postdate datetime default current_timestamp,
	visitcount mediumint(10) NOT NULL DEFAULT 0,
	PRIMARY KEY (num)
);

DROP TABLE multi_board;
# 회원테이블과 게시판테이블의 참조 제약조건
alter TABLE multi_board ADD constraint fk_multiboard_membership
FOREIGN KEY (id) REFERENCES membership (id);

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다1', '내용입니다1','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다2', '내용입니다2','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다3', '내용입니다3','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다4', '내용입니다4','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다5', '내용입니다5','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다6', '내용입니다6','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다7', '내용입니다7','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다8', '내용입니다8','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다9', '내용입니다9','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다10', '내용입니다10','kosmo');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다11', '내용입니다11','kosmo');


#member테이블과 외래키 제약조건이 있으므로 
#board테이블에 먼저 삽입할 경우 에러가 발생한다
INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다1', '내용입니다1','hihi');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다2', '내용입니다2','hihi');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다3', '내용입니다3','hihi');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다4', '내용입니다4','hihi');

INSERT INTO multi_board (title, content, id)
VALUES ('제목입니다5', '내용입니다5','hihi');


select id, pass, name from membership where id='hihi' and pass='1234' and authority='admin';

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 공지사항1','내용없음1', 'hihi','notice');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 공지사항2','내용없음2', 'hi123','notice');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 공지사항3','내용없음3', 'hihi','notice');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 공지사항4','내용없음4', 'hi123','notice');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 공지사항5','내용없음5', 'hihi','notice');



INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 정보자료1','내용없음1', 'hihi','info');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 정보자료2','내용없음2', 'hi123','info');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 정보자료3','내용없음3', 'hihi','info');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 정보자료4','내용없음4', 'hi123','info');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 정보자료5','내용없음5', 'hihi','info');


INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료1','내용없음1', 'hihi','staff');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료2','내용없음2', 'hi123','staff');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료3','내용없음3', 'hihi','staff');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료4','내용없음4', 'hi123','staff');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료5','내용없음5', 'hihi','staff');


INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료1','내용없음1', 'hihi','bohoja');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료2','내용없음2', 'hi123','bohoja');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료3','내용없음3', 'hihi','bohoja');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료4','내용없음4', 'hi123','bohoja');

INSERT INTO multi_board(title , content, id, bname)
VALUES( '여긴 직원자료5','내용없음5', 'hihi','bohoja');





