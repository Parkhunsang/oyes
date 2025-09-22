package com.green.oyes.controller;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.oyes.dto.Member;
import com.green.oyes.dto.Outpatient;
import com.green.oyes.dto.Center;
import com.green.oyes.dto.ClinicSession;
import com.green.oyes.dto.Department;
import com.green.oyes.dto.Doctor;
import com.green.oyes.service.CenterService;
import com.green.oyes.service.ClinicSessionService;
import com.green.oyes.service.DepartmentService;
import com.green.oyes.service.DoctorService;
import com.green.oyes.service.MemberService;
import com.green.oyes.service.OutpatientService;

import jakarta.servlet.http.HttpSession;
@Controller
public class OutpatientController {
	@Autowired
	private MemberService ms;
	@Autowired
	private DepartmentService ds;
	@Autowired
	private CenterService cs;
	@Autowired
	private DoctorService dts;
	@Autowired
	private ClinicSessionService css;
	@Autowired
	private OutpatientService os;
	

	@GetMapping("/outpatient/outpatientForm")
	public void outpatientForm(Model model, HttpSession session) {
		String patient_id = (String)session.getAttribute("patient_id");
		//	진료과 모두 보이기
		List<Department> list = ds.list(); 
		model.addAttribute("list",list);
		
		List<Center> list2 = cs.list();
		model.addAttribute("list2",list2);
		
		Member member = ms.select(patient_id);
		model.addAttribute("member",member);
	}
	@GetMapping("/outpatient/departmentSelect")
	public void departmentSelect(@RequestParam(value="department_id",required = false) int department_id,  Model model, HttpSession idsession) {
		Department department = ds.select(department_id);
		List<Doctor> list = dts.list(department_id);
		
		// 각 의사의 진료 시간표 정보를 가져와서 사용하기 쉬운 Map 형태로 가공
		for (Doctor doctor : list) {
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
		
		model.addAttribute("department",department);
		model.addAttribute("list",list);
		
		String patient_id = (String)idsession.getAttribute("patient_id");
		Member member = ms.select(patient_id);
		model.addAttribute("member",member);
	}
	@GetMapping("/outpatient/centerSelect")
	public void centerSelect(@RequestParam(value="center_id",required = false) int center_id, Model model, HttpSession idsession) {
		Center center = cs.selectC(center_id);
		List<Doctor> list = dts.listC(center_id);
		
		for (Doctor doctor : list) {
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
		
		model.addAttribute("center",center);
		model.addAttribute("list",list);
		
		String patient_id = (String)idsession.getAttribute("patient_id");
		Member member = ms.select(patient_id);
		model.addAttribute("member",member);
	}
	
	@GetMapping("/outpatient/doctorSelect")
	public void doctorSelect(@RequestParam(value="doctor_id",required = false) int doctor_id,
							@RequestParam(value="department_id",required = false) Integer department_id,
							@RequestParam(value="center_id",required = false) Integer center_id,
							Model model, HttpSession session) {
		Doctor doctor = dts.select(doctor_id);

		String patient_id = (String)session.getAttribute("patient_id");
		Member member = ms.select(patient_id);
				
		model.addAttribute("doctor",doctor);
		model.addAttribute("member",member);
		model.addAttribute("department_id", department_id);
		
		// 센터값이 들어오면 보낸다.
		if (center_id != null) {
			Center center = cs.selectC(center_id);
			model.addAttribute("center", center);
		}
	}
	
	@PostMapping("/outpatient/outpatientInsert")
	/*
	 * 파라미터가 무조건 있어야 하는 경우 (required = true 또는 기본값) → int patient_no 써도 괜찮아요. 
	 * 파라미터가 없을 수도 있는 경우 (required = false) → Integer patient_no로 써야 오류 안나요.
	 */
	public void outpatientInsert(@RequestParam(value="patient_no",required = false) int patient_no,
						@RequestParam(value="doctor_id",required = false) int doctor_id,
						@RequestParam(value="department_id",required = false) Integer department_id,
						@RequestParam(value="center_id",required = false) Integer center_id,
						@RequestParam(value="outpatient_date",required = false) Date outpatient_date,
						@RequestParam(value="outpatient_time",required = false) String outpatient_time,
						Model model, HttpSession session) {
		int result = 0;
		
		String patient_id = (String)session.getAttribute("patient_id");
		Member member = ms.select(patient_id);
		
		Outpatient outpatient = new Outpatient();
		outpatient.setPatient_no(patient_no);
		outpatient.setDoctor_id(doctor_id);
		outpatient.setDepartment_id(department_id);
		outpatient.setOutpatient_date(outpatient_date);
		outpatient.setOutpatient_time(outpatient_time);
		
		if(center_id == null) {
			result = os.insert(outpatient);
		} else if (center_id != null) {
			outpatient.setCenter_id(center_id);
			result = os.insertC(outpatient);
		}
		
		model.addAttribute("member",member);
		model.addAttribute("result",result);
	}
	
	@GetMapping("/outpatient/outpatientDelete")
	public void outpatientDelete(@RequestParam(value="outpatient_no",required = false) int outpatient_no, Model model) {
		int result = os.delete(outpatient_no);
		model.addAttribute("result",result);
	}
}
	
	
	

