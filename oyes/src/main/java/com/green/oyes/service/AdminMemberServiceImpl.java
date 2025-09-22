package com.green.oyes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Member;
import com.green.oyes.mapper.AdminMemberMapper;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {
	@Autowired
	private AdminMemberMapper amm;

	public List<Member> select_all() {
		// TODO Auto-generated method stub
		return amm.select_all();
	}
	
}
