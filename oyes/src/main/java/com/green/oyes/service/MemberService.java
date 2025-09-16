package com.green.oyes.service;

import com.green.oyes.dto.Member;
public interface MemberService {
	Member select(String patient_id);
	int insert(Member member);
	int update(Member member);
	int delete(String patient_id);

}