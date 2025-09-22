package com.green.oyes.dto;
import java.sql.Date;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("careers")
public class Careers {
	private int careersno;
	private int patient_no;
	private String careers_title;
	private String careers_department;
	private String careers_position;
	private String careers_type;
	private String careers_headcount;
	private String careers_content;
	private String careers_salary;
	private Date careers_create_date;
	private Date careers_update_date;
	private Date careers_end_date; //마감일
	private String careers_status; //open, closed
	private String careers_is_active; // 삭제여부
	// D-day 표시용
    private int daysLeft;  // 마감까지 남은 일수
}
