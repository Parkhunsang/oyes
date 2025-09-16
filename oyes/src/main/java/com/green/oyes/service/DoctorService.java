package com.green.oyes.service;

import java.util.List;

import com.green.oyes.dto.Doctor;

public interface DoctorService {

	List<Doctor> list(int department_id);

	Doctor select(int doctor_id);

	List<Doctor> listC(int center_id);

	List<Doctor> listClinic(int center_id);

}
