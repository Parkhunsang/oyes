package com.green.oyes.controller;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.green.oyes.dto.Member;
import com.green.oyes.service.MemberService;

import jakarta.servlet.http.HttpSession;
@Controller
public class MemberController {
	@Autowired
	private MemberService ms;
	@Autowired
	private BCryptPasswordEncoder bpe;
	@GetMapping("/member/loginForm")
	public void loginForm() {}
	@PostMapping("/member/login")
	public void login(Member member, HttpSession session, Model model) {
		int result = 0;
		Member member2 = ms.select(member.getPatient_id());
		if (member2 == null || member2.getIs_active().equals("n"))
			result = -1; // 없는 아이디
		// 암호화 안한 것을 앞에쓰면 암호화 한 후에 뒤에 값과 비교
		else if (bpe.matches(member.getPassword(), member2.getPassword())) {
			result = 1; // id와 암호가 일치
			session.setMaxInactiveInterval(60 * 60 * 24);   // 2시간
			session.setAttribute("patient_no", member2.getPatient_no());
			session.setAttribute("patient_id", member2.getPatient_id());
			session.setAttribute("is_admin", member2.getIs_admin());

			System.out.println("patient_no="+member2.getPatient_no());
			System.out.println("patient_id="+member2.getPatient_id());
			System.out.println("is_admin="+member2.getIs_admin());
		}
		model.addAttribute("result", result);
	}
	@GetMapping("/member/view")
	public void view(Model model, HttpSession session) {
		main(model, session);
	}
	@GetMapping("/member/logout")
	public void logout(HttpSession session) {
		session.invalidate();
	}
	@GetMapping("/member/delete")
	public void delete(Model model, HttpSession session) {
		String id = (String)session.getAttribute("id");
		int result  = ms.delete(id);
		if (result > 0) session.invalidate();
		model.addAttribute("result", result);
	}
	@GetMapping("/member/updateForm")
	public void updateForm(Model model, HttpSession session) {
		main(model, session);		
	}
	@PostMapping("/member/update")
	public void update(Member member, Model model, HttpSession session) throws IOException {
		String enPass = bpe.encode(member.getPassword());
		member.setPassword(enPass);
		int result = ms.update(member);
		model.addAttribute("result", result);
	}
	@GetMapping("main")
	public void main(Model model, HttpSession session) {
		String id = (String)session.getAttribute("id");
		if (id != null && !id.equals("")) {
			Member member = ms.select(id);
			model.addAttribute("member", member);
		}
	}
	@GetMapping("/member/joinForm")
	public void joinForm() {}
	@PostMapping("/member/join")
	public void join(Member member, Model model) throws  IOException {
		int result = 0;
		Member member2 = ms.select(member.getPatient_id());
		if (member2 == null) {
			String encPass = bpe.encode(member.getPassword());
			member.setPassword(encPass);
			result = ms.insert(member);
		} else result = -1;
		model.addAttribute("result", result);
	}

	@GetMapping("/member/idChk")
    public boolean idChk(@RequestParam(value = "patient_id", defaultValue = "") String patient_id) {
    	boolean result = false;
		Member member = ms.select(patient_id);

		if (member == null) result = true;
		else result = false;

		return result;
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