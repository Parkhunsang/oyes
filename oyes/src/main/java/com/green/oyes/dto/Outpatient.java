package com.green.oyes.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("outpatient")
public class Outpatient {
	private int outpatient_no;		//외래예약번호
	private int patient_no;			//(join용)환자번호
	private int department_id;		//(join용)진료과
	private int doctor_id;			//(join용)진료의사
	private Date outpatient_date;//외래예약일
	private String outpatient_time;//외래예약시간
	private Date create_date;//등록일자
	private Date update_date;//변경일자
	private String outpatient_status;//예약상태
	private Integer center_id;	//(join용)센터
	
	private String department_name; //(join해옴)진료과이름
	private String doctor_name; //(join해옴)의사이름
	private String patient_id; //(join해옴)환자아이디
	private String patient_name; //(join해옴)환자이름
}
