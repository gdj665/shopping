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
	
	// 메세지 출력 설정
	String msg = null;
	
	// 값 받아오기
	String id = "admin";
	int oqNo = Integer.parseInt(request.getParameter("oqNo"));
	
	//OrderDao 선언
	CsDao csdao = new CsDao();

	// 7) 1대1문의 상세 페이지불러오기
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = csdao.oneCs(oqNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의 수정페이지</title>
</head>
<body>
	<form action="<%=request.getContextPath() %>/cs/updateEtcCsOneAction.jsp">
		<table>
			<%
				for(HashMap<String,Object> m : list){
			%>
					<tr>
						<th>제목</th>
						<td><input type ="text" name="oqTitle" value="<%=(String)m.get("oqTitle") %>"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><input type="text" name="oqContent" value="<%=(String)m.get("oqContent") %>"></td>
					</tr>
					<input type="hidden" name="oqNo" value="<%=oqNo %>">
			<%
				}
			%>
		</table>
		<button type="submit">수정하기</button>
	</form>
</body>
</html>