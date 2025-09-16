package com.green.oyes.dto;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("ClinicSession")
public class ClinicSession {
    private int clinic_id;
    private int doctor_id;
    private String visit_type;
    private String reservation_date;
   
    //조인용
    private String week;
    private String amPm;
    
}