package com.green.oyes.controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.oyes.dto.Board;
import com.green.oyes.dto.Careers;
import com.green.oyes.service.CareersService;
import com.green.oyes.service.PageBean;

import jakarta.servlet.http.HttpSession;

@Controller
public class CareersController {
	@Autowired
	private CareersService cs;
	@GetMapping("/about/careersView")
	public void view(@RequestParam(value = "num",defaultValue = "0") int num,
		@RequestParam(value="pageNum",defaultValue="") String pageNum, Model model) {
		Careers careers = cs.select(num);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("careers", careers);
	}
	// 채용공고 목록 (모집중/마감 분리 + 검색 + 페이징 + D-day)
	@GetMapping("/about/careersList")
	public void careersList(@RequestParam(value = "pageNum",defaultValue="") String pageNum,
			@RequestParam(value="search",defaultValue="") String search,
			@RequestParam(value="keyword",defaultValue="") String keyword,
			@RequestParam(name = "careers_status", defaultValue = "OPEN") String careers_status, // OPEN / CLOSED
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "12") int size,
			Model model) {
		careers_status = ("CLOSED".equalsIgnoreCase(careers_status)) ? "CLOSED" : "OPEN";
		int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int total = cs.getTotal(search, keyword);
		int startRow = (currentPage - 1)* rowPerPage;
		int num = total - startRow;
		List<Careers> list = cs.list(startRow, rowPerPage, search, keyword, careers_status);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
		//D-day 계산(open일때만)
		LocalDate today = LocalDate.now();
		for (Careers c : list) {
		    if (c.getCareers_end_date() != null) {
		        LocalDate endDate = c.getCareers_end_date().toLocalDate(); // 변환
		        int daysLeft = (int) ChronoUnit.DAYS.between(today, endDate);
		        c.setDaysLeft(daysLeft);
		    }
		}

        String[] title = {"제목","내용", "제목+내용"};
		String[] sh = {"careers_title","careers_content","subcon"};
		model.addAttribute("title", title);
		model.addAttribute("sh", sh);
		model.addAttribute("pb", pb);
		model.addAttribute("search", search);
		model.addAttribute("keyword", keyword);
		model.addAttribute("list", list);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("num", num);
		model.addAttribute("careers_status", careers_status);
	}
	@GetMapping("/about/careersInsertForm")
	public void boardInsertForm(@RequestParam(value = "num",defaultValue = "0") int num,
			@RequestParam(value="pageNum", defaultValue = "") String pageNum,
			Model model) {
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
	}
	@PostMapping("/about/careersInsert")
	public void boardInsert(Careers careers, Model model,
			@RequestParam(value="pageNum",defaultValue="") String pageNum) {
		careers.setPatient_no(10000000);
		int result = cs.insert(careers);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
	}
	@GetMapping("/about/careersUpdateForm")
	public void updateForm(@RequestParam(value = "num",defaultValue = "0") int num,
			@RequestParam(value="pageNum",defaultValue="") String pageNum, Model model) {
		Careers careers = cs.select(num);
		model.addAttribute("careers", careers);
		model.addAttribute("pageNum", pageNum);
	}
	@PostMapping("/about/careersUpdate")
	public void boardUpdate(Careers careers, Model model,
			@RequestParam(value="pageNum",defaultValue="") String pageNum) {
		careers.setPatient_no(10000000);
		int result = cs.update(careers);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
	}
	@GetMapping("/about/careersDelete")
	public void delete(Careers careers,
			@RequestParam(value="pageNum",defaultValue="") String pageNum,Model model) {
		careers.setPatient_no(10000000);
		int result = cs.delete(careers);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
	}	
}
