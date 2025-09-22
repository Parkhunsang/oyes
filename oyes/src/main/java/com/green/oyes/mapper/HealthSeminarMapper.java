package com.green.oyes.mapper;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.HealthSeminar;
@Mapper
public interface HealthSeminarMapper {
	int getTotal(Map<String, Object> map);
	List<HealthSeminar> list(Map<String, Object> map);
	HealthSeminar select(int seminar_no);
	int insert(HealthSeminar healthSeminar);
	int update(HealthSeminar healthSeminar);
	int delete(int seminar_no);
}
