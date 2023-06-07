<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
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
		response.sendRedirect(request.getContextPath()+"/mamber/login.jsp?msg="+msg);
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
		response.sendRedirect(request.getContextPath()+"/member/login.jsp?msg="+msg);
		return;
	}
	if(row == 0){
			msg = URLEncoder.encode("없는 아이디 입니다","utf-8");
			response.sendRedirect(request.getContextPath()+"/member/login.jsp?msg="+msg);
			return;
	}
	if(row == 1){
		
		//dao 사용하여 고객인지 확인
		MemberDao checkCstmId = new MemberDao();
		int cstmCnt = checkCstmId.loginCstmId(idList);
		
		// dao 사용하여 사원인지 확인
		MemberDao  checkEmpId = new MemberDao();
		int empCnt = checkEmpId.loginEmpId(idList);
		
		//고객도 아니고 사원도 아니라면 로그인 하면 안되므로 정보가 없는 아이디라고 메세지와 함께 되돌려보낸다
		if(cstmCnt == 0 && empCnt == 0){
			msg = URLEncoder.encode("정보가 없는 아이디 입니다","utf-8");
			response.sendRedirect(request.getContextPath()+"/member/login.jsp?msg="+msg);
			return;
		}
		
		if(cstmCnt > 0){
			session.setAttribute("loginId", id);
			System.out.print("고객로그인 : " + session.getAttribute("loginId"));
			response.sendRedirect(request.getContextPath()+"/home.jsp");
			return;
		}
		if(empCnt > 0){
		// 사원 등급에 맞게 세션정보를 저장해야되므로분기
		// 등급 클래스에서 가져오기
		MemberDao checkEmpLebel = new MemberDao();
		String level = checkEmpLebel.loginEmpLevel(idList);
		if(level.equals("2")){
			session.setAttribute("loginEmpId2", id);
			System.out.println("최고관리자 로그인 :" + session.getAttribute("loginEmpId2"));
			response.sendRedirect(request.getContextPath()+"/home.jsp");
			return;
		}
		if(level.equals("1")){
			session.setAttribute("loginEmpId1", id);
			System.out.println("일반관리자 로그인 : " + session.getAttribute("loginEmpId1"));
			response.sendRedirect(request.getContextPath()+"/home.jsp");
			return;
				}
			}
		}

%>