package com.green.oyes.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.green.oyes.dto.Compliment;
import com.green.oyes.dto.Favorite;
import com.green.oyes.dto.Member;
import com.green.oyes.dto.Proposal;

@Mapper
public interface MypageMapper {

	Member select(String patient_id);
	List<Favorite> select_mydoctor(int patient_no);
	int deleteFavorite(int favorite_no);
	List<Compliment> select_compliment(int patient_no);
	List<Proposal> select_proposal(int patient_no);

}
