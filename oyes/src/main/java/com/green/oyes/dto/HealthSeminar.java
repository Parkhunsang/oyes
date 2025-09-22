package com.green.oyes.dto;
import java.sql.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("healthSeminar")
public class HealthSeminar {
	private int seminar_no;//강좌번호
	private Date seminar_date;//강좌일자
	private String seminar_time;//강좌시간
	private String seminar_title;//강좌주제
	private String seminar_lecturer;//강사
	private String seminar_site;//강좌장소
	private String seminar_text;//강좌설명
	private Date create_date;//등록일자
	private Date update_date;//변경일자
	private int status;//상태

}
