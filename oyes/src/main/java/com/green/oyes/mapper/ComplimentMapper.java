package com.green.oyes.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.Compliment;

@Mapper
public interface ComplimentMapper {
	//전체갯수
	int getTotal();
	
	//리스트조회
	List<Compliment> compliment_list(Map<String, Object> map);
	
	//상세, 수정폼
	Compliment select(int compliment_no);
	
	//입력
	Compliment select(String compliment_title);
	int insert(Compliment compliment);
	
	//	수정
	int update(Compliment compliment);

	//	삭제
	int delete(int compliment_no);
	

}
