<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	//입력값 한글 깨지지 않기 위해 인코딩
	request.setCharacterEncoding("utf-8");
	//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	//요청값 디버깅
	System.out.println(request.getParameter("id")+"<-- updateCustomerAction.jsp id");
	System.out.println(request.getParameter("pw")+"<-- updateCustomerAction.jsp pw");
	System.out.println(request.getParameter("cstmName")+"<-- updateCustomerAction.jsp cstmName");
	System.out.println(request.getParameter("cstmAddress")+"<-- updateCustomerAction.jsp cstmAddress");
	System.out.println(request.getParameter("cstmEmail")+"<-- updateCustomerAction.jsp Email");
	System.out.println(request.getParameter("cstmPhone")+"<-- updateCustomerAction.jsp phone");
	
	
	String msg = null;
	
	
	//요청값 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String cstmName = request.getParameter("cstmName");
	String cstmAddress = request.getParameter("cstmAddress");
	String cstmEmail = request.getParameter("cstmEmail");
	String cstmPhone = request.getParameter("cstmPhone");
	//비밀번호 확인에 필요한 클래스 선언
	IdList onePw = new IdList();
	onePw.setId(id);
	
	onePw.setLastPw(pw);
		

	MemberDao memDao = new MemberDao();
	
	int checkRow = memDao.ckPw(onePw);

	if(checkRow == 0){
		msg = URLEncoder.encode("비밀번호가 다릅니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/updateMember.jsp?msg="+msg);
		return;
	}
		//클래스에 값 저장
		Customer customer = new Customer();
		customer.setId(id);
		customer.setCstmName(cstmName);
		customer.setCstmAddress(cstmAddress);
		customer.setCstmPhone(cstmPhone);
		customer.setCstmEmail(cstmEmail);
		
		int row = memDao.updateCustomer(customer);
		
		if(row > 0){
			msg = URLEncoder.encode("수정이 완료되었습니다","utf-8");
			response.sendRedirect(request.getContextPath()+"/customer/myPage.jsp?msg="+msg);
			return;
		} 
		
%>