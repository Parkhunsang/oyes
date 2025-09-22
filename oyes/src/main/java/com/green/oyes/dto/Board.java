package com.green.oyes.dto;
import java.sql.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("board")
public class Board {
	private int boardno;
	private int patient_no;
	private String board_title;
	private String board_content;
	private int board_readCnt;
	private String board_file;
	private String board_kind; // kind = press | notice
	private Date board_create_date;
	private Date board_update_date;
	private Date board_end_date;
	private String board_is_active;
}
