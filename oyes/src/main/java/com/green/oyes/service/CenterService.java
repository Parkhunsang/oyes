package com.green.oyes.service;

import java.util.List;
import java.util.Map;

import com.green.oyes.dto.Center;

public interface CenterService {

	List<Center> list();

	List<Center> keywordList(Map<String, Object> map);

	Center select(int center_id);

	Center selectC(int center_id);


}
