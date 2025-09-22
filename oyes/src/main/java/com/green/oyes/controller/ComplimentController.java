package com.green.oyes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.green.oyes.dto.Compliment;
import com.green.oyes.dto.Doctor;
import com.green.oyes.dto.Member;
import com.green.oyes.service.ComplimentService;
import com.green.oyes.service.DoctorService;
import com.green.oyes.service.MemberService;
import com.green.oyes.service.PageBean;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/compliment")
@RequiredArgsConstructor
public class ComplimentController {	
	@Autowired
	private final ComplimentService cs;
	@Autowired
	private DoctorService ds;
	@Autowired
	private MemberService ms;
	       
	@GetMapping("/compliment_list")
	public void compliment_list(@RequestParam(value = "pageNum", defaultValue = "1") String pageNum,
            HttpSession session, Model model) {
		int patient_no = (Integer) session.getAttribute("patient_no");
		Member member=  ms.select_p(patient_no);
//		Member member2 = ms.select(member.getPatient_id());
		model.addAttribute("member",member);
		
		int rowPerPage = 6;
		if (pageNum == null || pageNum.equals("")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int total = cs.getTotal();
		int startRow = (currentPage - 1) * rowPerPage;
		int num = total - startRow;

		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		List<Compliment> compliment_list = cs.compliment_list(startRow, rowPerPage);
		
        model.addAttribute("pb", pb);
        model.addAttribute("compliment_list",compliment_list);
        model.addAttribute("pageNum",pageNum);
        model.addAttribute("num",num);
        
  //      List<Compliment> compliment_all_list = cs.compliment_all_list();
  //      model.addAttribute("compliment_all_list", compliment_all_list);
	}
	
	@GetMapping("/compliment_detail")
    public void compliment_detail(@RequestParam("compliment_no") int compliment_no, Model model) {
        Compliment compliment = cs.select(compliment_no);
        model.addAttribute("compliment", compliment);
    }
	
	@GetMapping("/compliment_insertForm")
	public void compliment_insertForm(HttpSession session,Model model) {
		Object idObject = session.getAttribute("patient_no");

		/* int patient_no = 0; */
		int patient_no = (int) session.getAttribute("patient_no");
		List<Doctor> doctorlist = ds.doctorlist();
		 if(idObject instanceof Integer) { patient_no =
		 (Integer)idObject; }else if (idObject instanceof Long){ patient_no =
		 ((Long)idObject).intValue(); }else if (idObject instanceof String) {
		 patient_no = Integer.parseInt((String)idObject); }

		
		model.addAttribute("patient_no", patient_no);
		model.addAttribute("doctorlist", doctorlist);
	}
	
	@PostMapping("/compliment_insert")
	public void compliment_insert(Compliment compliment, Model model) {
		/*
		 * int patient_no =
		 * Integer.parseInt((String)session.getAttribute("patient_no"));
		 * compliment.setPatient_no(patient_no);
		 * System.out.println(compliment.getPatient_no());
		 */
		int result = 0;
		Compliment compliment2 = cs.select(compliment.getCompliment_no());
		if (compliment2 == null) result = cs.insert(compliment);
		else result = -1; // 이미 있는 데이터
		model.addAttribute("result", result);
	}
	
	@GetMapping("/compliment_updateForm")
	public void compliment_updateForm(@RequestParam("compliment_no") int compliment_no, Model model) {
		Compliment compliment = cs.select(compliment_no);	
		model.addAttribute("compliment", compliment);
	}
	

	 @PostMapping("/compliment_update") 
	 public void compliment_update(Compliment compliment, Model model) { 
		 int result = cs.update(compliment);
		 model.addAttribute("result",result); 
	 }
	 
	 @GetMapping("/compliment_delete")
	 public void compliment_delete(@RequestParam("compliment_no") int compliment_no, Model model) {
		 int result = cs.delete(compliment_no);
		 model.addAttribute("result",result);
	 }
	 
	 @GetMapping("compliment_info")
	 public void compliment_info() { }
	 
	
}
