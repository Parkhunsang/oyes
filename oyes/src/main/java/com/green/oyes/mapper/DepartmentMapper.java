package com.green.oyes.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.Department;
@Mapper
public interface DepartmentMapper {

	List<Department> list();

	List<Department> keywordList(Map<String, Object> map);

	Department select(int department_id);
}
