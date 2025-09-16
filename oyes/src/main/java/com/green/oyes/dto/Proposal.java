package com.green.oyes.dto;

import java.sql.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("proposal")
public class Proposal {
	private int     proposal_no;
	private int     patient_no;
	private int     related;
	private String  proposal_title;
	private int     proposal_type;
	private String  proposal_content;
	private Date    create_date;
	private String  is_active;
	private int     progress;
}
