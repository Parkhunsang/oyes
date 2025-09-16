package com.green.oyes.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.oyes.dto.Center;
import com.green.oyes.dto.ClinicSession;
import com.green.oyes.dto.Doctor;
import com.green.oyes.dto.DoctorExtra;
import com.green.oyes.service.CenterService;
import com.green.oyes.service.ClinicSessionService;
import com.green.oyes.service.DoctorExtraService;
import com.green.oyes.service.DoctorService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
public class CenterController {      
	@Autowired
	private CenterService cs;
	@Autowired
	private ClinicSessionService css;
	 @Autowired
    private DoctorService ds;
	 @Autowired
    private DoctorExtraService des;
	
	@GetMapping("/center/centerList")
	public void  centerList(Model model){
		List<Center> centerList = cs.list();
		model.addAttribute("centerList", centerList);
	}
	
	@GetMapping("/center/centerDetail")
	public void centerDetail(@RequestParam("center_id") int center_id, Model model) {
		Center center = cs.select(center_id);
		model.addAttribute("center", center);
	}
	
	@GetMapping("/center/centerPlace")
	public void departmentPlce(@RequestParam("center_id") int center_id, Model model) {
		Center center = cs.select(center_id);
		model.addAttribute("center", center);
	}
	
	@GetMapping("/center/doctorList")
    public void doctorList(@RequestParam("center_id") int center_id, Model model) {
        Center center=cs.selectC(center_id);
        List<Doctor> doctorList = ds.listC(center_id);
        model.addAttribute("center",center);
        model.addAttribute("doctorList", doctorList);
    }
	
	// 의료진 소개 부분
	@GetMapping("/center/doctorDetail")
    public void doctorDetail(@RequestParam("doctor_id") int doctor_id, Model model) { // Parameter changed
        Doctor doctor = ds.select(doctor_id);
        List<DoctorExtra> doctorExtraList = des.getDoctorExtra(doctor_id);
        Center center = cs.select(doctor.getDepartment_id());

        model.addAttribute("doctor", doctor);
        model.addAttribute("doctorExtraList", doctorExtraList);
        model.addAttribute("center", center);
    }
	
	@PostMapping("/center/search")
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
			map.put("end","Z");
		}
		List<Center> centerList= cs.keywordList(map);
		model.addAttribute("centerList",centerList);
		return "/center/centerList :: #frag";
	}
	
	@GetMapping("/center/clinicReservation")
	public void clinicReservateion(@RequestParam("center_id") int center_id, Model model) {
		
		Center center=cs.select(center_id);
		List<Doctor> doctorList = ds.listClinic(center_id);
		
		for (Doctor doctor : doctorList) {
			List<ClinicSession> scheduleList = css.getSchedule(doctor.getDoctor_id());
			doctor.setClinicList(scheduleList);

			Map<String, Map<String, String>> scheduleMap = new HashMap<>();
			if (scheduleList != null) {
				for (ClinicSession session : scheduleList) {
					scheduleMap.computeIfAbsent(session.getWeek(), k -> new HashMap<String, String>()).put(session.getAmPm(), session.getVisit_type());
				}
			}
			doctor.setScheduleMap(scheduleMap);
		}
		model.addAttribute("doctorList", doctorList);  
		model.addAttribute("center",center);
	}
}
