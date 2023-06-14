<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	System.out.println(request.getParameter("id")+"<-- deleteCustomerAction.jsp id");
	//메세지 변수 선언
	String msg = null;
	//요청값 유효성 검사
	if(request.getParameter("id") == null || request.getParameter("id").equals("")){
		msg = "";
	} else if (request.getParameter("lastPw") == null || request.getParameter("lastPw").equals("")){
		
		msg = URLEncoder.encode("아이디 또는 비밀번호가 다릅니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/memberOut.jsp?msg="+msg);
		return;
	}
	
	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("lastPw");
	
	//변수클래스에 저장
	IdList onePw = new IdList();
	onePw.setId(id);
	onePw.setLastPw(pw);
	
	
	// 삭제 메소드 선언
	MemberDao deleteCstm = new MemberDao();
	int row = deleteCstm.deleteCustm(id);
	
	if(row > 0){
		msg = URLEncoder.encode("탈퇴되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/home.jsp?msg="+msg);
		return;
	}
%>