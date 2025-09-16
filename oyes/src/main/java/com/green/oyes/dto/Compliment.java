package com.green.oyes.dto;

import java.sql.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("compliment")
public class Compliment {
	private int     compliment_no;
	private int     patient_no;
	private int     compliment_open;
	private String  compliment_title;
	private String  compliment_for;
	private int     doctor_id;
	private String  compliment_content;
	private Date    create_date;
	private String  is_active;
}