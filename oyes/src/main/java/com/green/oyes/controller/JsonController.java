package com.green.oyes.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.oyes.dto.ClinicSession;
import com.green.oyes.service.ClinicSessionService;

@RestController
public class JsonController {
	@Autowired
	private ClinicSessionService css;
	@PostMapping("/data")
	public List<ClinicSession> calendar(@RequestParam("doctor_id") int doctor_id, Model model) {
		List<ClinicSession> calList = css.getSchedule(doctor_id);

		return calList;
	}
}
