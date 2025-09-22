package com.green.oyes.service;

import com.green.oyes.dto.Proposal;

public interface ProposalService {

	Proposal select(int proposal_no);

	int insert(Proposal proposal);

	int update(Proposal proposal);

	int delete(int proposal_no);

}
