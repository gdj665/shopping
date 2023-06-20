<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "dao.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	
	if(session.getAttribute("loginId") != null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	// 요청값 디버깅
	System.out.println(request.getParameter("id")+"<-- loginAction.jsp id");
	System.out.println(request.getParameter("lastPw")+"<-- loginAction.jsp pw");
	
	//메세지 출력 변수 선언
	String msg = null;
	
	//요청값 유효성 검사
	if(request.getParameter("id") == null 
	|| request.getParameter("lastPw") == null){
		msg = URLEncoder.encode("아이디 또는 비밀번호가 맞지 않습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/login.jsp?msg="+msg);
		return;
	}
	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("lastPw");

	//요청값 변수 디버깅
	System.out.println(id+"<-- id");
	System.out.println(pw+"<-- pw");
	
	IdList idList = new IdList();
	idList.setId(id);
	idList.setLastPw(pw);

	MemberDao memDao = new MemberDao();
	int row = memDao.login(idList);
	
	if(row == 3){
		msg = URLEncoder.encode("탈퇴한 아이디 입니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/login.jsp?msg="+msg);
		return;
	}
	if(row == 0){
			msg = URLEncoder.encode("없는 아이디 입니다","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/login.jsp?msg="+msg);
			return;
	}
	if(row == 1){
		
		//dao 사용하여 고객인지 확인
		MemberDao checkCstmId = new MemberDao();
		int cstmCnt = checkCstmId.loginCstmId(idList);
		
		
		if(cstmCnt > 0){
			session.setAttribute("loginId", id);
			System.out.print("고객로그인 : " + session.getAttribute("loginId"));
			// 로그인 할시에 비회원 장바구니에 데이터가 있었다면 모두 로그인한 계정 장바구니로 이동
			OrderDao orderDao = new OrderDao();
			orderDao.noLoginAddCart(id, request);
			response.sendRedirect(request.getContextPath()+"/home.jsp");
			return;
		}
		
		}

%>