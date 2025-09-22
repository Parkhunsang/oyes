package com.green.oyes.service;

import java.util.List;

import com.green.oyes.dto.HealthSeminar;

public interface HealthSeminarService {
	
	int getTotal(String search, String keyword);
	List<HealthSeminar> list(int startRow, int rowPerPage, String search, String keyword);
	HealthSeminar select(int seminar_no);
	int insert(HealthSeminar healthSeminar);
	int update(HealthSeminar healthSeminar);
	int delete(int seminar_no);

}
