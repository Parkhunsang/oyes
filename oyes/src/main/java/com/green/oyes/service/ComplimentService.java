package com.green.oyes.service;

import java.util.List;

import com.green.oyes.dto.Compliment;


public interface ComplimentService {
	
	int getTotal();
	List<Compliment> compliment_list(int startRow, int rowPerPage);
	Compliment select(int compliment_no);
	int insert(Compliment compliment);
	int update(Compliment compliment);
	int delete(int compliment_no);
	

}
