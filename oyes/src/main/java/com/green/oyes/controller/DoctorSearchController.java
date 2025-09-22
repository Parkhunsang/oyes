package com.green.oyes.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.green.oyes.dto.DoctorSearch;
import com.green.oyes.service.DoctorSearchService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class DoctorSearchController {
	private final DoctorSearchService doctorSearchService;

	@GetMapping("/doctors")
	@ResponseBody
	public List<DoctorSearch> searchDoctors(@RequestParam("keyword") String keyword) {
        return doctorSearchService.findByName(keyword);
    }
	
}
