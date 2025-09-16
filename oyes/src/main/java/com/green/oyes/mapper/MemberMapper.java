package com.green.oyes.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.green.oyes.dto.Member;
@Mapper
public interface MemberMapper {
	Member select(String patientId);
	int insert(Member member);
	int update(Member member);
	int delete(String patientId);

}