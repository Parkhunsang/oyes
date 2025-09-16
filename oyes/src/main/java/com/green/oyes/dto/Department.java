package com.green.oyes.dto;
import java.sql.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;
@Data
@Alias("department")
public class Department {
	private int department_id;
	private String department_name;
	private String department_summary;
	private String department_intro;
	private String department_description;
	private String department_small_img;
	private String department_place_img;
	private String department_hero_image_url;
	private String department_is_active;
	private Date department_created_date;
	private Date department_updated_date;
}
