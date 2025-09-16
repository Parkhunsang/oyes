package com.green.oyes.service;

import java.util.List;
import java.util.Map;

import com.green.oyes.dto.Department;

public interface DepartmentService {

	List<Department> list();

	List<Department> keywordList(Map<String, Object> map);

	Department select(int department_id);


}
