package com.green.oyes.dto;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("doctorSearch")
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DoctorSearch {
	private Integer doctor_id;
	private String	doctor_name;
	private String	doctor_doctor_specialty;
}
