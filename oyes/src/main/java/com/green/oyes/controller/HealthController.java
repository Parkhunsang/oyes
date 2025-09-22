package com.green.oyes.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.oyes.dto.HealthSeminar;
import com.green.oyes.dto.Member;
import com.green.oyes.service.HealthSeminarService;
import com.green.oyes.service.MemberService;
import com.green.oyes.service.PageBean;

import jakarta.servlet.http.HttpSession;

@Controller
public class HealthController {
	@Autowired
	private HealthSeminarService hss;
	@Autowired
	private MemberService ms;
	
	@GetMapping("/health/seminarList")
	public void seminarList(@RequestParam(value = "pageNum", defaultValue="") String pageNum,
			@RequestParam(value = "search", defaultValue="") String search,
			@RequestParam(value = "keyword", defaultValue="") String keyword,
			Model model, HttpSession session) {

		int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("") || pageNum.equals("0")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int total = hss.getTotal(search, keyword);
		int startRow = (currentPage - 1) * rowPerPage;
		int num = total - startRow;
	
		//                       건너띌 갯수,   읽어올 갯수
//		List<Board> list = bs.list(startRow, rowPerPage);
		List<HealthSeminar> list = hss.list(startRow, rowPerPage, search, keyword);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
	    // 검색 옵션 (view에서 select 박스에 표시될 이름)
	    String[] title = { "주제", "강사", "장소" };
	    String[] sh = {"seminar_title","seminar_lecturer","seminar_site"};
	    // Model에 데이터 추가
	    model.addAttribute("list", list);
	    model.addAttribute("pb", pb);
	    model.addAttribute("search", search);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("title", title);
	    model.addAttribute("sh", sh);
	    model.addAttribute("pageNum", pageNum);
	    model.addAttribute("num", num);
	    
	    // admin은 관리버튼 보이기 위해
	    String patient_id = (String)session.getAttribute("patient_id");
		if (patient_id != null) {
			Member member = ms.select(patient_id);
			model.addAttribute("member", member);
		}
	}	
	@GetMapping("/health/seminarInsertForm")
	public void seminarInsertForm() {
		
	}
	@PostMapping("/health/seminarInsert")
	public void seminarInsert(HealthSeminar healthSeminar, Model model) { 
		int result = hss.insert(healthSeminar);		
		model.addAttribute("result", result);
	}
	@GetMapping("/health/seminarDetail")
	public void seminarDetail(@RequestParam(value="seminar_no",required = false) int seminar_no, Model model, HttpSession session) {
		HealthSeminar healthSeminar = hss.select(seminar_no);
		model.addAttribute("list",healthSeminar);
		
	    // admin은 관리버튼 보이기 위해
	    String patient_id = (String)session.getAttribute("patient_id");
		if (patient_id != null) {
			Member member = ms.select(patient_id);
			model.addAttribute("member", member);
		}
	}
	@GetMapping("/health/seminarUpdateForm")
	public void seminarUpdateForm(@RequestParam(value="seminar_no",required = false) int seminar_no, Model model) {
		HealthSeminar healthSeminar = hss.select(seminar_no);
		model.addAttribute("list",healthSeminar);		
	}
	@PostMapping("/health/seminarUpdate")
	public void seminarUpdate(HealthSeminar healthSeminar, Model model) {
		int result = hss.update(healthSeminar);
		model.addAttribute("result",result);
		model.addAttribute("list",healthSeminar);
	}
	@GetMapping("/health/seminarDelete")
	public void seminarDelete(@RequestParam(value="seminar_no",required = false) int seminar_no, Model model) {
		HealthSeminar healthSeminar = hss.select(seminar_no);  // 삭제후에 해당 부서에서 데이터가 삭제 됐는지 확인
		int result = hss.delete(seminar_no);
		model.addAttribute("result", result);
		model.addAttribute("list", healthSeminar);
	}
	
//	건강강좌영상
	@GetMapping("/health/videoList")
	public void videoList (@RequestParam(value = "pageNum", defaultValue="") String pageNum,
			@RequestParam(value = "search", defaultValue="") String search,
			@RequestParam(value = "keyword", defaultValue="") String keyword,
			Model model, HttpSession session) {

		int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("") || pageNum.equals("0")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int total = hss.getTotal(search, keyword);
		int startRow = (currentPage - 1) * rowPerPage;
		int num = total - startRow;
	
		//                       건너띌 갯수,   읽어올 갯수
//		List<Board> list = bs.list(startRow, rowPerPage);
		List<HealthSeminar> list = hss.list(startRow, rowPerPage, search, keyword);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
	    // 검색 옵션 (view에서 select 박스에 표시될 이름)
	    String[] title = { "주제" };
	    String[] sh = {"video_title" };
	    // Model에 데이터 추가
	    model.addAttribute("list", list);
	    model.addAttribute("pb", pb);
	    model.addAttribute("search", search);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("title", title);
	    model.addAttribute("sh", sh);
	    model.addAttribute("pageNum", pageNum);
	    model.addAttribute("num", num);
	    
	    // admin은 관리버튼 보이기 위해
	    String patient_id = (String)session.getAttribute("patient_id");
		if (patient_id != null) {
			Member member = ms.select(patient_id);
			model.addAttribute("member", member);
		}
	}	
}
