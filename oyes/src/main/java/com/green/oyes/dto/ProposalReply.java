package com.green.oyes.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("proposalReply")
public class ProposalReply {
	private int reply_no;
	private int patient_no;
	private String reply_content;
	private Date create_date;
	private String is_active;
	private int proposal_no;
}
