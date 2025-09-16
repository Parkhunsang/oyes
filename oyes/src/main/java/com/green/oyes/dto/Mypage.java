package com.green.oyes.dto;
import java.sql.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;
@Data
@Alias("mypage")
public class Mypage {
    private int    patient_no;
    private String patient_id;
    private String password;
    private String patient_name;
    private String birth_date;
    private String mobile_no;
    private String email;
    private String is_admin;
    private Date   create_date;
    private Date   update_date;
    private String is_active;
	/*
	 * private Integer favorite_no; private String is_active; private Integer
	 * doctor_id; private String doctor_name; private String doctor_title; private
	 * String department_id; private String department_name;
	 */	
}