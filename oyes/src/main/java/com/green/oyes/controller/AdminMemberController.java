package com.green.oyes.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.green.oyes.dto.Member;
import com.green.oyes.service.AdminMemberService;

import jakarta.servlet.http.HttpSession;
@Controller
public class AdminMemberController {
	@Autowired
	private AdminMemberService ams;
	@GetMapping("/admin/adminMain")
	public void adminMain() {}
	@GetMapping("/admin/member/memberList")
	public void memberList(Model model, HttpSession session) {
		List<Member> memberList = ams.select_all();

		model.addAttribute("memberList", memberList);
		
	}
}