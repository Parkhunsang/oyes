package com.green.oyes.dto;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("doctor")
public class Doctor {
  private int doctor_id;                 
  private String doctor_name;               
  private String doctor_title;
  private String doctor_profile_image;          
  private String doctor_doctor_specialty;
  private String doctor_is_active;
  private Date doctor_created_at;
  private Date doctor_updated_at;
  
  // 조인용
  private int department_id;
  private int center_id;
  private String department_name;
  
  private List<String> centerNames;
  private List<ClinicSession> ClinicList;
  
  private java.util.Map<String, java.util.Map<String, String>> scheduleMap;

  private java.util.List<com.green.oyes.dto.DoctorExtra> doctorExtraList;

	
  
}
