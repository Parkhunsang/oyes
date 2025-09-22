package com.green.oyes.controller;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.io.*;
import com.green.oyes.dto.Center;
import com.green.oyes.dto.CenterDoctor;
import com.green.oyes.dto.Department;
import com.green.oyes.dto.Doctor;
import com.green.oyes.dto.DoctorExtra; // New import
import com.green.oyes.service.CenterService;
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
    @Autowired
    private CenterService cs;

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
        model.addAttribute("doctor", doctor);
        
        List<DoctorExtra> doctorExtraList = des.getDoctorExtra(doctor_id);
        model.addAttribute("doctorExtraList", doctorExtraList);
        
        Department department = dps.select(doctor.getDepartment_id());
//        model.addAttribute("doctor_id",doctor.getDoctor_id());
        model.addAttribute("department", department);
        
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
    
    @GetMapping("/admin/doctor/doctorList")
    public void adminDoctor(Model model) {
    	List<Doctor> doctorList = ds.listAdmin();
    	model.addAttribute("doctorList",doctorList);
    }
    
    @GetMapping("/admin/doctor/updateForm")
    public void updateForm(@RequestParam("doctor_id") int doctor_id, Model model) {
    	Doctor doctor = ds.select(doctor_id);
    	model.addAttribute("doctor", doctor);
    	
    	List<Department> departmentList = dps.list();
    	model.addAttribute("departmentList", departmentList);
    	
    	List<Center> centerList = cs.list();
    	model.addAttribute("centerList", centerList);
    }
    @PostMapping("/admin/doctor/update")
    public void doctor_update(Doctor doctor, Model model) throws IOException {
    	String doctor_profile_image = doctor.getImg().getOriginalFilename();
		if (doctor_profile_image != null && !doctor_profile_image.equals("")) { // 그림파일 수정
			doctor.setDoctor_profile_image(doctor_profile_image);
			String real = "src/main/resources/static/images";
			FileOutputStream fos = new FileOutputStream(new File(real+"/"+doctor_profile_image));
			fos.write(doctor.getImg().getBytes());
			fos.close();
		}
		int result = ds.update(doctor);
		model.addAttribute("result",result);
    }
    @GetMapping("/admin/doctor/delete")
    public void doctor_delete(@RequestParam("doctor_id") int doctor_id, Model model) {
    	int result = ds.delete(doctor_id);
    	model.addAttribute("result",result);
    }
    @GetMapping("/admin/doctor/addForm")
    public void doctor_addForm(Model model) {
    	List<Department> departmentList = dps.list();
    	model.addAttribute("departmentList", departmentList);
    	
    	List<Center> centerList = cs.list();
    	model.addAttribute("centerList", centerList);
    }
    @PostMapping("/admin/doctor/insert")
   	public void doctor_add(Doctor doctor, Model model) throws IOException {
    	String doctor_profile_image = doctor.getImg().getOriginalFilename();
		doctor.setDoctor_profile_image(doctor_profile_image);
		String real = "src/main/resources/static/images";
		FileOutputStream fos = new FileOutputStream(new File(real+"/"+doctor_profile_image));
		fos.write(doctor.getImg().getBytes());
		fos.close();
		int result = ds.insert(doctor);
		CenterDoctor cd = new CenterDoctor();
		cd.setDoctor_id(doctor.getDoctor_id());
		cd.setCenter_id(doctor.getCenter_id());
		ds.insertCenterDoctor(cd);
		model.addAttribute("result",result);
    }
}
