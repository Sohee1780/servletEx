
--파일 업로드와 다운로드를 위한 테이블 생성
create table myfile(
    idx number not null PRIMARY KEY, -- 시퀀스
    name varchar2(50) NOT NULL, -- form 전달
    title varchar2(200) NOT NULL, -- form 전달
    cate varchar2(30) , -- form 전달
    ofile varchar2(100) NOT NULL,
    sfile varchar2(30) NOT NULL,
    pstdate date  DEFAULT sysdate NOT NULL
);

-- 시퀀스 생성
create sequence seq_file_board_num;

-- 데이터 입력
INSERT INTO myfile(idx, name, title, cate, ofile, sfile) 
VALUES(seq_file_board_num.nextval, '하니', '제목', '카테고리', 'abc.txt', 'abc_20230621112622.txt');

-- 데이터 조회
SELECT * FROM myfile ORDER BY idx DESC;