package com.green.oyes.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Center;
import com.green.oyes.mapper.CenterMapper;
@Service
public class CenterServiceImpl implements CenterService{
	@Autowired
	private CenterMapper cm;
	
	public List<Center> list() {		
		return cm.list();
	}

	public List<Center> keywordList(Map<String, Object> map) {		
		return cm.keywordList(map);
	}

	public Center select(int center_id) {
		return cm.select(center_id);
	}

	@Override
	public Center selectC(int center_id) {
		return cm.selectC(center_id);
	}

}
