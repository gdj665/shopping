<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");
	// 로그인 세션 확인
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	//요청값 디버깅
	System.out.println(request.getParameter("id")+"<-- updatePasswordAction id");
	System.out.println(request.getParameter("pw")+"<-- updatePasswordAction pw");
	System.out.println(request.getParameter("checkPw")+"<-- updatePasswordAction checkPw");

	String msg = null;
	
	if(request.getParameter("id") == null 
		|| request.getParameter("onePw") == null
		|| request.getParameter("pw") == null
		|| request.getParameter("checkPw") == null
		|| request.getParameter("id").equals("")
		|| request.getParameter("onePw").equals("")
		|| request.getParameter("pw").equals("")
		|| request.getParameter("checkPw").equals("")){
			msg = URLEncoder.encode("모두입력해주시길 바랍니다.","utf-8");
			response.sendRedirect(request.getContextPath()+"/member/updatePassword.jsp?msg="+msg);
			return;
	}
	
	// 비밀번호가 같은지 체크
	if(!request.getParameter("pw").equals(request.getParameter("checkPw"))){
		msg = URLEncoder.encode("비밀번호가 서로 다릅니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updatePassword.jsp?msg="+msg);
		return;
	}
	
	// 요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	// 비밀번호 확인에 필요한 클래스 선언
	IdList onePw = new IdList();
	onePw.setId(id);
	onePw.setLastPw(pw);
	
	// 비밀번호가 맞는 확인하는 메소드 선언하고 실행
	MemberDao memDao = new MemberDao();
	int checkRow = memDao.ckPw(onePw);
	// 실행값에 따라 분기 0이상이면 비밀번호 맞고 0이면 비밀번호가 틀립니다.
	if(checkRow > 0){
		msg = URLEncoder.encode("비밀번호가 다릅니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updatePassword.jsp?msg="+msg);
		return;
	}
	
	
	IdList idList = new IdList();
	idList.setId(id);
	idList.setLastPw(pw);
	
	
	MemberDao ckPw = new MemberDao();
	int ckRow = ckPw.checkPwList(idList);
	
	if(ckRow > 0){
		msg = URLEncoder.encode("이전에 사용한 비밀번호입니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updatePassword.jsp?msg="+msg);
		return;
	}
	
	
	MemberDao chPw = new MemberDao();
	int chRow = chPw.updatePw(idList);
	if(chRow > 0){
		msg = URLEncoder.encode("비밀번호가 변경이 완료되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/member/myPage.jsp?msg="+msg);
		return;
	} 
%>