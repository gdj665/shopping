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
	int oqNo = Integer.parseInt(request.getParameter("oqNo"));
	
	//OrderDao 선언
	CsDao csdao = new CsDao();

	// 7) 1대1문의 상세 페이지불러오기
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = csdao.oneCs(oqNo);
	
	// 10) 1대1 문의 답변 불러오기
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<>();
	list2 = csdao.etcAnswerList(oqNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의 상세페이지</title>
</head>
<body>
	<table>
		<%
			for(HashMap<String,Object> m : list){
		%>
				<tr>
					<th><%=(String)m.get("oqTitle") %></th>
				</tr>
				<tr>
					<th><%=(String)m.get("oqContent") %></th>
				</tr>
		<%
			}
		%>
	</table>
	<table>
		<%
			for(HashMap<String,Object> m : list2){
		%>
			<tr>
				<th>관리자</th>
			</tr>
			<tr>
				<th><%=(String)m.get("oaContent") %></th>
			</tr>
			<tr>
				<th><a href="<%=request.getContextPath()%>/cs/deleteEtcCsCommentAction.jsp?oaNo=<%=(int)m.get("oaNo") %>&oqNo=<%=oqNo%>">삭제</a></th>
			</tr>
		<%
			}
		%>
	</table>
	<form action="<%=request.getContextPath() %>/cs/insertEtcCsAnswerAction.jsp">
		<table>
			<tr>
				<td><input type="text" name="oaContent"></td>
				<input type="hidden" name="oqNo" value="<%=oqNo %>">
			</tr>
		</table>
		<button type="submit">전송</button>
	</form>
	<a href="<%=request.getContextPath() %>/cs/updateEtcCsOne.jsp?oqNo=<%=oqNo %>">수정하기</a>
	<a href="<%=request.getContextPath() %>/cs/deleteEtcCsOneAction.jsp?oqNo=<%=oqNo %>">삭제하기</a>
</body>
</html>