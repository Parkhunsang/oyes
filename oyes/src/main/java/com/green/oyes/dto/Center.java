package com.green.oyes.dto;
import java.sql.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("center")
public class Center {
	private int center_id;
	private String center_name;
	private String center_summary;
	private String center_intro;
	private String center_description;
	private String center_small_img;
	private String center_hero_image_url;
	private String center_place_img;
	private String center_is_active;
	private Date center_created_date;
	private Date center_updated_date;
	
	
}