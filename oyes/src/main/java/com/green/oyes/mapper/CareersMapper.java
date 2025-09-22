package com.green.oyes.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.Careers;

@Mapper
public interface CareersMapper {
	int getTotal(Map<String, Object> map);
	List<Careers> list(Map<String, Object> map);
	Careers select(int num);
	int insert(Careers careers);
	int update(Careers careers);
	int delete(Careers careers);
}
