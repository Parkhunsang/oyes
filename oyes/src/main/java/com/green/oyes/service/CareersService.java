package com.green.oyes.service;

import java.util.List;

import com.green.oyes.dto.Careers;

public interface CareersService {
	int getTotal(String search, String keyword);
	List<Careers> list(int startRow, int rowPerPage, String search, String keyword, String careers_status);
	Careers select(int num);
	int insert(Careers careers);
	int update(Careers careers);
	int delete(Careers careers);
}
