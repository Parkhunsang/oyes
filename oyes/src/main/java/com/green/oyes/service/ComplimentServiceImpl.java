package com.green.oyes.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Compliment;
import com.green.oyes.mapper.ComplimentMapper;
@Service
public class ComplimentServiceImpl implements ComplimentService {
	@Autowired
	private ComplimentMapper cm;
	
	public int getTotal() {
		return cm.getTotal();
	}
	
	public List<Compliment> compliment_list(int startRow, int rowPerPage) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("rowPerPage", rowPerPage);
		return cm.compliment_list(map);
	}
	
	public Compliment select(int compliment_no) {
		return cm.select(compliment_no);
	}
	
	public int insert(Compliment compliment) {
		return cm.insert(compliment);
	}
	
	public int update(Compliment compliment) {
		return cm.update(compliment);
	}

	@Override
	public int delete(int compliment_no) {
		return cm.delete(compliment_no);
	}

}
