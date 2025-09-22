package com.green.oyes.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Proposal;
import com.green.oyes.mapper.ProposalMapper;

@Service
public class ProposalServiceImpl implements ProposalService {
	@Autowired
	private ProposalMapper pm;
	
	public int getTotal() {
		return pm.getTotal();
	}
	
	public List<Proposal> proposal_list(int startRow, int rowPerPage) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("rowPerPage", rowPerPage);
		return pm.proposal_list(map);
	}
	
	public Proposal select(int proposal_no) {
		return pm.select(proposal_no);
	}
	
	public int insert(Proposal proposal) {
		return pm.insert(proposal);
	}
	
	public int update(Proposal proposal) {
		return pm.update(proposal);
	}
	
	public int delete(int proposal_no) {
		return pm.delete(proposal_no);
	}
}
