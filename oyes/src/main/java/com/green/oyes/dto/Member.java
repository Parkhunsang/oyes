package com.green.oyes.dto;

import java.sql.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("member")
public class Member {
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
}