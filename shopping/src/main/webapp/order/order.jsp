<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
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
	

	// 5) 제품구매 총 가격
	OrderDao orderdao = new OrderDao();
	int row2 = orderdao.sumtotalprice(id);
	// 6) 주문자의 포인트 사용량
	int row = orderdao.totalpoint(id);
	// 7) 받을 주소출력
	ArrayList<String> list = new ArrayList<>();
	list = orderdao.addressName(id);
	// 8) 
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=row2 %>
<%=row %>
<%
	for(String a : list){
%>
	<%=a %>
<%	
	}
%>
</body>
</html>