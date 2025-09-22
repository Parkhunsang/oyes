package com.green.oyes.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.Center;

@Mapper
public interface CenterMapper {

	List<Center> list();

	List<Center> keywordList(Map<String, Object> map);

	Center select(int center_id);

	Center selectC(int center_id);



}
