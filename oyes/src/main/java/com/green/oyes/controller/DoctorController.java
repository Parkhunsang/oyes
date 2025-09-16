package com.green.oyes.controller;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestParam;

import com.green.oyes.dto.Department;
import com.green.oyes.dto.Doctor;
import com.green.oyes.dto.DoctorExtra; // New import
import com.green.oyes.service.DepartmentService;
import com.green.oyes.service.DoctorService;
import com.green.oyes.service.DoctorExtraService; // New import


@Controller
public class DoctorController {
    @Autowired
    private DoctorService ds;
    @Autowired
    private DepartmentService dps;
    @Autowired
    private DoctorExtraService des; // New autowired service

    @GetMapping("/department/doctorList")
    public void doctorList(@RequestParam("department_id") int department_id, Model model) {
        Department department=dps.select(department_id);
        List<Doctor> doctorList = ds.list(department_id);
        model.addAttribute("department",department);
        model.addAttribute("doctorList", doctorList);
        
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
    }
    
    @GetMapping("/department/doctorDetail")
    public void doctorDetail(@RequestParam("doctor_id") int doctor_id, Model model) { // Parameter changed
        Doctor doctor = ds.select(doctor_id);
        List<DoctorExtra> doctorExtraList = des.getDoctorExtra(doctor_id);
        Department department = dps.select(doctor.getDepartment_id());

        model.addAttribute("doctor", doctor);
        model.addAttribute("doctor_id",doctor.getDoctor_id());
        model.addAttribute("doctorExtraList", doctorExtraList);
        model.addAttribute("department", department);
    }
    
    

}
