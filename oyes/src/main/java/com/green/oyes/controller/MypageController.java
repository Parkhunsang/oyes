package com.green.oyes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.green.oyes.dto.Compliment;
import com.green.oyes.dto.Favorite;
import com.green.oyes.dto.Member;
import com.green.oyes.dto.Outpatient;
import com.green.oyes.dto.Proposal;
import com.green.oyes.service.MypageService;
import com.green.oyes.service.OutpatientService;

import jakarta.servlet.http.HttpSession;
@Controller
public class MypageController {
	@Autowired
	private MypageService ys;
	@Autowired
	private BCryptPasswordEncoder bpe;
	@Autowired
	private OutpatientService os;

	@PostMapping("/mypage/deleteFavorite/{favorite_no}")
    public String deleteFavorite(@PathVariable("favorite_no") int favorite_no) {
	       	int result = ys.deleteFavorite(favorite_no);
			return "redirect:/mypage/myfavoritedoctor";
	}
    @GetMapping("/mypage/myfavoritedoctor")
	public void myfavoritedoctor(Model model, HttpSession session) {
		String patient_id = (String)session.getAttribute("patient_id");
		if (patient_id != null && !patient_id.equals("")) {
			Member member = ys.select(patient_id);
			List<Favorite> favList = ys.select_mydoctor(member.getPatient_no());
			
			model.addAttribute("member", member);
			model.addAttribute("favList", favList);
		}
	}
	@GetMapping("/mypage/myreservation_1")
	public void myreservation_1(Model model, HttpSession session) {
		String patient_id = (String)session.getAttribute("patient_id");
		if (patient_id != null && !patient_id.equals("")) {
			Member member = ys.select(patient_id);
			model.addAttribute("member", member);
		}
//		예약내역 뿌리기
		List<Outpatient> list = os.select(patient_id);
		model.addAttribute("list",list);
	}
	@GetMapping("/mypage/myreservation_2")
	public void myreservation_2(Model model, HttpSession session) {
		String patient_id = (String)session.getAttribute("patient_id");
		if (patient_id != null && !patient_id.equals("")) {
			Member member = ys.select(patient_id);
			model.addAttribute("member", member);
		}
	}
	@GetMapping("/mypage/mythank")
	public void mythank(Model model, HttpSession session) {
		String patient_id = (String)session.getAttribute("patient_id");
		if (patient_id != null && !patient_id.equals("")) {
			Member member = ys.select(patient_id);
			List<Compliment> compList = ys.select_compliment(member.getPatient_no());

			model.addAttribute("member", member);
			model.addAttribute("compList", compList);
		}
	}
	@GetMapping("/mypage/myproposal")
	public void myproposal(Model model, HttpSession session) {
		String patient_id = (String)session.getAttribute("patient_id");
		if (patient_id != null && !patient_id.equals("")) {
			Member member = ys.select(patient_id);
			List<Proposal> propList = ys.select_proposal(member.getPatient_no());

			model.addAttribute("member", member);
			model.addAttribute("propList", propList);
		}
		
	}
	@GetMapping("/mypage/myinfo")
	public void myinfo(Model model, HttpSession session) {
		String patient_id = (String)session.getAttribute("patient_id");
		if (patient_id != null && !patient_id.equals("")) {
			Member member = ys.select(patient_id);
			model.addAttribute("member", member);
		}
	}
   
    
    
/*
    @PostMapping(value = "/member/idChk", produces = "text/html;charset=utf-8")
	@ResponseBody
	public void idChk(@RequestParam(value = "patient_id", defaultValue = "") String patient_id, Model model) {
    	boolean result = false;
		Member member = ms.select(patient_id);

		if (member == null) result = true;
		else result = false;

		return result;
	}
*/	
}