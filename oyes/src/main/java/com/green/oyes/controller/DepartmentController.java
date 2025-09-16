package com.green.oyes.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.oyes.dto.Department;
import com.green.oyes.service.DepartmentService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService ds;
	
	@GetMapping("/department/departmentList")
	public void  departmentList(Model model){
		List<Department> departmentList = ds.list();
		model.addAttribute("departmentList",departmentList);

		// [2025-09-15 Gemini 추가] 상단 드롭다운 메뉴(고정) 데이터 추가
	    List<Map<String, String>> navLinks = new ArrayList<>();
	    navLinks.add(Map.of("url", "/department/departmentList", "text", "진료과"));
	    navLinks.add(Map.of("url", "/center/centerList", "text", "센터"));
	    navLinks.add(Map.of("url", "/#", "text", "이용안내"));
	    navLinks.add(Map.of("url", "/#", "text", "고객서비스"));
	    navLinks.add(Map.of("url", "/#", "text", "건강정보"));
	    navLinks.add(Map.of("url", "/#", "text", "병원안내"));
	    model.addAttribute("navLinks", navLinks);

	    // [2025-09-15 Gemini 추가] 상단 드롭다운 메뉴(DB) 데이터 추가
	    List<Department> allDepartments = ds.list();
	    model.addAttribute("allDepartments", allDepartments);
	}
	
	@GetMapping("/department/departmentDetail")
	public void departmentDetail(@RequestParam("department_id") int department_id, Model model) {
		Department department = ds.select(department_id);
		model.addAttribute("department",department);

	    List<Map<String, String>> navLinks = new ArrayList<>();
	    navLinks.add(Map.of("url", "/department/departmentList", "text", "진료과"));
	    navLinks.add(Map.of("url", "/center/centerList", "text", "센터"));
	    navLinks.add(Map.of("url", "/#", "text", "이용안내"));
	    navLinks.add(Map.of("url", "/#", "text", "고객서비스"));
	    navLinks.add(Map.of("url", "/#", "text", "건강정보"));
	    navLinks.add(Map.of("url", "/#", "text", "병원안내"));

	    // [2025-09-15 Gemini 추가] 전체 진료과 목록을 가져와 모델에 추가
	    List<Department> allDepartments = ds.list();
	    model.addAttribute("allDepartments", allDepartments);
	}
	
	@GetMapping("/department/departmentPlace")
	public void departmentPlce(@RequestParam("department_id") int department_id, Model model) {
		Department department = ds.select(department_id);
		model.addAttribute("department",department);
		
		// [2025-09-15 Gemini 추가] 상단 드롭다운 메뉴(고정) 데이터 추가
	    List<Map<String, String>> navLinks = new ArrayList<>();
	    navLinks.add(Map.of("url", "/department/departmentList", "text", "진료과"));
	    navLinks.add(Map.of("url", "/center/centerList", "text", "센터"));
	    navLinks.add(Map.of("url", "/#", "text", "이용안내"));
	    navLinks.add(Map.of("url", "/#", "text", "고객서비스"));
	    navLinks.add(Map.of("url", "/#", "text", "건강정보"));
	    navLinks.add(Map.of("url", "/#", "text", "병원안내"));
	    model.addAttribute("navLinks", navLinks);

	    // [2025-09-15 Gemini 추가] 상단 드롭다운 메뉴(DB) 데이터 추가
	    List<Department> allDepartments = ds.list();
	    model.addAttribute("allDepartments", allDepartments);
	}
	
	@PostMapping("/department/search")
	public String search(@RequestParam("keyword") String keyword, Model model) {
		Map<String, Object> map = new HashMap<>();
		if (keyword.equals("ㄱ")) {
			map.put("start", "가");
			map.put("end","나");
		} else if (keyword.equals("ㄴ")) {
			map.put("start", "나");
			map.put("end","다");
		} else if (keyword.equals("ㄷ")) {
			map.put("start", "다");
			map.put("end","라");
		} else if (keyword.equals("ㄹ")) {
			map.put("start", "라");
			map.put("end","마");
		} else if (keyword.equals("ㅁ")) {
			map.put("start", "마");
			map.put("end","바");
		} else if (keyword.equals("ㅂ")) {
			map.put("start", "바");
			map.put("end","사");
		} else if (keyword.equals("ㅅ")) {
			map.put("start", "사");
			map.put("end","아");
		} else if (keyword.equals("ㅇ")) {
			map.put("start", "아");
			map.put("end","자");
		} else if (keyword.equals("ㅈ")) {
			map.put("start", "자");
			map.put("end","차");
		} else if (keyword.equals("ㅊ")) {
			map.put("start", "차");
			map.put("end","카");
		} else if (keyword.equals("ㅋ")) {
			map.put("start", "카");
			map.put("end","타");
		} else if (keyword.equals("ㅌ")) {
			map.put("start", "타");
			map.put("end","파");
		} else if (keyword.equals("ㅍ")) {
			map.put("start", "파");
			map.put("end","하");
		} else if (keyword.equals("ㅎ")) {
			map.put("start", "하");
			map.put("end","히");
		} else if (keyword.equals("AZ")) {
			map.put("start", "A");
			map.put("end","ZZ");
		} 
		List<Department> departmentList= ds.keywordList(map);
		model.addAttribute("departmentList",departmentList);
		return "/department/departmentList :: #frag";
	}
	
}
