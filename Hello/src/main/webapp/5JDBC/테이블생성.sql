-- ȸ�����̺� ����
create table member (
    id varchar2(10) not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    regidate date default sysdate not null,
    primary key (id)
);
-- �Խ��� ���̺� ����
create table board (
    num number primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    id varchar2(10) not null, 
    postdate date default sysdate not null,
    visitcount number(6)
);

-- �ܷ�Ű �߰�
ALTER TABLE board ADD CONSTRAINT BOARD_MEM_FK FOREIGN KEY(id) REFERENCES MEMBER(id);

-- ������ ����
CREATE SEQUENCE seq_board_num MINVALUE 1 NOMAXVALUE NOCYCLE NOCACHE;

-- ���̵����� �Է�
insert into member (id, pass, name) values ('test', '1234', '�ӽ�Ʈ�غ�');
insert into board (num, title, content, id, postdate, visitcount) values(seq_board_num.nextval, '����1�Դϴ�', '����1�Դϴ�', 'test', sysdate, 0);

-- �ڸ�Ʈ �Է�
COMMENT ON COLUMN MEMBER.id IS '���̵�';
COMMENT ON COLUMN member.pass IS '�н�����';
COMMENT ON COLUMN member.name IS '�̸�';
COMMENT ON COLUMN member.regidate IS '���� ��¥';

