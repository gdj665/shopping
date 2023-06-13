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

	if(request.getParameter("loginId") != null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 요청값 확인
	System.out.println(request.getParameter("id")+"<-- memberJoinAction.jsp id");
	System.out.println(request.getParameter("pw")+"<-- memberJoinAction.jsp pw");
	System.out.println(request.getParameter("ckpw")+"<-- memberJoinAction.jsp checkPw");
	System.out.println(request.getParameter("cstmName")+"<-- memberJoinAction.jsp cstmName");
	System.out.println(request.getParameter("cstmAddress")+"<-- memberJoinAction.jsp cstmAddress");
	System.out.println(request.getParameter("cstmEmail")+"<-- memberJoinAction.jsp cstmEmail");
	System.out.println(request.getParameter("cstmBirth")+"<-- memberJoinAction.jsp cstmBirth");
	System.out.println(request.getParameter("cstmGender")+"<-- memberJoinAction.jsp cstmGender");
	System.out.println(request.getParameter("cstmPhone")+"<-- memberJoinAction.jsp cstmPhone");
	System.out.println(request.getParameter("cstmAgree")+"<-- memberJoinAction.jsp cstmAgree");
	
	if(request.getParameter("id") ==null || request.getParameter("id").equals("")){
		response.sendRedirect(request.getContextPath()+"/customer/memberJoin.jsp");
		return;
	}
	
	String msg = null;
	if(request.getParameter("pw") == null || request.getParameter("pw").equals("")){
		msg = "비밀번호를 입력하세요";
	} else if(request.getParameter("ckpw") == null || request.getParameter("ckpw").equals("")){
		msg = "비밀번호가 다릅니다";
	} else if(request.getParameter("cstmName") == null || request.getParameter("cstmName").equals("")){
		msg = "이름을 입력하세요";
	} else if(request.getParameter("cstmAddress") == null || request.getParameter("cstmAddress").equals("")){
		msg = "주소를 입력하세요";
	} else if(request.getParameter("cstmEmail") == null || request.getParameter("cstmEmail").equals("")){
		msg = "이메일을 입력하세요";
	} else if(request.getParameter("cstmBirth") == null || request.getParameter("cstmBirth").equals("")){
		msg = "생일을 입력하세요";
	} else if(request.getParameter("cstmGender") == null || request.getParameter("cstmGender").equals("")){
		msg = "성별을 입력하세요"; 
	} else if(request.getParameter("cstmPhone") == null || request.getParameter("cstmPhone").equals("")){
		msg = "전화번호를 입력하세요";
	
	} if(msg != null){
		response.sendRedirect(request.getContextPath()+"/customer/memberJoin.jsp?msg="+msg);
		return;
	}

	
	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String cstmName = request.getParameter("cstmName");
	String cstmAddress = request.getParameter("cstmAddress");
	String cstmEmail = request.getParameter("cstmEmail");
	String cstmBirth = request.getParameter("cstmBirth");
	String cstmPhone = request.getParameter("cstmPhone");
	String cstmGender = request.getParameter("cstmGender");
	String cstmAgree = request.getParameter("cstmAgree");

	
	//IdList 클래스에 변수값저장
	IdList idList = new IdList();
	idList.setId(id);
	idList.setLastPw(pw);
	//MemberDao 메소드 사용 선언
	MemberDao insertId = new MemberDao();
	int row = insertId.insertId(id, pw);
	// Method 받아오는 값에 따라 상황별 분기
	if(row == 3){
		msg = URLEncoder.encode("사용중인 아이디 입니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/memberJoin.jsp?msg="+msg);
			return;
	}
	
	//클래스에 회원정보 담기
	Customer customer = new Customer();
	customer.setId(id);
	customer.setCstmName(cstmName);
	customer.setCstmAddress(cstmAddress);
	customer.setCstmEmail(cstmEmail);
	customer.setCstmBirth(cstmBirth);
	customer.setCstmGender(cstmGender);
	customer.setCstmPhone(cstmPhone);
	customer.setCstmAgree(cstmAgree);
			
	MemberDao insertCustomer = new MemberDao();
	int inCustom = insertCustomer.insertCustomer(customer);
	if(inCustom > 0){
		msg = URLEncoder.encode("회원가입 완료되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/login.jsp?msg="+msg);
		return;
	}
%>