package com.green.oyes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Doctor;
import com.green.oyes.mapper.DoctorMapper;

@Service
public class DoctorServiceImpl implements DoctorService{
	@Autowired
	private DoctorMapper dm;
	@Override
	public List<Doctor> list(int department_id) {
		
		return dm.list(department_id);
	}
	@Override
	public Doctor select(int doctor_id) {
		
		return dm.select(doctor_id);
	}
	@Override
	public List<Doctor> listC(int center_id) {

		return dm.listC(center_id);
	}
	@Override
	public List<Doctor> listClinic(int center_id) {

		return dm.listClinic(center_id);
	}

}
