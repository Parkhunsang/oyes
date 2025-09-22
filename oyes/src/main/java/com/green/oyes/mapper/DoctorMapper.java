package com.green.oyes.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.CenterDoctor;
import com.green.oyes.dto.Doctor;

@Mapper
public interface DoctorMapper {

	List<Doctor> list(int department_id);

	Doctor select(int doctor_id);

	List<Doctor> listC(int center_id);

	List<Doctor> listClinic(int center_id);

	List<Doctor> centerList(int center_id);
	
	List<Doctor> doctorlist();

	List<Doctor> listAdmin();

	int update(Doctor doctor);

	int delete(int doctor_id);

	int insert(Doctor doctor);

	void insertCenterDoctor(CenterDoctor cd);
	
	

}
