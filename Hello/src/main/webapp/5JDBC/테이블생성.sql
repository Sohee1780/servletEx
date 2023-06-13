-- 회원테이블 생성
create table member (
    id varchar2(10) not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    regidate date default sysdate not null,
    primary key (id)
);
-- 게시판 테이블 생성
create table board (
    num number primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    id varchar2(10) not null, 
    postdate date default sysdate not null,
    visitcount number(6)
);

-- 외래키 추가
ALTER TABLE board ADD CONSTRAINT BOARD_MEM_FK FOREIGN KEY(id) REFERENCES MEMBER(id);

-- 시퀀스 생성
CREATE SEQUENCE seq_board_num MINVALUE 1 NOMAXVALUE NOCYCLE NOCACHE;

-- 더미데이터 입력
insert into member (id, pass, name) values ('test', '1234', '머스트해브');
insert into board (num, title, content, id, postdate, visitcount) values(seq_board_num.nextval, '제목1입니다', '내용1입니다', 'test', sysdate, 0);

-- 코멘트 입력
COMMENT ON COLUMN MEMBER.id IS '아이디';
COMMENT ON COLUMN member.pass IS '패스워드';
COMMENT ON COLUMN member.name IS '이름';
COMMENT ON COLUMN member.regidate IS '가입 날짜';

