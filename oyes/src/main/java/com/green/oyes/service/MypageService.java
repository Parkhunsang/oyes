package com.green.oyes.service;

import java.util.List;

import com.green.oyes.dto.Compliment;
import com.green.oyes.dto.Favorite;
import com.green.oyes.dto.Member;
import com.green.oyes.dto.Proposal;

public interface MypageService {

	Member select(String patient_id);
	List<Favorite> select_mydoctor(int patient_no);
	int deleteFavorite(int favorite_no);
	List<Compliment> select_compliment(int patient_no);
	List<Proposal> select_proposal(int patient_no);

}
