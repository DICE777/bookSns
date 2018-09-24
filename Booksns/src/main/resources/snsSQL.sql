DROP TABLE SNSUSER;
DROP TABLE DM_LIST;
DROP TABLE DM_CONTENT;
DROP TABLE relationship;

DROP sequence user_seq;
DROP sequence dmNum_seq;
DROP sequence dmContentId_seq;
DROP sequence rNum_seq;

----SNSUSER----

CREATE TABLE SNSUSER(
		userNum number primary key,
		userId VARCHAR2(50) NOT NULL,
		email VARCHAR2(300) NOT NULL,
		userPwd VARCHAR2(100) NOT NULL,
		introduce VARCHAR2(3000) NOT NULL,
		savefile VARCHAR2(2000),
		originalfile VARCHAR2(2000)
);

create sequence user_seq;


---DM_LIST---

CREATE table DM_LIST(
    dmNum NUMBER primary key,
    fromId VARCHAR2(50),
    toId VARCHAR2(50),
    regdate DATE DEFAULT SYSDATE
);

 create sequence dmNum_seq;


---DM_CONTENT---

CREATE table DM_CONTENT(
    dmContentId NUMBER primary key,
    dmNum NUMBER,
    dmUserId  VARCHAR2(50),
    dmContent VARCHAR(1000),
    dmRegdate DATE DEFAULT SYSDATE,
    CONSTRAINT FK_dmNum FOREIGN KEY(dmNum) REFERENCES DM_LIST(dmNum)    
);


 create sequence dmContentId_seq;


commit;



----relationship----
CREATE TABLE relationship(
		rNum number primary key,
		loginId varchar2(70),
		followId varchar2(70)
);

create sequence rNum_seq;


--테스트 값--

--aaa,bbb,ccc,ddd,eee 회원가입시키기


--<aaa가 bbb를 팔로워하는 경우>--
INSERT INTO relationship
(
    RNUM,
    LOGINID,
    FOLLOWID
)
VALUES
(
rNum_seq.nextVal,
'aaa',
'bbb'
);

--<bbb가 aaa를 팔로워하는 경우>--
INSERT INTO relationship
(
    RNUM,
    LOGINID,
    FOLLOWID
)
VALUES
(
rNum_seq.nextVal,
'bbb',
'aaa'
);

--<aaa가 ccc를 팔로워하는 경우>--
INSERT INTO relationship
(
    RNUM,
    LOGINID,
    FOLLOWID
)
VALUES
(
rNum_seq.nextVal,
'aaa',
'ccc'
);

--<ccc가 aaa를 팔로워하는 경우>--
INSERT INTO relationship
(
    RNUM,
    LOGINID,
    FOLLOWID
)
VALUES
(
rNum_seq.nextVal,
'ccc',
'aaa'
);

INSERT INTO relationship
(
    RNUM,
    LOGINID,
    FOLLOWID
)
VALUES
(
rNum_seq.nextVal,
'aaa',
'ddd'
);

commit;
