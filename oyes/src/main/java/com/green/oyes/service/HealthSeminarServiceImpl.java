package com.green.oyes.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.HealthSeminar;
import com.green.oyes.mapper.HealthSeminarMapper;

@Service
public class HealthSeminarServiceImpl implements HealthSeminarService {
	@Autowired
	private HealthSeminarMapper hsm;
	
	@Override
	public int getTotal(String search, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search", search);
		map.put("keyword", keyword);
		return hsm.getTotal(map);
	}	
	@Override
	public List<HealthSeminar> list(int startRow, int rowPerPage, String search, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("rowPerPage", rowPerPage);
		map.put("search", search);
		map.put("keyword", keyword);
		return hsm.list(map);
	}
	@Override
	public HealthSeminar select(int seminar_no) {
		return hsm.select(seminar_no);
	}
	@Override
	public int insert(HealthSeminar healthSeminar) {
		return hsm.insert(healthSeminar);
	}
	@Override
	public int update(HealthSeminar healthSeminar) {
		return hsm.update(healthSeminar);
	}
	@Override
	public int delete(int seminar_no) {
		return hsm.delete(seminar_no);
	}



}
