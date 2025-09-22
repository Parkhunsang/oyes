package com.green.oyes.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("center_doctor")
public class CenterDoctor {
	private int num;
	private int doctor_id;
	private int center_id;
}
