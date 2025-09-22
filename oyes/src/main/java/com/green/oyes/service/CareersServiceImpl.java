package com.green.oyes.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Careers;
import com.green.oyes.mapper.CareersMapper;

@Service
public class CareersServiceImpl implements CareersService{
	@Autowired
	private CareersMapper cm;
	@Override
	public int getTotal(String search, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("search", search);
		map.put("keyword", keyword);
		return cm.getTotal(map);
	}
	@Override
	public List<Careers> list(int startRow, int rowPerPage, String search, String keyword, String careers_status) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("rowPerPage", rowPerPage);
		map.put("search", search);
		map.put("keyword", keyword);
		map.put("careers_status", careers_status);
		return cm.list(map);
	}
	@Override
	public Careers select(int num) {
		return cm.select(num);
	}
	@Override
	public int insert(Careers careers) {
		return cm.insert(careers);
	}
	@Override
	public int update(Careers careers) {
		return cm.update(careers);
	}
	@Override
	public int delete(Careers careers) {
		return cm.delete(careers);
	}
}
