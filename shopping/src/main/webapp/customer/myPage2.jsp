<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	//변수에 아이디 저장
	String id = (String)(session.getAttribute("loginId"));

	System.out.println(id+"<-- myPage id");	
	
	MemberDao mamDao = new MemberDao();
	HashMap<String, Object> m = new HashMap<>();
	m = mamDao.selectCstmList(id);
	
	System.out.println(m + "<-- myPage list");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>마이페이지</h1>
		 
	<%
		if(id != null){
	%>
		<table>
			<tr>
				<td>아이디</td>
				<td><%=(String)(m.get("cstmId"))%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=(String)(m.get("cstmName"))%></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><%=(String)(m.get("cstmAddress"))%></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=(String)(m.get("cstmEmail"))%></td>
			</tr>
			<tr>
				<td>생일</td>
				<td><%=(String)(m.get("cstmBirth"))%></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><%=(String)(m.get("cstmPhone"))%></td>
			</tr>
			<tr>
				<td>등급</td>
				<td><%=(String)(m.get("cstmRank"))%></td>
			</tr>
			<tr>
				<td>포인트</td>
				<td><%=(Integer)(m.get("cstmPoint"))%></td>
			</tr>
			<tr>
				<td>가입일</td>
				<td><%=(String)(m.get("createdate"))%></td>
			</tr>
		</table>
		
		<a href="<%=request.getContextPath()%>/customer/updateMember.jsp?id=<%=id%>">수정</a>
		<a href="<%=request.getContextPath()%>/customer/memberOut.jsp?id=<%=id%>">삭제</a>
		<a href="<%=request.getContextPath()%>/customer/updatePassword.jsp?id=<%=id%>">비밀번호 수정</a>
	<% 			
		}
	%>
			
</body>
</html>