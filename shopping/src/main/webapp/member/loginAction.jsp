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
	
	if(row == 0){
		msg = URLEncoder.encode("회원탈퇴한 아이디 입니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/member/login.jsp?msg="+msg);
		return;
	}
	int cstmCnt = memDao.login(idList);
	
	if(cstmCnt > 0){
		session.setAttribute("loginId", id);
		System.out.print("로그인성공" + session.getAttribute("loginId"));
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	// 사원 등급에 맞게 세션정보를 저장해야되므로분기
	// 등급 클래스에서 가져오기
	MemberDao checkEmpId = new MemberDao();
	IdList level = new IdList();
	
	// idList 객체를 적절히 초기화하고 값을 설정한다.

	List<String> id_list = new ArrayList<>();
	id_list.add("id1");
	id_list.add("id2");
	id_list.add("id3");
	
	MemberDao memberDao = new MemberDao();
	
	for (String Id : id_list) {
	    memberDao.adminLogin(id);
	}
	
	if(level.equals("3")){
		session.setAttribute("loginEmpId3", id);
		System.out.print("3등급 관리자  : " + session.getAttribute("loginCstmId3"));
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	if(level.equals("2")){
		session.setAttribute("loginEmpId2", id);
		System.out.print("2등급 관리자 : " + session.getAttribute("loginCstmId2"));
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	if(level.equals("1")){
		session.setAttribute("loginEmpId1", id);
		System.out.print("1등급 관리자 : " + session.getAttribute("loginCstmId1"));
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

%>