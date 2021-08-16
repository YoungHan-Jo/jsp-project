package com.example.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class RememberMeFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		// 정보 수집을 위한 다운캐스팅
		HttpServletRequest req = (HttpServletRequest) request;

		// 요청 사용자의 세션 가져오기
		HttpSession session = req.getSession();

		String id = (String) session.getAttribute("sessionLoginId");

		if (id == null) { // 세션에 로그인 된 아이디가 없고 쿠키가 있으면 쿠키를 찾아와 로그인 처리
			// 쿠키 배열객체 가져오기
			Cookie[] cookies = req.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("cookieLoginId")) {
						id = cookie.getValue();
						// 세션에 저장(로그인 처리)
						session.setAttribute("sessionLoginId", id);
					}
				} // for
			}
		} // if

		// 다음 필터 호출
		chain.doFilter(request, response);

	} // doFilter

}
