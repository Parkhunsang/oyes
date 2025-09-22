-- 회원(환자) 테이블
create table member(
	patient_no	number(10) PRIMARY KEY	,
	patient_id	varchar2(20)	not null	,
	password	varchar2(60)	not null	,
	patient_name	varchar2(20)	not null	,
	birth_date	varchar2(8)	not null	,
	mobile_no	varchar2(12)	not null	,
	email	varchar2(50)	not null	,
	is_admin	char(1)	default 'n' not null	,
	create_date	date	not null	,
	update_date	date	,
	is_active	char(1)	default 'y' not null	,
	constraint uq_member_id UNIQUE (patient_id)
);
select * from MEMBER;
update member set password = '$2a$10$aR2RJg6xxvzh8Zu2loU31e2HU195CNTI7cXH5qAkjrQ9jytKQ0T/K';
update member set is_active = 'y';

SELECT owner, table_name, constraint_name, r_owner, r_constraint_name
FROM all_constraints
WHERE constraint_name = 'FK_COMPLIMENT_PATIENT';
-- 부서테이블
CREATE TABLE department (
  department_id             NUMBER(19) ,
  department_name           VARCHAR2(100)      NOT NULL,
  department_summary        VARCHAR2(500),
  department_intro          varchar2(1000),
  department_description    varchar2(4000),
  department_hero_image_url VARCHAR2(500),
  department_small_img 		VARCHAR2(500),
  department_place_img 		VARCHAR2(500),
  department_is_active      CHAR(1) DEFAULT 'Y' NOT NULL, -- 'Y'/'N'
  department_created_date   DATE  DEFAULT SYSDATE NOT NULL,
  department_updated_date   DATE  DEFAULT SYSDATE NOT NULL,
  CONSTRAINT pk_department PRIMARY KEY (department_id),
  CONSTRAINT ck_department_active CHECK (department_is_active IN ('Y','N'))
);
ALTER TABLE department ADD (department_intro VARCHAR2(1000));

drop table department cascade constraints;
-- 의사 테이블
CREATE TABLE doctor (
  doctor_id                 NUMBER(19) ,
  doctor_name               VARCHAR2(50)       NOT NULL, -- 이름
  doctor_title              VARCHAR2(100),				 -- 직함
  doctor_profile_image  	VARCHAR2(500),				 -- 초상 이미지
  doctor_doctor_specialty   VARCHAR2(200),     --  전문 진료 분야 
  doctor_is_active          CHAR(1) DEFAULT 'Y' NOT NULL, -- 'Y'/'N'
  doctor_created_at         DATE  DEFAULT SYSDATE NOT NULL,
  doctor_updated_at         DATE  DEFAULT SYSDATE NOT NULL,
  department_id 			NUMBER(19) references department(department_id),
  center_id                 NUMBER(19) references center(center_id),
  CONSTRAINT pk_doctor PRIMARY KEY (doctor_id),
  CONSTRAINT ck_doctor_active CHECK (doctor_is_active IN ('Y','N'))
  );
select * from DOCTOR;

drop table doctor cascade constraints;
-- 의사 부서테이블
CREATE TABLE doctor_department (
  doctor_id           NUMBER(19) NOT NULL,
  department_id       NUMBER(19) NOT NULL,
  role_in_department  VARCHAR2(100),
  CONSTRAINT pk_doctor_department PRIMARY KEY (doctor_id, department_id),
  CONSTRAINT fk_dd_doctor
    FOREIGN KEY (doctor_id)     REFERENCES doctor(doctor_id),
  CONSTRAINT fk_dd_department
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

drop table doctor_department cascade constraints;
--센터 의사 테이블
CREATE TABLE center_doctor (
	num	number(19) primary key,
	doctor_id      NUMBER(19) ,
	center_id      NUMBER(19) ,
	CONSTRAINT fk_cd_doctor FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
	CONSTRAINT fk_cd_center FOREIGN KEY (center_id) REFERENCES center(center_id)
);

drop table center_doctor cascade constraints;
-- 클리닉 세션 테이블
CREATE TABLE clinic_session (
	clinic_id       NUMBER(19),
	doctor_id       NUMBER(19)  NOT NULL,
	visit_type      VARCHAR2(15) NOT NULL CHECK (visit_type IN ('외래진료', '휴진', '공휴일')), 
	reservation_date date,
	CONSTRAINT pk_clinic_session PRIMARY KEY (clinic_id),
	CONSTRAINT fk_cs_doctor      FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

drop table clinic_session cascade constraints;
--의료진 정보(학위, 경력, 논문 등..)를 위한 TABLE 추가
CREATE TABLE doctor_extra(
	extra_id		NUMBER(19),
	doctor_id      NUMBER(19),
	sort_code      number(2) not null, --1 : 학력사항, 2 : 교육 및 연구경력, 3 : 기타 학술 관련 경력, 4 : 논문 및 저서
	extra_data	   varchar2(1000),		
	CONSTRAINT pk_doctor_extra PRIMARY KEY (extra_id),
	CONSTRAINT fk_de_doctor    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

drop table doctor_extra cascade constraints;
-- 센터 테이블
CREATE TABLE center (
  center_id               NUMBER(19),
  center_name             VARCHAR2(100)      NOT NULL,
  center_summary          VARCHAR2(500),
  center_description      VARCHAR2(4000),
  center_small_img        VARCHAR2(500),
  center_hero_image_url   VARCHAR2(500),
  center_place_img 	  	  VARCHAR2(500),
  center_is_active        CHAR(1) DEFAULT 'Y' NOT NULL, -- 'Y'/'N'
  center_created_date     TIMESTAMP(6) DEFAULT SYSTIMESTAMP NOT NULL,
  center_updated_date     TIMESTAMP(6) DEFAULT SYSTIMESTAMP NOT NULL,
  CONSTRAINT pk_center PRIMARY KEY (center_id),
  CONSTRAINT ck_center_active CHECK (center_is_active IN ('Y','N'))
);

drop table center cascade constraints;
-- 고객서비스 - 칭찬합니다 Table
create table compliment (
    compliment_no    number(10)		 GENERATED ALWAYS AS IDENTITY	PRIMARY KEY              ,
    patient_no       number(10)      not null                 ,
    compliment_open  number(1)       not null                 ,
    compliment_title varchar2(100)    not null                 ,
    compliment_for   varchar2(100)    ,
    doctor_id       number(19)      ,
    compliment_content varchar2(3000)  not null                 ,
    create_date     date            not null                 ,
    is_active       char(1)         default 'y' not null     ,
    constraint fk_compliment_patient foreign key (patient_no) references member(patient_no)  ,
    constraint fk_compliment_doctor foreign key (doctor_id) references doctor(doctor_id)  ,
    constraint ck_compliment_active check (is_active in ('y','n')),
    constraint ck_compliment_open check (compliment_open between 1 and 2)
    
);

select * from COMPLIMENT;
-- 고객서비스 - 건의합니다 Table
create table proposal (
    proposal_no      number(10)      GENERATED ALWAYS AS IDENTITY	PRIMARY KEY              ,
    patient_no       number(10)      not null                 ,
    related         number(1)       ,
    proposal_title   varchar2(100)    not null                 ,
    proposal_type    number(1)       default '1' not null     ,
    proposal_content varchar2(3000)  not null                 ,
    create_date     date            not null                 ,
    is_active       char(1)         default 'y' not null     ,
    progress        number(1)       default '1' not null     ,
    for_patient_no	number(10)		,
    for_patient_name	varchar2(20),
    constraint fk_proposal_patient foreign key (patient_no) references member(patient_no) ,
    constraint ck_proposal_active check (is_active in ('y','n')),
    constraint ck_proposal_related check (related between 1 and 4),
    constraint ck_proposal_type check (proposal_type between 1 and 3),
    constraint ck_proposal_progress check (progress between 1 and 3)
);

select * from PROPOSAL;
-- 고객서비스 - 건의합니다 답변테이블
create table proposal_reply (
    reply_no      number(10)      	PRIMARY KEY              ,
    patient_no      number(10)      not null                 ,
    reply_content varchar2(1000)    not null				 ,
    create_date     date            not null                 ,
    is_active       char(1)         default 'y' not null     ,
    proposal_no     number(10)      not null                 ,
    constraint fk_reply_patient foreign key (patient_no) references member(patient_no)  ,
    constraint fk_re_propno foreign key (proposal_no) references proposal(proposal_no)  ,
    constraint ck_prop_re_active check (is_active in ('y','n'))
);


-- 공지사항,보도자료 보드테이블
CREATE TABLE board (
	boardno	number	PRIMARY KEY	,
	patient_no	number(10)	not null	,
	board_title	varchar2(100)	not null	,
	board_content	varchar2(50)	not null	,
	board_readCnt	varchar2(100)	not null	,
	board_file	varchar2(500)	,
	board_type	char(1)	not null	,
	board_create_date	date	,
	board_update_date	date	,
	board_is_active	char(1)	default 'n' not null
);

-- table drop
drop table compliment cascade constraints;
drop table proposal cascade constraints;
drop table department;
drop table doctor cascade constraints;
drop table doctor_department;
drop table clinic_session;
drop table center;
drop table center_doctor;
drop table member;



-- fake data --
-- member
insert into member values (10000000,'admin1','1','관리자','19700101','01011111111','admin1@oyes.com','y',sysdate,sysdate,'n');
insert into member values (10000001,'patient1','1','홍길동','19800101','01011111112','patient1@oyes.com','y',sysdate,sysdate,'n');
insert into member values (10000002,'patient2','1','사임당','19900101','01011111113','patient2@oyes.com','y',sysdate,sysdate,'n');
insert into member values (10000003,'patient3','1','김유신','20000101','01011111114','patient3@oyes.com','y',sysdate,sysdate,'n');
insert into member values (10000004,'patient4','1','이순신','19751212','01011111115','patient4@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000005,'patient5','1','강감찬','19850305','01011111116','patient5@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000006,'patient6','1','장보고','19920214','01011111117','patient6@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000007,'patient7','1','유관순','20010421','01011111118','patient7@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000008,'patient8','1','안중근','19881111','01011111119','patient8@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000009,'patient9','1','윤봉길','19971117','01011111120','patient9@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000010,'patient10','1','신사임당','19790909','01011111121','patient10@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000011,'patient11','1','김구','19840606','01011111122','patient11@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000012,'patient12','1','정약용','19930615','01011111123','patient12@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000013,'patient13','1','허준','20001225','01011111124','patient13@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000014,'patient14','1','최무선','19730303','01011111125','patient14@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000015,'patient15','1','이이','19891010','01011111126','patient15@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000016,'patient16','1','정몽주','19951212','01011111127','patient16@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000017,'patient17','1','이황','20030630','01011111128','patient17@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000018,'patient18','1','세종대왕','19771107','01011111129','patient18@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000019,'patient19','1','장영실','19861218','01011111130','patient19@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000020,'patient20','1','김홍도','19991205','01011111131','patient20@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000021,'patient21','1','이방원','20020502','01011111132','patient21@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000022,'patient22','1','신채호','19820820','01011111133','patient22@oyes.com','n',sysdate,sysdate,'n');
insert into member values (10000023,'patient23','1','김좌진','19940914','01011111134','patient23@oyes.com','n',sysdate,sysdate,'n');

-- compliment
-- doctor_id 1 ~ 19, compliment_open = 1
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000001, 1, '세심한 진료에 감사드립니다', '이홍수 교수님', 1, '이홍수 교수님께서는 항상 환자의 이야기를 끝까지 경청해 주십니다. 어려운 의학 용어도 쉽게 풀어 설명해 주셔서 치료 방향을 이해하는 데 많은 도움이 되었습니다. 환자와 보호자 모두에게 따뜻한 마음으로 대해 주셔서 큰 힘이 되었습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000002, 1, '항상 친절하게 대해주셔서 감사합니다', '전혜진 교수님', 2,'전혜진 교수님은 진료실에 들어서는 순간부터 환자가 편안함을 느낄 수 있도록 밝은 미소로 맞아 주십니다. 상담 과정에서도 꼼꼼하게 체크해 주시고, 생활습관 개선 방법까지 자세히 알려주셨습니다. 덕분에 진료 이후에도 건강관리에 자신감이 생겼습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000003, 1, '믿음직스러운 설명과 진료', '김장수 교수님', 3,'김장수 교수님께서는 검사 결과를 이해하기 쉽게 정리해 주시고, 앞으로의 치료 계획도 단계별로 안내해 주셨습니다. 환자의 작은 질문에도 성심껏 답해 주셔서 신뢰가 갔습니다. 환자로서 안심하며 치료받을 수 있어 정말 감사드립니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000004, 1, '편안한 분위기 속 진료', '정하윤 교수님', 4,'정하윤 교수님은 환자가 불안해하지 않도록 차분하고 따뜻한 말투로 상담을 이끌어 주셨습니다. 어려운 치료 과정임에도 긍정적인 에너지를 주셔서 많이 위로받았습니다. 교수님의 배려와 친절함 덕분에 치료에 임하는 마음이 훨씬 가벼워졌습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000005, 1, '정성 어린 진료 감사합니다', '강도현 교수님', 5,'강도현 교수님께서는 늘 꼼꼼하게 환자의 상태를 살펴 주십니다. 설명도 명확해서 무엇을 준비하고 어떻게 관리해야 하는지 쉽게 알 수 있었습니다. 환자를 가족처럼 챙겨 주셔서 진심으로 감사드립니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000006, 1, '환자 중심의 따뜻한 진료', '송예은 교수님', 6,'송예은 교수님은 환자의 이야기를 하나도 놓치지 않고 들어주십니다. 치료 방법을 여러 가지로 비교해 주시면서 환자가 선택할 수 있도록 배려해 주셨습니다. 덕분에 치료 과정이 훨씬 투명하고 믿음직하게 느껴졌습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000007, 1, '정확하고 신속한 진단', '김경호 교수님', 7,'김경호 교수님은 증상을 듣자마자 필요한 검사를 빠르게 안내해 주셨습니다. 결과 설명도 명확하여 앞으로의 치료 방향을 쉽게 이해할 수 있었습니다. 환자 입장에서 꼭 필요한 조언만 해 주셔서 큰 도움이 되었습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000008, 1, '마음을 편하게 해 주신 교수님', '강혜지 교수님', 8,'강혜지 교수님은 환자가 걱정하는 부분을 먼저 물어봐 주셔서 긴장이 풀렸습니다. 차분하고 친절한 상담 덕분에 검사 과정도 두려움 없이 받을 수 있었습니다. 따뜻하게 배려해 주셔서 진심으로 감사드립니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000009, 1, '세밀한 진료와 배려', '순정석 교수님', 9,'순정석 교수님께서는 작은 변화도 놓치지 않고 살펴 주십니다. 검사 결과를 설명할 때도 환자의 입장에서 이해할 수 있도록 차근차근 알려주셨습니다. 늘 환자를 존중하는 태도에서 큰 감동을 받았습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000010, 1, '정확한 진단과 따뜻한 상담', '이서연 교수님', 10,'이서연 교수님은 환자의 불편함을 끝까지 경청하시고 정확한 진단을 내려 주셨습니다. 치료 방향도 현실적으로 제시해 주셔서 믿음이 갔습니다. 환자로서 안심할 수 있는 시간을 만들어 주셔서 감사합니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000011, 1, '항상 환자 입장에서 생각해주심', '박민수 교수님', 11,'박민수 교수님은 치료 과정에서 불편하지 않도록 세심하게 배려해 주셨습니다. 환자의 사정을 충분히 고려하여 진료 계획을 짜 주셨습니다. 덕분에 신뢰를 가지고 치료에 임할 수 있었습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000012, 1, '믿음을 주는 상담', '정유진 교수님', 12,'정유진 교수님은 환자의 질문에 친절하고도 자세히 답변해 주셨습니다. 어려운 상황에서도 긍정적인 희망을 주셔서 마음이 놓였습니다. 늘 따뜻하게 대해 주셔서 감사합니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000013, 1, '꼼꼼하고 세심한 진료', '오지훈 교수님', 13,'오지훈 교수님은 진료 전부터 환자가 이해하기 쉽게 설명해 주셨습니다. 검사 과정에서도 불편함이 없도록 계속 확인해 주셨습니다. 환자를 가족처럼 대하시는 모습에 큰 감동을 받았습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000014, 1, '늘 따뜻한 마음으로 대해주셔서 감사드립니다', '한지민 교수님', 14,'한지민 교수님은 환자의 사정을 충분히 고려해 주시며 상담해 주셨습니다. 차분하고 친절한 태도 덕분에 큰 위로를 받았습니다. 치료 과정을 긍정적으로 이어갈 수 있도록 도와주셔서 감사합니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000015, 1, '환자와 함께하는 진료', '최우성 교수님', 15,'최우성 교수님은 환자의 의견을 존중하며 치료 방향을 같이 상의해 주셨습니다. 그 과정에서 환자로서 존중받고 있다는 느낌을 받았습니다. 덕분에 치료에 대한 부담이 줄어들고 신뢰가 커졌습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000016, 1, '정성과 배려에 감사드립니다', '서다인 교수님', 16,'서다인 교수님은 늘 밝은 미소와 따뜻한 말씀으로 환자를 맞아 주십니다. 상담 중에도 작은 부분까지 놓치지 않고 설명해 주셔서 도움이 되었습니다. 환자 중심으로 생각해 주시는 모습에 감동했습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000017, 1, '믿음직한 교수님께 감사드립니다', '조윤호 교수님', 17,'조윤호 교수님은 환자의 증상과 고민을 끝까지 들어주시고 최선의 방법을 제시해 주셨습니다. 치료 과정에서도 언제든 궁금한 점을 해결해 주셨습니다. 환자를 존중하는 태도에 큰 감사의 마음을 전합니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000018, 1, '항상 따뜻하게 대해 주셔서 감사합니다', '이은지 교수님', 18,'이은지 교수님은 처음부터 끝까지 환자의 불편함을 최소화하려 노력하셨습니다. 치료 방향을 명확히 설명해 주셔서 믿음이 갔습니다. 따뜻하고 세심한 배려에 큰 감사를 드립니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000019, 1, '환자를 존중하는 교수님', '박시우 교수님', 19,'박시우 교수님은 환자의 의견을 존중하시고, 진료 과정에서도 충분히 설명해 주셨습니다. 언제나 환자 입장에서 배려해 주셔서 신뢰가 갔습니다. 덕분에 치료를 이어가는 힘이 되었습니다.', sysdate, 'y');

-- compliment_open = 2, 추가 8건
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000001, 2, '공개적으로 감사드립니다', '이홍수 교수님', 1,'교수님의 따뜻한 말씀과 진료 덕분에 치료 과정을 긍정적으로 이어갈 수 있었습니다. 설명도 명확하고 친절하여 환자로서 믿음이 갔습니다. 많은 환자들에게도 교수님의 따뜻함이 전달되길 바랍니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000002, 2, '환자에게 힘이 되어주셔서 감사합니다', '김장수 교수님', 3,'김장수 교수님은 항상 진심을 다해 환자를 돌봐 주십니다. 어려운 순간마다 희망을 주셔서 감사드립니다. 공개적으로 이 감사의 마음을 전하고 싶습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000003, 2, '언제나 믿음직한 교수님', '정하윤 교수님', 4,'정하윤 교수님은 작은 부분까지 놓치지 않고 세심하게 살펴 주십니다. 환자가 안심할 수 있도록 차분한 설명과 배려를 해 주셨습니다. 교수님의 따뜻함을 많은 분들과 나누고 싶습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000004, 2, '따뜻한 진료에 감사드립니다', '강도현 교수님', 5,'강도현 교수님은 항상 환자의 이야기를 먼저 들어 주시고 최선의 방법을 제시해 주십니다. 환자 중심으로 생각해 주셔서 늘 감사드립니다. 이 마음을 공개적으로 전하고 싶습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000005, 2, '항상 환자를 먼저 생각해주십니다', '강혜지 교수님', 8,'강혜지 교수님은 환자의 입장에서 늘 배려해 주십니다. 치료 과정에서 큰 힘이 되었고 안심할 수 있었습니다. 진심으로 감사드리며 많은 분들과 이 마음을 나누고 싶습니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000006, 2, '따뜻한 말 한마디가 큰 힘이 됩니다', '순정석 교수님', 9,'순정석 교수님은 진료 내내 따뜻한 말 한마디로 환자의 마음을 편하게 해 주셨습니다. 검사와 치료 과정에서 큰 용기를 얻었습니다. 공개적으로 감사의 마음을 전합니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000007, 2, '믿고 맡길 수 있는 교수님', '최우성 교수님', 15,'최우성 교수님은 환자와 함께 치료 방향을 상의해 주시며 늘 신뢰를 주십니다. 환자 중심의 배려 깊은 진료에 감사드립니다. 많은 환자들에게도 이 따뜻함이 전해지길 바랍니다.', sysdate, 'y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active)
values (10000008, 2, '교수님의 배려에 감사드립니다', '박시우 교수님', 19,'박시우 교수님은 언제나 차분하고 친절하게 대해 주십니다. 환자의 의견을 존중하며 치료해 주셔서 신뢰가 깊어졌습니다. 공개적으로 감사드리며 존경을 표합니다.', sysdate, 'y');


-- proposal
insert into proposal (patient_no,related,proposal_title,proposal_type,proposal_content,create_date,is_active,progress,for_patient_name,for_patient_no ) 
values (10000001, 1,'A병동 입구쪽 엘리베이터 버튼 고장', 2, '메인홀에서 A병동 들어가는 입구쪽 엘리베이터 4개 중에 왼쪽 첫번째 엘리베이터의 닫힘버튼과 12층 버튼이 눌려지지 않습니다. 확인 바랍니다', sysdate, 'y', 1,'A병동',null);
insert into proposal (patient_no,related,proposal_title,proposal_type,proposal_content,create_date,is_active,progress,for_patient_name,for_patient_no ) 
values (10000002, 2,'퇴원 후 영수증 발급', 3, '퇴원 후 영수증 발급은 방문으로만 가능한가요?', sysdate, 'y', 2, '이순신',10000004);
insert into proposal (patient_no,related,proposal_title,proposal_type,proposal_content,create_date,is_active,progress,for_patient_name,for_patient_no ) 
values (10000003, 3,'건의사항', 3, '진료과 입구에 키오스크 위치와 사용방법 크게 적어서 표시해 두는 것은 어떠신가요? 어르신들이나 초행인 사람들이 도우미 분을 잘 발견하지 못하고 키오스크 사용법이나 위치도 잘 모르는 경우가 많습니다. 개선할 수 있으면 좋겠어요.', sysdate, 'y', 3, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000004, 1, '주차장 결제기 오류', 2, '외래 진료 후 주차장에서 자동 결제기를 사용했는데 카드 인식이 잘 안 되었습니다. 기기 점검을 부탁드립니다.', sysdate, 'y', 1, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000005, 3, '진료 대기 안내 전광판 개선 요청', 3, '대기번호 안내 전광판 글씨가 작아 멀리서 보기가 어렵습니다. 글씨 크기를 키우거나 음성 안내를 추가하면 좋겠습니다.', sysdate, 'y', 2, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000006, 2, '원무과 전화 연결 지연', 1, '퇴원 정산 관련 문의로 전화를 여러 번 걸었으나 연결이 잘 되지 않았습니다. 개선이 필요해 보입니다.', sysdate, 'y', 3, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000007, 1, '진료 안내 표지판 위치', 3, '진료과 위치를 찾기 어려워 헤맸습니다. 주요 지점마다 표지판을 더 설치하면 방문객들에게 도움이 될 것 같습니다.', sysdate, 'y', 2, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000008, 2, '병실 내 와이파이 속도 문제', 2, '병실에서 제공되는 와이파이가 너무 느려서 사용하기 불편합니다. 속도 개선을 부탁드립니다.', sysdate, 'y', 1, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000009, 3, '수납 창구 대기시간 단축 요청', 1, '수납 창구에서 대기 시간이 너무 길어 불편했습니다. 창구 인원을 늘리거나 무인 수납기를 더 설치해 주시면 좋겠습니다.', sysdate, 'y', 3, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000010, 1, '엘리베이터 층수 버튼 인식 불량', 2, '본관 엘리베이터의 일부 층수 버튼이 잘 눌리지 않습니다. 빠른 수리 부탁드립니다.', sysdate, 'y', 2, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000011, 2, '카페 운영 시간 연장 요청', 3, '병원 내 카페 운영 시간이 너무 짧아 이용이 불편합니다. 저녁 진료 후에도 이용할 수 있도록 운영 시간을 연장하면 좋겠습니다.', sysdate, 'y', 1, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000012, 1, '수술 안내 문자 서비스 문의', 1, '수술 일정이나 회복실 이동 시 보호자에게 문자로 안내가 오면 훨씬 편리할 것 같습니다. 서비스 도입을 검토해 주시기 바랍니다.', sysdate, 'y', 3, '이순신',10000004);
insert into proposal (patient_no, related, proposal_title, proposal_type, proposal_content, create_date, is_active, progress,for_patient_name,for_patient_no)
values (10000013, 3, '장애인 전용 화장실 보완 필요', 2, '장애인 전용 화장실의 손잡이가 헐거워 안전에 위험이 있습니다. 빠른 보수를 요청드립니다.', sysdate, 'y', 2, '이순신',10000004);


-- proposal reply
insert into proposal_reply values (1, 10000000, '해당 건의사항 내부 회의중에 있습니다. 좋은 의견 알려주셔서 감사합니다. 더 나은 oyes병원이 되도록 하겠습니다.',sysdate,'y',3);

-- Example INSERT statement for the department table
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '가정의학과', 'smallImg1.jpg', 'placeImg1.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '감염내과','smallImg2.jpg', 'placeImg2.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '건진의학과','smallImg3.jpg', 'placeImg3.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '관절류마티스내과','smallImg4.jpg', 'placeImg4.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '구강악안면내과','smallImg5.jpg', 'placeImg5.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img) values ((select nvl(max(department_id)+1,1) from department), '내과','smallImg6.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '내분비내과','smallImg7.jpg', 'placeImg7.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img) values ((select nvl(max(department_id)+1,1) from department), '마취통증의학과','smallImg8.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '방사선종양학과','smallImg9.jpg', 'placeImg9.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '병리과','smallImg10.jpg', 'placeImg10.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '비뇨의학과','smallImg11.jpg', 'placeImg11.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '산부인과','smallImg12.jpg', 'placeImg12.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '성형외과','smallImg13.jpg', 'placeImg13.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '소아청소년과','smallImg14.jpg', 'placeImg14.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '소화기내과','smallImg15.jpg', 'placeImg15.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '순환기내과','smallImg16.jpg', 'placeImg16.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img) values ((select nvl(max(department_id)+1,1) from department), '신경과','smallImg17.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '신경외과','smallImg18.jpg', 'placeImg18.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '신장내과','smallImg19.jpg', 'placeImg19.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '심장혈관흉부외과','smallImg20.jpg', 'placeImg20.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '안과','smallImg21.jpg', 'placeImg21.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '알래르기내과','smallImg22.jpg', 'placeImg22.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '영상의학과','smallImg23.jpg', 'placeImg23.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '외과','smallImg24.jpg', 'placeImg24.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '응급의학과','smallImg25.jpg', 'placeImg25.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '이비인후과','smallImg26.jpg', 'placeImg26.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '재활의학과','smallImg27.jpg', 'placeImg27.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '정신건강의학과','smallImg28.jpg', 'placeImg28.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '정형외과','smallImg29.jpg', 'placeImg29.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '직업환경의학과','smallImg30.jpg', 'placeImg30.jpg'); 
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '진단검사의학과','smallImg31.jpg', 'placeImg31.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '치과교정과','smallImg32.jpg', 'placeImg32.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '치과보존과','smallImg33.jpg', 'placeImg33.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '치과보철과','smallImg34.jpg', 'placeImg34.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img) values ((select nvl(max(department_id)+1,1) from department), '통합내과','smallImg6.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '통합치료진료과','smallImg34.jpg', 'placeImg36.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '피부과','smallImg35.jpg', 'placeImg37.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '핵의학과','smallImg36.jpg', 'placeImg38.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '혈액종양내과','smallImg37.jpg', 'placeImg39.jpg');
insert into department (department_id, DEPARTMENT_name, department_small_img, department_place_img) values ((select nvl(max(department_id)+1,1) from department), '호흡기내과','smallImg38.jpg', 'placeImg40.jpg');

update department set 
department_summary='가족 건강 지킴이', 
department_intro='가정의학은 일차의료를 담당하는 전문 과목으로 질병의 종류에 구애받지 않고, 가족 및 그 구성원을 대상으로 지속적이고 포괄적인 진료를 제공합니다.', 
department_description='가정의학과에서는 질병 여부와 상관 없이 건강 상의 문제점에 대하여 지속적인 책임을지고, 건강 증진과 건강 유지를 위하여 치료의학적인 측면 뿐 아니라 여러가지 다양한 방법으로 접근하고 있습니다.  또한 가족 전체를 의료의 단위로 보고, 모든 가족 구성원을 대상으로 가족의 행동 역학 및 질병과의 연관성을 다루고 있습니다.', 
department_hero_image_url='img1.jpg', 
department_created_date =sysdate 
where department_name='가정의학과';

update department set 
department_summary='감염질환의 진단 및 치료', 
department_intro='감염내과는 이대서울병원 2층 폐센터 내에 위치하며, 다양한 감염질환의 진단 및 치료를 담당합니다.', 
department_description='감염내과에서는 일반적 세균감염(폐렴, 신우신염, 임파선염, 뇌수막염, 피부연조직감염, 심내막염, 세균성 관절염, 결핵), 바이러스질환(독감, 대상포진), 원인을 모르는 열병 환자(불명열), 암이나 면역저하 환자, 이식환자에서의 감염질환, 에이즈 환자 등의 진단과 치료를 담당합니다. 또한, 여행이나 유학시 필요한 예방접종, 말라리아 예방약 투여도 시행하고 있습니다.', 
department_hero_image_url='img2.jpg', 
department_created_date =sysdate 
where department_name='감염내과';

update department set 
department_summary='건강한 행복이 시작되는 곳', 
department_intro='건진의학과는 정확하고 신뢰성 있는 건강관리 서비스 제공을 통하여 건강하고 행복한 삶의 동반자가 되고자 합니다. 건강검진의 질적인 향상과 연속성 있는 추후 관리기능 강화를 위해 지속적으로 노력해나갈 것을 약속드립니다.', 
department_description='풍부한 경험의 건진의학과 의료진 및 신속하고 긴밀하게 연계 가능한 진료과 협력 교수로 구성된 의료진이 있습니다. 또한 CT, MRI, 초음파, PET, 내시경 등 각종 최신 첨단 의료장비를 구비하여 검사의 정확성을 더욱 높였습니다. 그리고 선택은 쉬우면서도 개인별 특성을 다양하게 맞출 수 있도록 차별화된 프로그램을 제공합니다. 또한 효율적인 건강검진 코스, 여유로운 공간 구성 및 편안한 대기 공간의 경험을 제공하여 건강검진의 품격을 높이겠습니다.', 
department_hero_image_url='img3.jpg' 
where department_name='건진의학과';

update department set 
department_summary='관절질환 및 전신 자가면역질환에 대한 전문적인 진단 및 치료', 
department_intro='관절류마티스내과는 내과 분과 중 하나로 관절염과 관절염을 일으키는 전신 류마티스 질환을 전문적으로진단하고 치료하는 과입니다. 관절류마티스내과에서는 다양한 원인의 관절염, 결체조직질환 및 혈관염과 같은 전신 자가면역질환을 진료하고 있습니다.', 
department_description='류마티스학은 통증을 일으키는 액성물질인 ‘류마 (rheuma)’가 흘러서 관절질환을 일으킨다는 고대 그리스의 질병 개념에서 그 기원을 찾을 수 있으며 관절통이나관절염을 일으키는 질환의 원인과 병인 규명 및 치료를 연구하는 현대적 학문으로 발전하였습니다.\r\n관절류마티스내과에서 진료하는 질환에는 류마티스관절염을 비롯하여 강직척추염, 통풍, 골관절염 등 관절염을 주 증상으로 하는 질환들과 전신홍반루푸스, 쇼그렌증후군, 전신경화증, 염증근질환 등의 결합조직질환, 베체트병 및 다양한 종류의 혈관염이 포함됩니다.\r\n본원에서는 빠르게 발전하고 있는 류마티스 질환의 첨단 치료를 진료에 도입하여 환자 개개인에게적합한 최선의 치료를 제공하고자 노력하고 있습니다.', 
department_hero_image_url='img4.jpg' 
where department_name='관절류마티스내과';

update department set 
department_summary='최신 기술과 장비를 통한 최선의 치료', 
department_intro='이대서울병원 구강악안면외과에서는 악교정수술(양악수술), 구순구개열(언청이)수술, 입과 턱뼈의 종양 및 구강암의 수술과 턱 얼굴 재건, 난치성 악골괴사, 턱관절 질환, 임플란트 식립, 치아이식, 사랑니 발치 등의 전문 진료를 시행하고 있습니다.', 
department_description='어릴 때부터 턱 발육의 비정상으로 턱이 많이 튀어나오거나, 작은 턱, 비뚤어진 턱은 외모의 교정에 치우쳐서는 안 된다. 음식을 씹는 치아의 맞물림이 고려되어야 하고, 턱의 운동(음식의 저작과 발음) 및 턱 속을 지나는 신경과 혈관 등, 성장의 정도에 따라 엄격한 분석을 해야 한다. 일반적으로 치열교정과 악교정수술이 병행되며, 대체로 수술하기 전에 치열교정을 6개월-1년간 시행하고 수술하여야 원하는 만큼의 이동이 가능하고, 수술 후에 변형이 적다. 반드시 기능적인 면이 고려되는 턱의 교정이라고 생각함이 옳다. 본 원에서는 턱의 발육상태에 관한 두개안면골의 성장 및 유형분석과 치열과 교합을 컴퓨터로 분석하여 종합적인 치료 계획을 세우고 정밀한 수술을 시행하고 있다. ', 
department_hero_image_url='img5.jpg' 
where department_name='구강악안면내과';

update department set 
department_summary='전인적인 내과 진료와 환자 맞춤 치료', 
department_intro='이대서울병원 내과는 소화기내과, 호흡기내과, 순환기내과, 내분비내과, 통합내과, 감염내과, 알레르기내과 등 세분화된 전문 분야를 통해 환자분들께 체계적이고 종합적인 진료를 제공하고 있습니다. 또한 최신 장비와 의학적 근거에 기반한 치료를 시행하며, 만성질환 관리부터 급성기 치료까지 폭넓은 의료서비스를 제공합니다.', 
department_description='내과는 인체의 주요 장기와 관련된 다양한 질환을 진단하고 치료하는 의학 분야입니다. 소화기 질환(위·간·담도·췌장 등), 호흡기 질환(폐렴, 천식, 만성폐쇄성폐질환 등), 심혈관 질환(고혈압, 협심증, 심부전 등), 내분비 및 대사 질환(당뇨병, 갑상선 질환 등), 신장 질환(신부전, 사구체신염 등), 감염 질환, 알레르기 질환까지 포괄적인 진료를 다룹니다. 특히 만성질환은 조기 진단과 꾸준한 관리가 환자의 삶의 질을 크게 좌우하기 때문에 정기적인 검사와 맞춤형 치료가 중요합니다. 본 원 내과는 전문 교수진과 첨단 검사 장비를 바탕으로 환자 개개인에 맞춘 정확한 진단과 최적의 치료를 시행하고 있으며, 다학제 협진 시스템을 통해 종합적인 의료서비스를 제공합니다.', 
department_hero_image_url='img6.jpg' 
where department_name='내과';

-- center Data
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '갑상선센터','cSmallImg1.jpg', 'cPlaceImg1.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '고위험 산과센터','cSmallImg2.jpg', 'cPlaceImg2.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '고위험 신생아 집중치료센터','cSmallImg3.jpg', 'cPlaceImg3.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '관절·척추센터','cSmallImg4.jpg', 'cPlaceImg4.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '국가검진센터','cSmallImg5.jpg', 'cPlaceImg4.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '뇌경색센터','cSmallImg6.jpg', 'cPlaceImg6.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '뇌신경센터','cSmallImg7.jpg', 'cPlaceImg7.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '뇌정위방사선치료센터','cSmallImg8.jpg', 'cPlaceImg8.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '뇌졸중센터','cSmallImg9.jpg', 'cPlaceImg9.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '뇌졸중재활센터','cSmallImg10.jpg', 'cPlaceImg10.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '뇌출혈센터','cSmallImg6.jpg', 'cPlaceImg11.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '대동맥센터','cSmallImg11.jpg', 'cPlaceImg12.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '로봇수술센터','cSmallImg12.jpg', 'cPlaceImg12.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '말초혈관센터','cSmallImg13.jpg', 'cPlaceImg14.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '말판증후군·유전성대동맥질환센터','cSmallImg14.jpg', 'cPlaceImg15.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '모아센터','cSmallImg15.jpg', 'cPlaceImg16.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '무릎스포츠의학센터','cSmallImg16.jpg', 'cPlaceImg17.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '산과출혈센터','cSmallImg17.jpg', 'cPlaceImg18.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '소화기센터','cSmallImg18.jpg', 'cPlaceImg19.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '수면센터','cSmallImg19.jpg', 'cPlaceImg20.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '심혈관센터','cSmallImg20.jpg', 'cPlaceImg21.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '아기수술센터','cSmallImg21.jpg', 'cPlaceImg22.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '암센터','cSmallImg22.jpg', 'cPlaceImg23.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '어깨질환센터','cSmallImg23.jpg', 'cPlaceImg24.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '에드먼즈 간호교육센터','cSmallImg24.jpg', 'cPlaceImg25.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '염증성장질환센터','cSmallImg25.jpg', 'cPlaceImg26.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '웰니스 건강증진센터','cSmallImg5.jpg', 'cPlaceImg26.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '웰에이징센터','cSmallImg26.jpg', 'cPlaceImg26.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '유방센터','cSmallImg27.jpg', 'cPlaceImg29.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '인공관절센터','cSmallImg28.jpg', 'cPlaceImg30.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '장기이식센터','cSmallImg29.jpg', 'cPlaceImg31.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '족부센터','cSmallImg30.jpg', 'cPlaceImg32.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '턱관절센터','cSmallImg31.jpg', 'cPlaceImg33.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '투석혈관센터','cSmallImg32.jpg', 'cPlaceImg34.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '폐센터','cSmallImg33.jpg', 'cPlaceImg35.jpg');
insert into center (center_id, center_name, center_small_img, center_place_img) values ((select nvl(max(center_id)+1,1) from center), '혈관건강센터','cSmallImg34.jpg', 'cPlaceImg36.jpg');

update center set 
center_summary='당신의 갑상선과 건강을 모두 지켜드립니다.',
center_description='갑상선센터는 외래진료 당일에 초음파검사 및 필요한 경우에는 세침검사까지 한번에 시행하는 원스텝 갑상선결절 클리닉을 운영하고 있습니다.
갑상선결절과 갑상선암은 과잉진단과 과잉치료를 경계해야 하는 병입니다. 저희 의료진들은 불필요한 검사와 치료를 시행하지 않습니다.
대신 현재의 질환의 진행 정도를 정확하게 파악하고, 환자와 충분히 상담하여 단순 추적관찰, 고주파치료, 알코올치료, 수술 등 다양한 방법 중 각 환자에게 가장 적절한 방법을 찾아서 가장 안전한 방식으로 제공합니다.',
center_hero_image_url='cImg1.jpg'
where center_name='갑상선센터';

-- doctor
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '이홍수','교수', 'dprofileImg1.jpg','노인의학, 노화방지 항노화의학, 임상 영양치료, 평생건강관리, 여행자 건강관리',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '전혜진','교수', 'dprofileImg2.jpg','파워에이징, 건강증진, 맞춤건강, 비만체형관리, 피부미용레이저, 웰에이징 심화상담',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '김장수','교수', 'dprofileImg3.jpg','만성질환관리 (고혈압/당뇨병/고지혈증/골다공증 등), 대사 증후군, 비만, 건강증진, 예방접종, 가정의학 일반진료',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '정하윤','교수', 'dprofileImg4.jpg','만성질환관리 (고혈압/당뇨병/고지혈증/골다공증 등), 대사 증후군, 건강증진, 예방접종, 가정의학 일반 진료',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '강도현','교수', 'dprofileImg5.jpg','만성질환관리 (고혈압/당뇨병/고지혈증/골다공증 등), 대사 증후군, 건강증진, 예방접종, 가정의학 일반 진료',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '송예은','교수', 'dprofileImg6.jpg','만성질환관리 (고혈압/당뇨병/고지혈증/골다공증 등), 대사 증후군, 건강증진, 예방접종, 가정의학 일반 진료',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,center_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '김경호','교수', 'dprofileImg7.jpg','갑상선질환(갑상선암), 갑상선 로봇수술',1); --7
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,center_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '강혜지','교수', 'dprofileImg8.jpg','갑상선 결절',1); --8
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,center_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '순정석','교수', 'dprofileImg9.jpg','갑상선 영상의학',1); --9
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '이수민','교수',null,'소아청소년 비만, 성장장애, 소아 내분비질환',2);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '박지훈','교수',null,'심장내과, 고혈압, 협심증, 부정맥',2);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '최민정','교수',null,'호흡기 질환, 천식, 만성기관지염, 폐렴',2);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '한동우','교수',null,'소화기 내과, 위내시경, 대장내시경, 간질환',3);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '서유진','교수',null,'신장내과, 투석치료, 만성콩팥병 관리',3);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, department_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '정세현','교수',null,'신경과, 치매, 뇌졸중, 파킨슨병',3);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, center_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '홍예진','교수',null,'유방암, 유방질환 진단 및 수술',2);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, center_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '오성훈','교수',null,'폐암, 폐종양 수술, 흉부외과 수술',2);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, center_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '윤다인','교수',null,'소아심장, 선천성 심장질환, 소아심장 초음파',2);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty, center_id) 
values ((select nvl(max(doctor_id)+1,1) from doctor), '백승호','교수',null,'뇌종양, 척추수술, 신경외과 종양수술',2);
