CREATE TABLE membership(
    tier varchar2(50) NOT NULL,
    per number NOT NULL,
    CONSTRAINT membership_pk PRIMARY KEY(tier)
);

CREATE TABLE member(
    mnum number NOT NULL,
	mid varchar2(50), 
	mpw varchar2(100) NOT NULL, 
	mname varchar2(50) NOT NULL,
	mtel varchar2(50) NOT NULL,
    maddr varchar2(100) NOT NULL,
    mpnum number NOT NULL,
    mnutr1 varchar2(50) NOT NULL,
    mnutr2 varchar2(50) NOT NULL,
    mnutr3 varchar2(50) NOT NULL,
    mdiet varchar2(50) NOT NULL,
    mtier varchar2(50) NOT NULL,
    mrdate date DEFAULT sysdate NOT NULL,
	mtotal number NOT NULL,
    is_sale varchar2(5) DEFAULT 'Y',
    is_alive varchar2(5) DEFAULT 'Y'
);
alter table product  modify mdiet null;
alter table member add CONSTRAINT member_pk PRIMARY KEY(mnum);
alter table member add constraint member_fk FOREIGN KEY(mtier) REFERENCES membership(tier);

--ALTER TABLE 테이블명 MODIFY 컬럼명 컬럼명의_데이터타입(크기) DEFAULT 값;
alter table product modify is_sale varchar2(5) default 'N';
alter table qna modify is_replyed varchar2(5) default 'N';

CREATE TABLE member_auth(
	mnum number NOT NULL, 
	auth varchar2(50) NOT NULL, 
	CONSTRAINT member_auth_fk FOREIGN KEY(mnum) REFERENCES member(mnum)
); 

CREATE TABLE persistent_logins(
	username varchar2(64) NOT NULL,
	series varchar2(64) PRIMARY KEY, 
	token varchar2(64) NOT NULL, 
	last_used timestamp NOT NULL
); 

create table address(
    mnum number NOT NULL,
    rep varchar2(50) NOT NULL,
    alias varchar2(50) NOT NULL,
    addr varchar2(50) NOT NULL,
    pnum varchar2(50) NOT NULL,
    reptel varchar2(50) NOT NULL,
    CONSTRAINT address_fk FOREIGN KEY(mnum) REFERENCES member(mnum)
);

create table cart(
    mnum number NOT NULL constraint cart_fk1 references member(mnum),
    pnum number NOT NULL constraint cart_fk2 references product(pnum),
    pcount number NOT NULL
);

create table alarm(
    anum number NOT NULL constraint alarm_PK primary key,
    mnum number NOT NULL constraint alarm_fK references member(mnum),
    atype varchar2(20) NOT NULL,
    acnt varchar2(100) NOT NULL,
    ardate date Default sysdate NOT NULL,
    is_read varchar2(5) default 'N'
);

create sequence alarm_seq nocache;
create sequence sub_seq nocache;

create table subscription(
    subnum number NOT NULL constraint sub_PK primary key,
    summnum number NOT NULL constraint sub_fK references member(mnum),
    subend date NOT NULL,
    subpnum number NOT NULL constraint sub_fK2 references product(pnum)
);

create table preview(
    rnum number NOT NULL constraint preview_PK primary key,
    rtilte varchar2(50) NOT NULL,
    rcnt varchar2(50) NOT NULL,
    pnum number constraint preview_fK references product(pnum),
    mnum number constraint preview_fK2 references member(mnum),
    rdate date Default sysdate NOT NULL,
    rstar float default '5.0' NOT NULL 
);
COMMIT;