package com.green.oyes.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Member;
import com.green.oyes.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberMapper mm;
	
	public Member select(String patient_id) {
		return mm.select(patient_id);
	}
	public int insert(Member member) {
		return mm.insert(member);
	}
	public int update(Member member) {
		return mm.update(member);
	}
	public int delete(String patient_id) {
		return mm.delete(patient_id);
	}
	public Member select_p(int patient_no) {
		return mm.select_p(patient_no);
	}

}
