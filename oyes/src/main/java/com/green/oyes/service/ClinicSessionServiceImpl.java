package com.green.oyes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.ClinicSession;
import com.green.oyes.mapper.ClinicSessionMapper;

@Service
public class ClinicSessionServiceImpl implements ClinicSessionService {

	@Autowired
	private ClinicSessionMapper csm;

	@Override
	public List<ClinicSession> getSchedule(int doctor_id) {
		return csm.getSchedule(doctor_id);
	}

}