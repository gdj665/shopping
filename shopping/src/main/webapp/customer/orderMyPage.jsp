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

	//세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginId"));
	
	//보여줄페이지 첫번째 행 선언
	int currentPage = 1; 
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//페이지당 보여줄 행
	int rowPerPage = 10;

	int beginRow = (currentPage -1) * rowPerPage;
		
	//세션아이디 디버깅
	System.out.println(id+"<--orderMyPage id");	
	
	OrderListDao orderDao = new OrderListDao();
	ArrayList<HashMap<String, Object>> list = orderDao.orderList(id, beginRow, rowPerPage);
	
	
	int totalRow = orderDao.orderCnt();
	System.out.println(totalRow+"<-- orderMyPage totalRow");
	
	// 마지막 페이지 구하는 변수
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
	System.out.println(startPage+"<-- orderMyPage startPage");
	System.out.println(endPage+"<-- orderMyPage endPage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>구매내역</h1>
	<h1>
		 <%
        	if(request.getParameter("msg") != null){
         %>
        		<%=request.getParameter("msg") %>
         <% 
        	}
      	 %>		
	</h1>
	<%
		for(HashMap<String, Object> s : list){
	%>
		<table>
			<tr>
				<td>주문번호</td>
				<td>상품이름</td>
				<td>결제상태</td>
				<td>배송상태</td>
				<td>수량</td>
				<td>주문가격</td>
				<td>주문배송지</td>
				<td>구매일</td>
			</tr>
			<tr>
				<td><%=(Integer)(s.get("orderNo"))%></td>
				<td><%=(String)(s.get("productName"))%></td>
				<td><%=(String)(s.get("orderStatus"))%></td>
				<td><%=(Integer)(s.get("orderCnt"))%></td>
				<td><%=(Integer)(s.get("orderPrice"))%></td>
				<td><%=(String)(s.get("createdate"))%></td>
				
			</tr>
		</table>
	
	<div>
		<%
			}
			if(startPage > 5){
		%>
			<a href="<%=request.getContextPath()%>/customer/ordierMyPage.jsp?currentPage=<%=startPage-1%>">이전</a>
		<%
			}
			for(int i = startPage; i<=endPage; i++){
		%>
			<a href="<%=request.getContextPath()%>/customer/ordierMyPage.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
			}
			if(endPage<lastPage){
		%>
			<a href="<%=request.getContextPath()%>/customer/ordierMyPage.jsp?currentPage=<%=endPage+1%>">다음</a>
		<%
			
			}
		%>
	</div>
</body>
</html>