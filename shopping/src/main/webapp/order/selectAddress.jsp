<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "vo.id.*" %>
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
	OrderDao orderdao = new OrderDao();
	
	
	// 7) 받을 주소출력
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = orderdao.addressName(id);

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주소목록</h1>
	<form action="">
	<%
		for(HashMap<String,Object> m : list){
	%>
	        <input type="radio" style="width:15px;height:15px;border:1px;" name="addressNo" value="<%=(int) m.get("addressNo")%>" required="required">
	        <%=(String) m.get("address")%><br>
  	<%	
		}
	%>
	</form>
</body>
</html>