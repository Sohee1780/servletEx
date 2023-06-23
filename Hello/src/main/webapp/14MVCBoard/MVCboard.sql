-- 모델2방식의 파일첨부형 게시판 테이블 생성
CREATE TABLE mvcboard (
    idx NUMBER NOT NULL PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    postdate DATE DEFAULT SYSDATE NOT NULL,
    ofile VARCHAR2(200),
    sfile VARCHAR2(30),
    downcount NUMBER DEFAULT(0) NOT NULL,
    pass VARCHAR2(50) NOT NULL,
    visitcount NUMBER DEFAULT(0) NOT NULL
);

-- 시퀀스 생성
CREATE SEQUENCE seq_mvcboard_num START WITH 0 MINVALUE 0;

-- 테스트데이터 입력
INSERT INTO mvcboard VALUES(seq_mvcboard_num.nextval, 'test1', '테스트1', '테스트입니다1', 
    SYSDATE, 'setCharacter.PNG', 'setCharacter.PNG', 0, '1234', 0);
    
-- 페이징처리
select * from (
    select rownum rn, t.* from(
        select *
        from mvcboard
        order by idx desc
    ) t
)where rn between 1 and 10;

-- 비밀번호 검증
SELECT * FROM mvcboard WHERE idx = 48 and pass='1234';

-- 게시글 한게 선택
SELECT idx, name, title, content, postdate, ofile, sfile, downcount, visitcount 
FROM mvcboard
WHERE idx=48;

-- 업데이트

-- 딜리트
DELETE FROM mvcboard WHERE idx = 48;