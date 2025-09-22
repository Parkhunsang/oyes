package com.green.oyes.service;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SessionChk implements HandlerInterceptor {

	@Override
	// pre입력후 스페이스바통해 메소드생성 
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception
	{
	 //로그인안했으면 loginForm으로보내는 로직작성 
	 HttpSession session = request.getSession();
	  //session을 읽어서 
	 if(session == null || session.getAttribute("patient_id") == null) {
	  //id가있는지 체크한뒤 없으면 
	  response.sendRedirect("/member/loginForm"); //main으로 보내 
	  return false; // 혹시나 Session을 체크하는페이지에서 url을통해 페이지이동시 id가없다면 url주소로 이동하지마 
	  }
	  
	  return true; // id가있다면 페이지이동해 
	}
	 
}
