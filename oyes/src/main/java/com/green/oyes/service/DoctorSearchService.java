package com.green.oyes.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.green.oyes.dto.DoctorSearch;
import com.green.oyes.mapper.DoctorSearchMapper;

@Service
public class DoctorSearchService {
	private final DoctorSearchMapper doctorSearchMapper;
	
	public DoctorSearchService(DoctorSearchMapper doctorSearchMapper) {
		this.doctorSearchMapper = doctorSearchMapper;
	}
	
	public List<DoctorSearch> findByName(String keyword){
		if(keyword == null || keyword.isBlank()) return List.of();
		return doctorSearchMapper.findByNameContaining(keyword.trim(), 10);
	}
}
