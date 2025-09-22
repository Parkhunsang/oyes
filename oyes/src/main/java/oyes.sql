select*from OUTPATIENT;
drop

SELECT
		    d.*,
		    c.center_name
		FROM
		    doctor d,center c, center_doctor cd
		where d.doctor_id = cd.doctor_id and 
			 cd.center_id = c.center_id(+) and
		    d.center_id = 1
	    order by num;

select * from clinic_session;

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

CREATE TABLE center (
  center_id               NUMBER(19),
  center_name             VARCHAR2(100)      NOT NULL,
  center_summary          VARCHAR2(500),
  center_intro            VARCHAR2(1000),
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
  center_id                 NUMBER(19) references center(center_id)
  CONSTRAINT pk_doctor PRIMARY KEY (doctor_id),
  CONSTRAINT ck_doctor_active CHECK (doctor_is_active IN ('Y','N'))
);

CREATE TABLE center_doctor (
	num	number(19) primary key,
	doctor_id      NUMBER(19) ,
	center_id      NUMBER(19) ,
	CONSTRAINT fk_cd_doctor FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
	CONSTRAINT fk_cd_center FOREIGN KEY (center_id) REFERENCES center(center_id)
);

CREATE TABLE clinic_session (
	clinic_id       NUMBER(19),
	doctor_id       NUMBER(19)  NOT NULL,
	visit_type      VARCHAR2(15) NOT NULL CHECK (visit_type IN ('외래진료', '휴진', '공휴일')), 
	reservation_date date,
	CONSTRAINT pk_clinic_session PRIMARY KEY (clinic_id),
	CONSTRAINT fk_cs_doctor      FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

--의료진 정보(학위, 경력, 논문 등..)를 위한 TABLE 추가
CREATE TABLE doctor_extra(
	extra_id		NUMBER(19),
	doctor_id      NUMBER(19),
	sort_code      number(2) not null, --1 : 학력사항, 2 : 교육 및 연구경력, 3 : 기타 학술 관련 경력, 4 : 논문 및 저서
	extra_data	   varchar2(1000),		
	CONSTRAINT pk_doctor_extra PRIMARY KEY (extra_id),
	CONSTRAINT fk_de_doctor    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

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
center_intro='갑상선기능항진증을 포함한 갑상선기능 질환, 양성 갑상선 결절, 갑상선암 등 다양한 갑상선질환에 대해서 내과, 외과, 영상의학과, 병리과, 핵의학과의 최고의 전문가들이 함께 진료합니다.',
center_hero_image_url='cImg1.jpg'
where center_name='갑상선센터';

update center set 
center_summary='고위험 산과센터는 임신·출산 과정에서 합병증 위험이 높은 산모와 태아를 전문적으로 관리하는 센터입니다.',
center_description='고위험산과센터는 산과, 내과, 외과, 성형외과, 방사선종양의학과, 마취통증의학과 등
각 분야 최고의 전문 의료진과 고위험 산모 전용 병동, 응급실, 수술실, 중환자실 등의 충분한 공간을 확보하고 있습니다.
이와 함께 갖춰진 최첨단 시설을 토대로 고위험 산모와 태어날 아기의 건강을 위해 365일 24시간 응급 상황과 분만에 대비하고 있습니다.',
center_intro='산모와 아기의 안전한 출산을 위해 고도의 전문 진료와 체계적인 관리를 제공하는 곳입니다.',
center_hero_image_url='cImg2.jpg'
where center_name='고위험 산과센터';

update center set 
center_summary='고위험 신생아 집중치료센터는 미숙아나 위중한 신생아에게 전문적인 치료와 24시간 집중 관리를 제공하는 센터입니다.',
center_description='고위험신생아집중치료센터는 국내 최고 수준의 신생아 전문의가 24시간 365일 아기들을 치료하고, 임상 경험이 풍부한 신생아전담간호사가 아기들을 돌보면서 개개인에 대한 치료와 관리가 세심하게 이뤄지고 있습니다.
또한 신생아 전문과는 물론 소아신경, 소아심장, 소아감염, 소아영상, 소아재활, 소아안과, 소아외과, 소아흉부외과, 소아신경외과, 소아비뇨기과 등 소아와 관련된 모든 과를 갖추었습니다.',
center_intro='최첨단 장비와 전문 의료진이 신생아의 생명과 건강을 지키기 위해 최선을 다하는 곳입니다.',
center_hero_image_url='cImg3.jpg'
where center_name='고위험 신생아 집중치료센터';

update center set 
center_summary='다학제 협진 통해 안전, 적정, 신속 진료 제공',
center_description='모든 의료진은 수술 전 충분한 보존적 치료를 시행함으로써 환자들의 수술에 대한 부담감을 줄이려 노력하고 있으며  수술 적응증 및 수술 방법 등의 표준화를 통해 환자에게 꼭 필요한 진료를 제공하고 있습니다. 아울러 정형외과와 신경외과 의료진의 긴밀한 협진을 통해 각 과의 강점이 융합됨으로써 보다 좋은 수술 결과로 나타나고 있습니다. 수술 후에는 재활의학과와 협진을 시행하여 환자의 후유증을 최소화해 빠른 일상 복귀를 가능하게 하는 적극적인 치료와 재활이 가능한 시스템을 갖추고 있습니다. ',
center_intro='이대서울병원 관절·척추센터는 정형외과, 신경외과, 재활의학과, 관절류마티스 내과, 마취통증의학과 등 다양한 진료과가 참여해 전문적인 협진 체계를 갖추고 환자 맞춤형 진료를 제공하고 있으며 각 진료과별 전문 교수들이 팀을 이뤄 서로의 지식을 공유하고 보완해 모든 관절 척추 질환에 대한 최적의 진료를 제공하고 있습니다.',
center_hero_image_url='cImg4.jpg'
where center_name='관절·척추센터';

update center set 
center_summary='일반건강검진 안내',
center_description='국가건강검진이란 모든 국민이 건강위험요인과 질병을 조기에 발견하여 치료를 받음으로써 인간다운 생활을 보장 받고 건강한 삶을 영위하는 것을 기본이념으로 하는 ‘건강검진기본법’에 의거하여 시행하는 건강검진을 말합니다. 국가건강검진은 보건복지부장관으로부터 지정받은 검진기관에서 받을 수 있습니다.
이대서울병원에서는 2019년 일반건강검진 및 암 검진 기관으로 지정 받아 국가검진센터를 개소하여 지역사회 주민과 근로자 건강증진에 기여하고 있습니다.',
center_intro='우리나라 사람에게 흔한 만성 질환을 초기에 발견하여 관리하기 위해 실시하는 검진입니다. 전 국민을 대상으로 연령별, 성별로 꼭 필요한 기본 검사, 즉 발생 빈도가 높은 주요 질환을 위주로 핵심적인 항목을 검사하며, 국민건강보험공단에서 비용을 전액 부담합니다. (의료급여 수급권자는 국가와 지자체에서 전액 부담합니다)',
center_hero_image_url='cImg5.jpg'
where center_name='국가검진센터';

update center set 
center_summary='뇌경색센터는 뇌혈관이 막혀 발생하는 뇌경색 환자에게 신속하고 전문적인 치료를 제공하는 전문 센터입니다.',
center_description='뇌경색 전문인력이 365일 24시간 근무하며 뇌경색 발생 시, 골든타임 이내 모든 급성기 치료를 받을 수 있도록 응급실 최단 시간 혈전용해술과 최신 혈관조영실에서의 혈관내재개통치료를 시행하고 있습니다. 응급 처치 후에는 12병상의 뇌졸중 집중치료실과 신경계 중환자실에서의 모니터링을 통하여 뇌경색 악화 및 합병증 방지를 위해 최선을 다하고 있습니다. 
입원 중 뇌경색 유발 요인에 대한 검사를 통해 혈관 위험 인자를 확인하고 이에 따른 약물 조절과 혈관 중재적 시술을 시행하고 있습니다. 또한, 빠른 신경 회복과 후유증 최소화를 위한 재활치료, 퇴원 후 재발 방지를 위한 관리, 혈관성 인지장애에 따른 인지치료, 우울증 등에 대한 교육 등 환자 개개인에 따른 맞춤형 치료를 제공하여 환자분들의 삶의 질을 향상시켜 드리고자 최선을 다해 노력하고 있습니다.',
center_intro='이대뇌혈관병원 뇌경색센터는 급만성 뇌경색 환자의 진단, 치료, 예방 등을 포함한 전방위 진료 제공을 목표로 하고 있습니다.',
center_hero_image_url='cImg6.jpg'
where center_name='뇌경색센터';

-- doctor Data(doctor_id가 1~6인 데이터)
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) values ((select nvl(max(doctor_id)+1,1) from doctor), '이홍수','교수', 'dprofileImg1.jpg','노인의학, 노화방지 항노화의학, 임상 영양치료, 평생건강관리, 여행자 건강관리',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) values ((select nvl(max(doctor_id)+1,1) from doctor), '전혜진','교수', 'dprofileImg2.jpg','파워에이징, 건강증진, 맞춤건강, 비만체형관리, 피부미용레이저, 웰에이징 심화상담',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) values ((select nvl(max(doctor_id)+1,1) from doctor), '김장수','교수', 'dprofileImg3.jpg','만성질환관리 (고혈압/당뇨병/고지혈증/골다공증 등), 대사 증후군, 비만, 건강증진, 예방접종, 가정의학 일반진료',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) values ((select nvl(max(doctor_id)+1,1) from doctor), '정하윤','교수', 'dprofileImg4.jpg','만성질환관리 (고혈압/당뇨병/고지혈증/골다공증 등), 대사 증후군, 건강증진, 예방접종, 가정의학 일반 진료',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) values ((select nvl(max(doctor_id)+1,1) from doctor), '강도현','교수', 'dprofileImg5.jpg','만성질환관리 (고혈압/당뇨병/고지혈증/골다공증 등), 대사 증후군, 건강증진, 예방접종, 가정의학 일반 진료',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,department_id) values ((select nvl(max(doctor_id)+1,1) from doctor), '송예은','교수', 'dprofileImg6.jpg','만성질환관리 (고혈압/당뇨병/고지혈증/골다공증 등), 대사 증후군, 건강증진, 예방접종, 가정의학 일반 진료',1);
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,center_id) values ((select nvl(max(doctor_id)+1,1) from doctor), '김경호','교수', 'dprofileImg7.jpg','갑상선질환(갑상선암), 갑상선 로봇수술',1); --7
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,center_id) values ((select nvl(max(doctor_id)+1,1) from doctor), '강혜지','교수', 'dprofileImg8.jpg','갑상선 결절',1); --8
insert into doctor (doctor_id, doctor_name, doctor_title, doctor_profile_image, doctor_doctor_specialty,center_id) values ((select nvl(max(doctor_id)+1,1) from doctor), '순정석','교수', 'dprofileImg9.jpg','갑상선 영상의학',1); --9

update doctor set department_id='24' where doctor_id in (7,8);

-- center_doctor Data(doctor_id가 1~6인 데이터)
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR), null, 1);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR), 28, 2);
INSERT INTO center_doctor (num,center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),14, 2);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),36, 2);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),28, 3);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),36, 4);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),null, 5);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),null, 6);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),1, 7);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),23, 7);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),1, 8);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),23, 8);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),1, 9);
INSERT INTO center_doctor (num, center_id, doctor_id) VALUES ((select nvl(max(num)+1,1) from CENTER_DOCTOR),23, 9);


-- clinic_session Data(doctor_id가 1~6인 데이터)
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 1,'외래진료',to_date('2025-09-11 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 1,'외래진료',to_date('2025-09-18 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 1,'외래진료',to_date('2025-09-25 12:01','yyyy-mm-dd HH:mi'));

insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 2,'외래진료',to_date('2025-09-08 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 2,'외래진료',to_date('2025-09-09 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 3,'외래진료',to_date('2025-09-08 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 3,'외래진료',to_date('2025-09-10 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 3,'외래진료',to_date('2025-09-09 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 3,'외래진료',to_date('2025-09-11 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 4,'외래진료',to_date('2025-09-09 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 4,'외래진료',to_date('2025-09-12 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 4,'외래진료',to_date('2025-09-13 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 4,'외래진료',to_date('2025-09-11 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 5,'외래진료',to_date('2025-09-08 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 5,'외래진료',to_date('2025-09-10 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 5,'외래진료',to_date('2025-09-11 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 6,'휴진',to_date('2025-09-10 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 7,'외래진료',to_date('2025-09-08 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 7,'외래진료',to_date('2025-09-15 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 7,'외래진료',to_date('2025-09-22 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 7,'외래진료',to_date('2025-09-29 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 7,'외래진료',to_date('2025-09-11 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 7,'외래진료',to_date('2025-09-18 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 7,'외래진료',to_date('2025-09-25 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 8,'외래진료',to_date('2025-09-08 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 8,'외래진료',to_date('2025-09-11 12:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 8,'외래진료',to_date('2025-09-12 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 9,'외래진료',to_date('2025-09-09 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 9,'외래진료',to_date('2025-09-12 07:01','yyyy-mm-dd HH:mi'));
insert into clinic_session values((select nvl(max(clinic_id)+1,1) from clinic_session), 9,'외래진료',to_date('2025-09-13 12:01','yyyy-mm-dd HH:mi'));

-- doctor_extra Data(doctor_id가 1, 7인 데이터)
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,1,'연세대학교 의학박사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,1,'연세대학교 의학석사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,1,'연세대학교 의과대학 졸업');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'2013-2015 | 서남병원 진료부원장');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'2009-2011 | 이대목동병원 교육연구부장');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'2009 | 의학전문대학원 학생 부원장');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'1993-2009 | 이대목동병원 건강증진센타 소장');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'1998-1999 | 미국 뉴욕 로체스터 의과대학 가정의학 및 노인의학 교환교수');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'1993-현재 | 이화여자대학교 의과대학 가정의학교실 교수');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'1991-1993 | 의료법인 서울기독병원 가정의학 과장 겸 수련부장');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'1989-1991 | 연세의료원 가정의학과 연구강사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'1986 | 가정의학과 전문의 취득');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,2,'1983-1986 | 연세의료원 가정의학 전공의 수료');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,3,'2013-2015 | 대한임상노인의학회 이사장');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,3,'2009-2011 | 대한임상노인의학회 총무이사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,3,'2005-2007 | 대한가정의학회 기획이사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,3,'2000-2002 | 대한임상노인의학회 간행이사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,3,'1995-1997 | 대한가정의학괴 간행이사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,4,'한국 노인에서 악력과 수면시간과의 관련성.  Korean Journal of Family Practice. 2021, v.11 no.3, 170-176.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,4,'한국 당뇨병 환자에서 신체활동과 건강 관련 삶의 질의 연관성.  Korean Journal of Family Practice. 2020, v.10 no.1, 60-67.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,4,'한국 성인 남녀에서 주관적 체형 인식과 대사증후군과의 연관성: 2015–2016년 국민건강영양조사 자료 이용.  Korean Journal of Family Practice. 2020, v.10 no.4, 284-291.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,4,'한국 중년 및 노년층 여성의 여가시간 신체활동과 대사증후군의 관계.  Korean Journal of Family Practice. 2019, v.9 no.6, 513-519.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,4,'he level of vitamin D using the LC-MS/MS method and related factors in healthy Korean postmenopausal women.  OURNAL OF OBSTETRICS AND GYNAECOLOGY RESEARCH. 2018, v.44 no.10, 1977-1984.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,4,'Ascending Aortic diameter is associated with hypertension in Korean man.  CLINICAL AND INVESTIGATIVE MEDICINE. 2017, v.40 no.4, E158-E166.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),1,4,'The association between urinary sodium excretion and metabolic syndrome in Korean adults from the 2010-2011 Korean National Health and Nutrition Examination Survey.  Korean Journal of Family Medicine. 2017, v.38 no.4, 199-205.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,1,'서울대학교 의과대학 박사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,1,'서울대학교 의과대학 석사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,1,'서울대학교 의과대학 졸업');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,2,'2021-현재  | 이대서울병원 갑상선센터장');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,2,'2022-현재  | 이화여자대학교 의료원 국제의료사업단 부단장');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,2,'2019-2020  | 서울대학교병원 NJH 프로젝트 담당교수');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,2,'2016-2017  | 상해 교통의대 루이진병원 방문교수');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,2,'2011-2019  | 중앙대학교병원 외과 조교수, 부교수');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,2,'2007-2011  | 한림대학교 성심병원 외과 조교수');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,2,'2006-2007  | 서울대학교병원 갑상선내분비외과 전임의');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,2,'1999-2003  | 서울대학교병원 외과 전공의');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,3,'2022-현재  | 대한내분비외과학회 총무이사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,3,'2022-현재  | 대한수술중신경모니터링학회 학술이사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,3,'2019-현재  | Gland Surgery (SCI 저널) 편집위원');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,3,'2020-2022  | 대한갑상선내분비외과학회 개원의위원회 이사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,3,'2018-2022  | 대한종양외과학회 교육위원');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,3,'2018-2020  | 대한갑상선내분비외과학회 연구이사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,3,'2016-2020  | 대한갑상선학회 학술위원');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,3,'2015-2022  | 대한수술중신경모니터링학회 보험이사');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,3,'2013-현재  | 국제암성형내분비외과학회 학술위원');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,4,'The First Report of Robotic Bilateral Modified Radical Neck Dissection Through the Bilateral Axillo-breast Approach for Papillary Thyroid Carcinoma With Bilateral Lateral Neck Metastasis.  Surg Laparosc Endosc Percutan Tech. 2020-06.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,4,'Minimal extrathyroidal extension is associated with lymph node metastasis in single papillary thyroid microcarcinoma: a retrospective analysis of 814 patients.  World J Surg Oncol. 2022-05.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,4,'Fluorescence imaging, an emerging tool for preserving the parathyroid glands during thyroidectomy.  J Minim Invasive Surg. 2022-09.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,4,'A Comparison of the Bilateral Axillo-breast Approach (BABA) Robotic and Open Thyroidectomy for Papillary Thyroid Cancer After Propensity Score Matching.  Surg Laparosc Endosc Percutan Tech. 2022-10.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,4,'Comparison of robot-assisted modified radical neck dissection using a bilateral axillary breast approach with a conventional open procedure after propensity score matching.  Surg Endosc. 2020-02.');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,4,'Robotic Thyroidectomy Decreases Postoperative Pain Compared with Conventional Thyroidectomy.  Surg Laparosc Endosc Percutan Tech. 2019-08');
insert into DOCTOR_EXTRA values((select nvl(max(extra_id)+1,1) from doctor_extra),7,4,'Expanding indications of robotic thyroidectomy.  Surgical Endoscopy And Other Interventional Techniques. 2018-08.');

-- health seminar DB
INSERT INTO health_seminar VALUES (1, TO_DATE('2025-09-01', 'YYYY-MM-DD'), '10:00~11:30', '면역력 강화법', '김민수', '서울센터 1층', '환절기 면역력을 높이는 생활 습관.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (2, TO_DATE('2025-09-02', 'YYYY-MM-DD'), '14:00~15:30', '두통 관리법', '박서연', '부산센터 2층', '두통의 원인과 완화 방법을 알아봅니다.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (3, TO_DATE('2025-09-03', 'YYYY-MM-DD'), '09:30~11:00', '소화 건강 지키기', '이준호', '대구센터 1층', '소화기 질환 예방을 위한 식습관.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (4, TO_DATE('2025-09-04', 'YYYY-MM-DD'), '11:00~12:30', '만성질환 관리', '정유진', '광주센터 2층', '고혈압, 당뇨 등 만성질환 관리 전략.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (5, TO_DATE('2025-09-05', 'YYYY-MM-DD'), '13:00~14:30', '노년기 치매 예방', '최현우', '인천센터 3층', '치매 예방을 위한 두뇌 활동과 습관.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (6, TO_DATE('2025-09-06', 'YYYY-MM-DD'), '15:00~16:30', '청소년 건강관리', '김하늘', '서울센터 2층', '청소년의 성장 발달을 위한 건강 습관.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (7, TO_DATE('2025-09-07', 'YYYY-MM-DD'), '10:00~11:30', '혈당 관리법', '이도현', '부산센터 3층', '혈당 조절과 당뇨 예방을 위한 생활습관.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (8, TO_DATE('2025-09-08', 'YYYY-MM-DD'), '09:00~10:30', '감염병 예방', '박지민', '대전센터 1층', '계절별 감염병 예방 수칙.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (9, TO_DATE('2025-09-09', 'YYYY-MM-DD'), '11:00~12:30', '비만 예방', '정호석', '광주센터 3층', '비만의 위험성과 예방 전략.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (10, TO_DATE('2025-09-10', 'YYYY-MM-DD'), '14:00~15:30', '직장인 건강법', '윤아영', '서울센터 3층', '장시간 근무자의 건강관리 방법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (11, TO_DATE('2025-09-11', 'YYYY-MM-DD'), '13:30~15:00', '노인 운동법', '김동혁', '부산센터 1층', '노인에게 적합한 운동과 주의사항.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (12, TO_DATE('2025-09-12', 'YYYY-MM-DD'), '10:00~11:30', '치아 건강 관리', '송지우', '대전센터 2층', '구강 위생과 치아 건강 관리 방법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (13, TO_DATE('2025-09-13', 'YYYY-MM-DD'), '09:30~11:00', '간 건강 지키기', '이수빈', '광주센터 1층', '간 질환 예방을 위한 생활 습관.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (14, TO_DATE('2025-09-14', 'YYYY-MM-DD'), '15:00~16:30', '호흡기 질환 예방', '박민정', '서울센터 1층', '환절기 호흡기 질환 예방법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (15, TO_DATE('2025-09-15', 'YYYY-MM-DD'), '11:00~12:30', '스트레스 관리', '정성훈', '인천센터 2층', '스트레스 완화와 이완법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (16, TO_DATE('2025-09-16', 'YYYY-MM-DD'), '14:00~15:30', '허리 통증 예방', '최예린', '부산센터 2층', '허리 건강을 지키는 운동법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (17, TO_DATE('2025-09-17', 'YYYY-MM-DD'), '10:00~11:30', '수면 건강', '이승준', '서울센터 3층', '숙면을 돕는 환경과 습관.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (18, TO_DATE('2025-09-18', 'YYYY-MM-DD'), '13:00~14:30', '아토피 관리', '한소희', '광주센터 2층', '피부 질환 아토피 관리 방법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (19, TO_DATE('2025-09-19', 'YYYY-MM-DD'), '09:30~11:00', '갱년기 건강', '김지훈', '대구센터 3층', '갱년기 증상 완화와 관리법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (20, TO_DATE('2025-09-20', 'YYYY-MM-DD'), '11:00~12:30', '뇌 건강 특강', '오유진', '인천센터 1층', '두뇌 활성화와 기억력 향상법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (21, TO_DATE('2025-09-21', 'YYYY-MM-DD'), '15:00~16:30', '혈압 관리', '조현우', '부산센터 3층', '고혈압 예방과 관리 전략.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (22, TO_DATE('2025-09-22', 'YYYY-MM-DD'), '10:00~11:30', '운동과 건강', '장예린', '대구센터 2층', '규칙적인 운동의 효과.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (23, TO_DATE('2025-09-23', 'YYYY-MM-DD'), '13:30~15:00', '알레르기 대처법', '이태현', '서울센터 2층', '알레르기 원인과 예방법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (24, TO_DATE('2025-09-24', 'YYYY-MM-DD'), '14:00~15:30', '대사증후군 관리', '김서현', '광주센터 1층', '대사증후군의 원인과 관리 전략.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (25, TO_DATE('2025-09-25', 'YYYY-MM-DD'), '09:00~10:30', '체형 교정', '박도윤', '서울센터 1층', '바른 자세와 체형 교정 운동.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (26, TO_DATE('2025-09-26', 'YYYY-MM-DD'), '10:30~12:00', '여성 건강', '이지민', '부산센터 2층', '여성의 생애주기별 건강관리.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (27, TO_DATE('2025-09-27', 'YYYY-MM-DD'), '15:00~16:30', '눈 건강 지키기', '최준호', '대전센터 3층', '시력 보호와 눈 운동법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (28, TO_DATE('2025-09-28', 'YYYY-MM-DD'), '14:00~15:30', '관절 건강', '유가은', '광주센터 2층', '관절염 예방과 관리법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (29, TO_DATE('2025-09-29', 'YYYY-MM-DD'), '11:00~12:30', '우울증 이해', '홍지석', '서울센터 2층', '우울증의 원인과 대처 방법.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (30, TO_DATE('2025-09-30', 'YYYY-MM-DD'), '13:00~14:30', '금연 클리닉', '김서윤', '인천센터 3층', '금연 실천을 위한 전략과 상담.', TO_DATE('2025-08-01', 'YYYY-MM-DD'), NULL, 'y');		
INSERT INTO health_seminar VALUES (31, TO_DATE('2025-10-02', 'YYYY-MM-DD'), '10:00~11:30', '호흡과 명상', '정하늘', '서울센터 3층', '정신 안정과 스트레스 해소를 위한 명상 기법 소개.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (32, TO_DATE('2025-10-04', 'YYYY-MM-DD'), '13:30~15:00', '근골격계 질환 예방', '이도윤', '부산센터 3층', '생활 속에서 실천할 수 있는 근골격계 건강 관리법.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (33, TO_DATE('2025-10-06', 'YYYY-MM-DD'), '09:00~10:30', '노년기 정신건강', '박선영', '광주센터 1층', '우울증 예방과 감정 관리법 등 노년기 정신건강 관리 방법.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (34, TO_DATE('2025-10-08', 'YYYY-MM-DD'), '11:00~12:30', '피로 회복법', '최유리', '인천센터 2층', '만성피로의 원인과 효과적인 회복 방법을 배웁니다.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (35, TO_DATE('2025-10-10', 'YYYY-MM-DD'), '14:00~15:30', '직장 내 스트레칭', '서진우', '서울센터 1층', '사무실에서 쉽게 따라 할 수 있는 스트레칭 루틴.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (36, TO_DATE('2025-10-12', 'YYYY-MM-DD'), '15:00~16:30', '여성 건강 특강', '김보라', '부산센터 2층', '여성 생애 주기별 건강관리 방법을 소개합니다.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (37, TO_DATE('2025-10-14', 'YYYY-MM-DD'), '10:00~11:30', '심혈관 질환 예방', '이상훈', '대구센터 1층', '심혈관 건강을 지키는 생활 습관과 운동법.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (38, TO_DATE('2025-10-16', 'YYYY-MM-DD'), '09:30~11:00', '직장인을 위한 식사법', '윤지수', '광주센터 2층', '바쁜 일상 속에서 건강하게 식사하는 법.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (39, TO_DATE('2025-10-18', 'YYYY-MM-DD'), '13:00~14:30', '체중 관리와 운동', '배성우', '인천센터 3층', '체중 감량과 유지에 효과적인 운동 및 식단 전략.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (40, TO_DATE('2025-10-20', 'YYYY-MM-DD'), '11:00~12:30', '건강검진 제대로 알기', '홍길동', '대전센터 2층', '건강검진 항목의 의미와 해석 방법을 안내합니다.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (41, TO_DATE('2025-10-22', 'YYYY-MM-DD'), '14:00~15:30', '흡연과 건강', '김소연', '서울센터 2층', '흡연의 위험성과 금연 실천 전략에 대해 다룹니다.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');
INSERT INTO health_seminar VALUES (42, TO_DATE('2025-10-24', 'YYYY-MM-DD'), '10:00~11:30', '건강한 눈 관리', '조승우', '대구센터 2층', '눈의 피로를 줄이고 시력을 보호하는 생활 습관.', TO_DATE('2025-09-01', 'YYYY-MM-DD'), NULL, 'y');

-- oyes whole DB DML
create table MEMBER (
    patient_no      number(10)      PRIMARY KEY,
    patient_id      varchar2(20)    not null,
    password        varchar2(60)    not null,
    patient_name    varchar2(20)    not null,
    birth_date      varchar2(8)     not null,
    mobile_no       varchar2(12)    not null,
    email           varchar2(50)    not null,
    is_admin        char(1)         default 'n' not null,
    create_date     date            not null,
    update_date     date            ,
    is_active       char(1)         default 'y' not null,
    CONSTRAINT uq_member_id UNIQUE (patient_id)  
)
select * from MEMBER;
update member set password = '$2a$10$aR2RJg6xxvzh8Zu2loU31e2HU195CNTI7cXH5qAkjrQ9jytKQ0T/K';
update member set is_active = 'y';

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
drop table compliment;
select * from COMPLIMENT;

-- 고객서비스 - 건의합니다 Table
create table proposal (
    proposal_no      number(10)      PRIMARY KEY              ,
    patient_no       number(10)      not null                 ,
    related         number(1)       ,
    proposal_title   varchar2(60)    not null                 ,
    proposal_type    number(1)       default '1' not null     ,
    proposal_content varchar2(1000)  not null                 ,
    create_date     date            not null                 ,
    is_active       char(1)         default 'y' not null     ,
    progress        number(1)       default '1' not null     ,
    constraint fk_proposal_patient foreign key (patient_no) references member(patient_no) ,
    constraint ck_proposal_active check (is_active in ('y','n')),
    constraint ck_proposal_related check (related between 1 and 4),
    constraint ck_proposal_type check (proposal_type between 1 and 3),
    constraint ck_proposal_progress check (progress between 1 and 3)
);

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


create table board (
    boardno         number PRIMARY KEY,
    admin_id        number not null,
    board_title     varchar2(100) not null,
    board_content   varchar2(50) not null,
    board_readCnt   varchar2(100) default '0' not null,
    board_type      char(1) not null,
    board_create_date date default sysdate not null,
    board_update_date date,
    board_end_date  date,
    board_is_active char(1) default 'n' not null,     
    patient_no number(10),
	constraint fk_board_patient foreign key (patient_no) references Member(patient_no)
);

create table health_seminar (
seminar_no number(10) primary key, -- 강좌번호
seminar_date date not null, -- 강좌일자
seminar_time varchar(20) not null, -- 강좌시간
seminar_title varchar(200) not null, -- 강좌주제
seminar_lecturer varchar(10) not null, -- 강사
seminar_site varchar(100) not null, -- 강좌장소
seminar_text varchar(2000), -- 강좌설명
create_date date not null, -- 등록일자
update_date date, -- 변경일자
is_active char(1) default 'y' not null -- 활동상태
);

create table health_information (
	information_no number(10) primary key, -- 게시글번호
	information_title varchar(30) not null, -- 게시글제목
	information_url varchar(200) not null, -- 게시글주소
	create_date date not null, -- 등록일자
	update_date date, -- 변경일자
	is_active char(1) default 'y' not null -- 활동상태
);

create table health_post (
	post_no number(10) primary key, -- 게시글번호
	post_title varchar(30) not null, -- 게시글제목
	post_url varchar(200) not null, -- 게시글주소
	create_date date not null, -- 등록일자
	update_date date, -- 변경일자
	is_active char(1) default 'y' not null -- 활동상태
);

create table health_video (
	video_no number(10) primary key, -- 동영상번호
	video_title varchar(30) not null, -- 동영상제목
	video_url varchar(200) not null, -- 동영상주소
	create_date date not null, -- 등록일자
	update_date date, -- 변경일자
	is_active char(1) default 'y' not null -- 활동상태
);

create table InfoCategories(
	category_id number(10) primary key,
	category_name varchar2(100),
	sort_order number(20) unique
);

create table InfoSubs(
    infoSubs_id number(10) primary key,
    category_id number(10),
    infoSubs_name varchar2(100),
    constraint fk_infosubs_category foreign key (category_id) references InfoCategories(category_id)
);

create table InfoDetail(
	infoDetail_id number(10) primary key,
	infoSubs_id number(10),
	infoDetail_title varchar2(255),
	infoDetail_content varchar2(4000),
	update_date date,
	constraint fk_InfoDetail_infoSubs foreign key (infoSubs_id) references InfoSubs(infoSubs_id)
);

create table careers (
    careersno       number(20)          PRIMARY KEY,
    careers_title   varchar2(100)   not null,
    careers_department varchar2(50)    not null,
    careers_position varchar2(50)    not null,
    careers_type    varchar2(20)    not null,
    careers_headcount number(5)       not null,
    careers_content varchar2(500)   not null,
    careers_salary  varchar2(100),
    careers_create_date date DEFAULT SYSDATE NOT NULL,
    careers_update_date date,
    careers_end_date date               
);

create table outpatient (		
	outpatient_no number(10) primary key, -- 외래예약번호		
	patient_no number(10) not null,-- 환자번호 (join)		
	department_id number(19) not null, -- 진료과 (join)		
	doctor_id number(19) not null, -- 진료의사 (join)		
	outpatient_date date not null, -- 외래예약일		
	outpatient_time varchar2(30) not null, -- 외래예약시간		
	outpatient_site varchar2(30) not null, -- 진료실위치		
	create_date date not null, -- 등록일자		
	update_date date, -- 변경일자		
	outpatient_status number(1) default 1 not null, -- 예약상태	
	constraint fk_outpatient_department foreign key (department_id) references department(department_id),
	constraint fk_outpatient_doctor foreign key (doctor_id) references doctor(doctor_id)
);		

update member set password='$2a$10$npapJwUNY/sf4pJVvVRbeOFKxDWV66ZV80VFOUbnTrqkuPDyNmwf.' where patient_id='admin1';

-- dummy DML,DDL

select * from DOCTOR where doctor_id=2;
select * from CENTER_DOCTOR where DOCTOR_id=2;

select d.*, DEPARTMENT_name, c.center_name from doctor d,  DEPARTMENT dp, CENTER_DOCTOR cd, center c
	where d.doctor_id=2 and d.department_id=dp.department_id and d.doctor_id=cd.doctor_id and c.center_id(+)=cd.center_id;

select hiredate,  to_char(hiredate,'AM') amPm, to_char(hiredate,'DY') week from emp where hiredate between to_date('1981-02-01') and to_date('1981-02-01')+30;

select c.*,to_char(reservation_date, 'am') amPm, to_char(reservation_date,'dy') week from CLINIC_SESSION c;

insert into clinic_session (reservation_date) values(to_date("2025-09-18",'yyyy-mm-dd'));
insert into clinic_session (reservation_date) values(to_date("2025-09-25",'yyyy-mm-dd'));

SELECT
		    d.*,clinic_id, visit_type, reservation_date, to_char(reservation_date,'am') amPm, to_char(reservation_date,'dy') week,
		    c.center_name
		FROM
		    doctor d,center c, center_doctor cd, clinic_session cs
		where d.doctor_id = cd.doctor_id and 
			 cd.center_id = c.center_id(+) and
		    d.department_id = 1 and cs.doctor_id = d.doctor_id
	    order by num;

	    
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
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) values (10000001, 1, '마음 따뜻한 의료인 김쌤을 칭찬합니다','103병동 김쌤',"null",'103병동에서 언제나 친절한 미소로 "불편한 곳 없냐" 하시던 김썜 덕에 아프고 서러워도 잘 견뎌낼 수 있었던 것 같습니다. 감사합니다!','2022-04-16','y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) values (10000002, 1, '박지현 교수님 감사합니다','김지우 교수님', 3,'너무 늦게 발견한 게 아닌가 하고 나날이 힘들어하고 있었는데 검사 결과 보자마자 믿어보라고 말씀해주셔서 살아진 것 같습니다. 수술도 말끔하게 잘 끝나서 벌써 걸어다니고 있구요 밥도 잘 먹고 화장실도 변비 없이ㅎㅎ 잘 다니고 있습니다! 다 선생님 덕이에요 감사해요!!','2022-04-18','y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) values (10000003, 1, '항상 신경 써 주시던 201병동 간호사님들','201병동 모든 간호사',null,'오밤중에 당혈압 잰다고 빽 소리 지르는 어르신도 참아내시고 금식이라는데 몰래몰래 간식 드셔서 곤란하게 하던 아저씨나 진통제가 잘 안 들어서 아프다고 내내 흐느끼며 우는 바람에 같은 방 환자분들의 민원 대상이었던 여자분도 다 견뎌내시고 친절하게 잘 대해주시고 민원처리도 빠르게 해결해주셔서 입원생활 편안하게 있다 갑니다. 간호사 선생님들 잠은 주무시는 거죠..? 고생하시는 만큼 더 버셨으면 해요..','2022-05-22','y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) values (10000001, 2, '마음 따뜻한 의료인 김쌤을 칭찬합니다2','103병동 김쌤',null,'103병동에서 언제나 친절한 미소로 "불편한 곳 없냐" 하시던 김썜 덕에 아프고 서러워도 잘 견뎌낼 수 있었던 것 같습니다. 감사합니다!','2022-04-17','y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) values (10000002, 2, '박지현 교수님 감사합니다2','김지우 교수님', 3,'너무 늦게 발견한 게 아닌가 하고 나날이 힘들어하고 있었는데 검사 결과 보자마자 믿어보라고 말씀해주셔서 살아진 것 같습니다. 수술도 말끔하게 잘 끝나서 벌써 걸어다니고 있구요 밥도 잘 먹고 화장실도 변비 없이ㅎㅎ 잘 다니고 있습니다! 다 선생님 덕이에요 감사해요!!','2022-04-19','y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) values (10000003, 2, '항상 신경 써 주시던 201병동 간호사님들2','201병동 모든 간호사',null,'오밤중에 당혈압 잰다고 빽 소리 지르는 어르신도 참아내시고 금식이라는데 몰래몰래 간식 드셔서 곤란하게 하던 아저씨나 진통제가 잘 안 들어서 아프다고 내내 흐느끼며 우는 바람에 같은 방 환자분들의 민원 대상이었던 여자분도 다 견뎌내시고 친절하게 잘 대해주시고 민원처리도 빠르게 해결해주셔서 입원생활 편안하게 있다 갑니다. 간호사 선생님들 잠은 주무시는 거죠..? 고생하시는 만큼 더 버셨으면 해요..','2022-05-23','y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) values (10000002, 1, '정말 감사했습니다','B병동 3층 미화원님',null,'휠체어 타고 가다가 잘못 삐끗하는 바람에 휠체어에서 떨어졌는데 미화원 선생님께서 화들짝 놀라 달려오셔서 도와주셨습니다. 다시 휠체어에 앉혀주시고는 계속 "아픈 곳은 더 없냐", "입원 중이면 꼭 담당의 회진 돌 때 말씀드려라" 하고 계속 신경써주셔서 아픈 줄도 모르고 그저 감동했습니다. 목적지까지 데려다 주시겠다고 하셨는데 제가 너무 창피하기도 하고 감사하기도 해서 그냥 갔어요 ㅎㅎ 휠체어에서 떨어지며 부딪힌 곳은 조금 멍 든 정도로 이제 괜찮습니다! 정말 감사했습니다!','2025-04-11','y');
insert into compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) values (10000003, 1, '정말 감사합니다','내과 유경태 선생님',1,'처음 방문했을 떈 "아니 저렇게까지 무뚝뚝한 선생님이 계실 수 있나" 했어요. 그런데 꾸준히 뵙고 있자니 감정 표현을 잘 안 하실 뿐이지 누구보다 환자를 신경쓰고 계시고 다정한 분이시라는 걸 알게 되었습니다. 수술 후 일정이나 수술 전 준비할 것들도 세심하게 알려주시고 따로 적어도 주셔서 허둥대거나 착각하고 실수한 서류 같은게 없어서 너무 좋았어요. 수술 후에도 계속 통증 낮춰 주라고 전달해주셔서 정말 아픈 건 잠깐으로 끝난 게 정말 다행이고 감사드려요. "자주 보지 말자" 하셨는데 건강한 상태로는 꼭 다시 뵙고 싶네요ㅎㅎ!!','2025-06-05','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000004, 1, '정성껏 치료해주신 김도현 교수님께', '김도현 교수님', 4, '수술 전부터 차분하게 설명해주시고 수술 후에도 회복 과정을 세심하게 챙겨주셔서 두려움 없이 잘 견뎌낼 수 있었습니다. 가족 모두 마음이 놓였고 정말 감사드립니다.', '2025-06-10','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000005, 1, '항상 환자를 먼저 생각하는 최은영 선생님', '피부과 최은영 선생님', 5, '치료 과정에서 불안해하던 저에게 늘 웃으면서 친절히 설명해주셔서 마음이 편안했습니다. 작은 질문에도 성심껏 답해주셔서 정말 감사드립니다.', '2025-06-12','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000006, 1, '시력을 되찾게 해주신 정현우 교수님', '정현우 교수님', 6, '백내장 수술 전날까지 긴장했는데, 교수님께서 차분하게 말씀해주셔서 안심할 수 있었습니다. 수술 후 세상이 달라 보이네요. 평생 잊지 못할 은혜입니다.', '2025-06-15','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000007, 1, '늘 따뜻하게 대해주신 한서윤 선생님', '이비인후과 한서윤 선생님', 7, '목 통증으로 힘들어했는데 치료뿐 아니라 생활습관까지 친절하게 지도해주셔서 많이 좋아졌습니다. 환자 입장에서 생각해주셔서 너무 감사드려요.', '2025-06-18','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000008, 1, '이야기에 귀 기울여 주신 오지훈 교수님', '오지훈 교수님', 8, '작은 불편함도 세심하게 들어주시고 검사 과정에서도 편안하게 배려해주셨습니다. 덕분에 큰 걱정 없이 치료를 받을 수 있었습니다. 감사드립니다.', '2025-06-20','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000009, 2, '따뜻한 마음으로 진료해주신 서다인 선생님', '서다인 선생님', 4, '검사 결과를 기다리는 동안 많이 불안했는데, 선생님께서 직접 전화 주셔서 안심할 수 있었습니다. 늘 친절하게 대해주셔서 큰 힘이 되었습니다.', '2025-06-22','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000010, 1, '심리적으로 지쳐있을 때 도움 주신 정신건강의학과 백승호 교수님', '백승호 교수님', 5, '우울감으로 힘들었는데 선생님의 진료와 상담 덕분에 다시 삶의 의지를 찾을 수 있었습니다. 늘 환자의 이야기를 경청해주셔서 감사합니다.', '2025-06-25','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000011, 2, '치아 치료를 편하게 해주신 치과 이지아 선생님', '이지아 선생님', 6, '임플란트 시술이라 무서웠는데, 치료 과정마다 설명해주시고 통증을 최소화해주셔서 안심이 되었습니다. 지금은 편하게 식사할 수 있어 행복합니다.', '2025-06-27','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000012, 1, '재활 과정에서 많은 도움 주신 재활의학과 박건우 선생님', '박건우 선생님', 7, '수술 후 회복이 더딜까봐 걱정했는데 선생님께서 맞춤형 재활 프로그램을 짜주셔서 금방 회복할 수 있었습니다. 따뜻한 격려에도 감사드립니다.', '2025-06-29','y');
INSERT INTO compliment (patient_no, compliment_open, compliment_title, compliment_for, doctor_id, compliment_content, create_date, is_active) VALUES (10000013, 1, '가정의학과 윤하늘 교수님께 감사드립니다', '윤하늘 교수님', 8, '정기 검진 중 발견된 질환을 초기에 잡을 수 있었습니다. 꼼꼼하게 검사해주시고 생활 관리 방법도 알려주셔서 건강을 지킬 수 있었습니다.', '2025-07-01','y');
-- proposal
insert into proposal values (1, 10000001, 1,'A병동 입구쪽 엘리베이터 버튼 고장', 2, '메인홀에서 A병동 들어가는 입구쪽 엘리베이터 4개 중에 왼쪽 첫번째 엘리베이터의 닫힘버튼과 12층 버튼이 눌려지지 않습니다. 확인 바랍니다', sysdate, 'y', 1);
insert into proposal values (2, 10000002, 2,'퇴원 후 영수증 발급', 1, '퇴원 후 영수증 발급은 방문으로만 가능한가요?', sysdate, 'y', 2);
insert into proposal values (3, 10000003, 3,'건의사항', 3, '진료과 입구에 키오스크 위치와 사용방법 크게 적어서 표시해 두는 것은 어떠신가요? 어르신들이나 초행인 사람들이 도우미 분을 잘 발견하지 못하고 키오스크 사용법이나 위치도 잘 모르는 경우가 많습니다. 개선할 수 있으면 좋겠어요.', sysdate, 'y', 3);
-- proposal reply
insert into proposal_reply values (1, 10000000, '해당 건의사항 내부 회의중에 있습니다. 좋은 의견 알려주셔서 감사합니다. 더 나은 oyes병원이 되도록 하겠습니다.',sysdate,'y',3);