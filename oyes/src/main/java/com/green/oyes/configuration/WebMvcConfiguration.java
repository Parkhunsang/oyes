package com.green.oyes.configuration;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.green.oyes.service.SessionChk;

@Configuration //세션체크시 어노테이션 선언
public class WebMvcConfiguration implements WebMvcConfigurer{
	@Override
	public void addInterceptors(InterceptorRegistry registry) {	
		List<String> list = new ArrayList<>(); // 1. 리스트에 세션체크할 URL을 담는다
		list.add("/**/mypage"); list.add("/**/kakaoMypage");
		list.add("/**/kakaomain"); list.add("/**/buyAcademy");
		list.add("/**/buyComplete"); list.add("/**/cartList");
		list.add("/**/academyDetail"); list.add("/**/attend");
		
		//세션체크할 URL을 담은 list객체로 세션체크
		registry.addInterceptor(new SessionChk()).addPathPatterns(list);	// /**/[어떤패키지든관계없이]main url들어오면 체크해 .... ~ 
	}

}
