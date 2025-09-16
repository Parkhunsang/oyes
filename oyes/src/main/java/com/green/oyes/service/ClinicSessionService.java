package com.green.oyes.service;

import java.util.List;

import com.green.oyes.dto.ClinicSession;

public interface ClinicSessionService {

	List<ClinicSession> getSchedule(int doctor_id);

	
}
