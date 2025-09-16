package com.green.oyes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Compliment;
import com.green.oyes.dto.Favorite;
import com.green.oyes.dto.Member;
import com.green.oyes.dto.Proposal;
import com.green.oyes.mapper.MypageMapper;

@Service
public class MypageServiceImpl implements MypageService{
	@Autowired
	private MypageMapper ym;

	public Member select(String patient_id) {
		return ym.select(patient_id);
	}

	public List<Favorite> select_mydoctor(int patient_no) {
		return ym.select_mydoctor(patient_no);
	}

	public int deleteFavorite(int favorite_no) {
		return ym.deleteFavorite(favorite_no);
	}

	public List<Compliment> select_compliment(int patient_no) {
		return ym.select_compliment(patient_no);
	}

	public List<Proposal> select_proposal(int patient_no) {
		return ym.select_proposal(patient_no);
	}
}
