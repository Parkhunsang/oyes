package com.green.oyes.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("doctorExtra")
public class DoctorExtra {
	private int extra_id;
	private int doctor_id;
	private int sort_code;
	private String extra_data;
	
	//조인용
	private Doctor doctor;
}
