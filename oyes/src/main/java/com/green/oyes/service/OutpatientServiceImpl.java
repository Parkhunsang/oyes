package com.green.oyes.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Outpatient;
import com.green.oyes.mapper.OutpatientMapper;

@Service
public class OutpatientServiceImpl implements OutpatientService {
	@Autowired
	private OutpatientMapper om;

	@Override
	public int insert(Outpatient outpatient) {
		return om.insert(outpatient);
	}

	@Override
	public int insertC(Outpatient outpatient) {
		return om.insertC(outpatient);
	}

	@Override
	public List<Outpatient> select(String patient_id) {
		return om.select(patient_id);
	}

	@Override
	public int delete(int outpatient_no) {
		return om.delete(outpatient_no);
	}


}
