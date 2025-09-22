package com.green.oyes.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.Proposal;


@Mapper
public interface ProposalMapper {
	//전체갯수
		int getTotal();
		
		//리스트조회(관리자)
		List<Proposal> proposal_list(Map<String, Object> map);
		
		//상세, 수정폼
		Proposal select(int proposal_no);
		
		//입력
		Proposal select(String proposal_title);
		int insert(Proposal proposal);
		
		//	수정
		int update(Proposal proposal);

		//	삭제
		int delete(int proposal_no);
		
}
