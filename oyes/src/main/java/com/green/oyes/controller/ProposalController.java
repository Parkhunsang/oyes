package com.green.oyes.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.oyes.dto.Member;
import com.green.oyes.dto.Proposal;
import com.green.oyes.service.MemberService;
import com.green.oyes.service.ProposalService;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/proposal")
public class ProposalController {
	@Autowired
	private MemberService ms;
	@Autowired
	private ProposalService ps;
	
	@GetMapping("/proposal_info")
	public void proposal_info() {	}
	
	@GetMapping("/proposal_insertForm")
	public void proposal_insertForm(HttpSession session, Model model) {
		Object idObject = session.getAttribute("patient_no");

		/* int patient_no = 0; */
		int patient_no = (int) session.getAttribute("patient_no");
		Member member = ms.select_p(patient_no);
		if(idObject instanceof Integer) { patient_no =
				(Integer)idObject; }else if (idObject instanceof Long){ patient_no =
				((Long)idObject).intValue(); }else if (idObject instanceof String) {
				patient_no = Integer.parseInt((String)idObject); }
		
		model.addAttribute("member",member);
		model.addAttribute("patient_no",patient_no);
	}
	
	@PostMapping("/proposal_insert")
	public void proposal_insert(Proposal proposal, Model model) {
		int result = 0;
		Proposal proposal2 = ps.select(proposal.getProposal_no());
		if(proposal2 == null) result = ps.insert(proposal);
		else result = -1;
		model.addAttribute("result",result);
	}
	@GetMapping("/proposal_detail")
	public void proposal_detail (@RequestParam("proposal_no") int proposal_no, HttpSession session, Model model) {
		Object idObject = session.getAttribute("patient_no");
		int patient_no = (int) session.getAttribute("patient_no");
		Member member = ms.select_p(patient_no);
		if(idObject instanceof Integer) { patient_no =
				(Integer)idObject; }else if (idObject instanceof Long){ patient_no =
				((Long)idObject).intValue(); }else if (idObject instanceof String) {
				patient_no = Integer.parseInt((String)idObject); }
		
		Proposal proposal = ps.select(proposal_no);
		
		
		model.addAttribute("proposal",proposal);
		model.addAttribute("member",member);
		model.addAttribute("patient_no",patient_no);
	}
	@GetMapping("/proposal_updateForm")
	public void proposal_update(@RequestParam("proposal_no") int proposal_no, Model model) {
		Proposal proposal = ps.select(proposal_no);
		model.addAttribute("proposal",proposal);
	}
	@PostMapping("/proposal_update")
	public void proposal_update(Proposal proposal, Model model) {
		int result = ps.update(proposal);
		model.addAttribute("result",result);
	}
	@GetMapping("/proposal_delete")
	 public void proposal_delete(@RequestParam("proposal_no") int proposal_no, Model model) {
		 int result = ps.delete(proposal_no);
		 model.addAttribute("result",result);
	 }
}
