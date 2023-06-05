<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 로그인 세션 확인
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	// 세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginId"));

	// 첫번쨰 페이지
	int currentPage = 1; 
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 페이지당 보여줄 행
	int rowPerPage = 10;
	
	int beginRow = (currentPage -1) * rowPerPage;	
	System.out.println(id+"<-- id");	
	
	
	MemberDao memDao = new MemberDao();
	ArrayList<HashMap<String, Object>> list = memDao.cstmPointList(beginRow, rowPerPage, id);
	
	// 총 행의 수를 얻기위한 메소드 사용
	MemberDao totalPoint = new MemberDao();
	int totalRow = totalPoint.pointRow();
	System.out.println(totalRow+"<-- totalRow");
	
	// 마지막 페이지 구하기
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage++;
	}
	int pageCount = 10;// 페이지당 출력될 페이지수

	int startPage = ((currentPage -1)/pageCount)*pageCount+1;
	
	int endPage = startPage+9;
	if(endPage > lastPage){
	endPage = lastPage;
	}
	System.out.println(startPage+"<-- startPage");
	System.out.println(endPage+"<-- endPage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>포인트 내역 목록</h1>
	<%
		for(HashMap<String, Object> s : list){
	%>
		<table>
			<tr>
				<td>주문번호</td>
				<td>포인트</td>
				<td>적립일자</td>
			</tr>
			<tr>
				<td><%=(Integer)(s.get("orderNo"))%></td>
				<td><%=(Integer)(s.get("point"))%></td>
				<td><%=(String)(s.get("createdate"))%></td>
			</tr>
		</table>
	<%
		}
	%>
	<div>
		<%
			if(startPage > 5){
		%>
			<a href="<%=request.getContextPath()%>/member/pointList.jsp?currentPage=<%=startPage-1%>">이전</a>
		<%
			}
			for(int i = startPage; i<=endPage; i++){
		%>
			<a href="<%=request.getContextPath()%>/member/pointList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
			}
			if(endPage<lastPage){
		%>
			<a href="<%=request.getContextPath()%>/member/pointList.jsp?currentPage=<%=endPage+1%>">다음</a>
		<%
			}
		%>
	</div>
</body>
</html>