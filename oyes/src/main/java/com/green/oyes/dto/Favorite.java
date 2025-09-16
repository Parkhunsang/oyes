package com.green.oyes.dto;

import java.sql.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("favorite")
public class Favorite {
	private int    favorite_no;
	private int    patient_no;
	private int    doctor_id;
	private Date   create_date;
	private Date   update_date;
	private String is_active;
	// join용
	private String doctor_name; 
	private String doctor_title;
	private int    department_id;
	private String department_name;
}
