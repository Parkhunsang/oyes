package com.green.oyes.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.oyes.dto.ClinicSession;
import com.green.oyes.dto.Department;
import com.green.oyes.dto.Doctor;
import com.green.oyes.service.ClinicSessionService;
import com.green.oyes.service.DepartmentService;
import com.green.oyes.service.DoctorService;

@Controller
public class ClinicSessionController {
	@Autowired
	private ClinicSessionService css;
	@Autowired
	private DoctorService ds;
	@Autowired
	private DepartmentService dps;
	
	@GetMapping("/clinicReservation/clinicReservation")
	public void clinicReservateion(@RequestParam("department_id") int department_id, Model model) {
		
		Department department=dps.select(department_id);
		List<Doctor> doctorList = ds.list(department_id);
		
		// 각 의사의 진료 시간표 정보를 가져와서 사용하기 쉬운 Map 형태로 가공
		for (Doctor doctor : doctorList) {
			List<ClinicSession> scheduleList = css.getSchedule(doctor.getDoctor_id());
			doctor.setClinicList(scheduleList); // 원본 리스트도 저장

			Map<String, Map<String, String>> scheduleMap = new HashMap<>();
			if (scheduleList != null) {
				for (ClinicSession session : scheduleList) {
						scheduleMap.computeIfAbsent(session.getWeek(), k -> new HashMap<String, String>()).put(session.getAmPm(), session.getVisit_type());
				}
			}
			doctor.setScheduleMap(scheduleMap);
		}
		
		 List<Map<String, String>> navLinks = new ArrayList<>();
		    navLinks.add(Map.of("url", "/department/departmentList", "text", "진료과"));
		    navLinks.add(Map.of("url", "/center/centerList", "text", "센터"));
		    navLinks.add(Map.of("url", "/#", "text", "이용안내"));
		    navLinks.add(Map.of("url", "/#", "text", "고객서비스"));
		    navLinks.add(Map.of("url", "/#", "text", "건강정보"));
		    navLinks.add(Map.of("url", "/#", "text", "병원안내"));
		    model.addAttribute("navLinks", navLinks);

		    List<Department> allDepartments = dps.list();
		    model.addAttribute("allDepartments", allDepartments);
		
		model.addAttribute("doctorList", doctorList);  
		model.addAttribute("department",department);
	}
}
