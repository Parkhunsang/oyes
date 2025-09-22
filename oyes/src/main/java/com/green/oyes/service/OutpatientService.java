package com.green.oyes.service;

import java.util.List;

import com.green.oyes.dto.Outpatient;

public interface OutpatientService {

	int insert(Outpatient outpatient);

	int insertC(Outpatient outpatient);

	List<Outpatient> select(String patient_id);

	int delete(int outpatient_no);

}
