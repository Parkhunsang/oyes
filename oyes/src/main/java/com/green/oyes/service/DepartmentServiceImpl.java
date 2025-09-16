package com.green.oyes.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Department;
import com.green.oyes.mapper.DepartmentMapper;
@Service
public class DepartmentServiceImpl implements DepartmentService{
	@Autowired
	private DepartmentMapper dm;
	public List<Department> list() {		
		return dm.list();
	}
	@Override
	public List<Department> keywordList(Map<String, Object> map) {		
		return dm.keywordList(map);
	}
	@Override
	public Department select(int department_id) {
		return dm.select(department_id);
	}

}
