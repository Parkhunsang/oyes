package com.green.oyes.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LayoutController {
	@GetMapping("/index")
	public void index() {}
	@GetMapping("/hello")
	public void hello() {}
}