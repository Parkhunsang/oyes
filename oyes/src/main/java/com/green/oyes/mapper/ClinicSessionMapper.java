package com.green.oyes.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.ClinicSession;
@Mapper
public interface ClinicSessionMapper {

	List<ClinicSession> getSchedule(int doctor_id);

	

}
