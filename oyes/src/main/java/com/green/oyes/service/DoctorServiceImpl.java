package com.green.oyes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.CenterDoctor;
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
	@Override
	public List<Doctor> centerList(int center_id) {
		return dm.centerList(center_id);
	}
	
	public List<Doctor> doctorlist() {
		return dm.doctorlist();
	}
	@Override
	public List<Doctor> listAdmin() {
		
		return dm.listAdmin();
	}
	@Override
	public int update(Doctor doctor) {
		return dm.update(doctor);
	}
	@Override
	public int delete(int doctor_id) {
		return dm.delete(doctor_id);
	}
	@Override
	public int insert(Doctor doctor) {
		// TODO Auto-generated method stub
		return dm.insert(doctor);
	}
	@Override
	public void insertCenterDoctor(CenterDoctor cd) {
		dm.insertCenterDoctor(cd);
		
	}

}
