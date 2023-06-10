<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.cs.*" %>
<%@ page import = "vo.id.*" %>
<%@ page import = "vo.cs.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// 값 받아오기
	String id = "admin";
	
	//OrderDao 선언
	CsDao csdao = new CsDao();

	// 5) 제품당 문의 리스트 불러오기
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = csdao.oneCsList(id);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의페이지</title>
</head>
<body>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>등록일</th>
			<th>최종수정일</th>
		</tr>
		<% 
			for(HashMap<String,Object> m : list){
		%>
		<tr>
			<td><a href="<%=request.getContextPath()%>/cs/etcCsOne.jsp?oqNo=<%=(int)m.get("oqNo")%>"><%=(int)m.get("oqNo") %></a></td>
			<td><%=(String)m.get("oqTitle") %></td>
			<td><%=(String)m.get("createdate") %></td>
			<td><%=(String)m.get("updatedate") %></td>
		</tr>
		<%
			}
		%>
	</table>
	<a href="<%=request.getContextPath() %>/cs/insertEtcCsList.jsp">추가하기</a>
</body>
</html>