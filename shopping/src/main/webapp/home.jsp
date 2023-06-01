<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.main.*" %>
<%@ page import="vo.product.*" %>
<%
	MainDao md = new MainDao();
	ArrayList<Product> recentlryList = new ArrayList<>();
	ArrayList<Product> popularList = new ArrayList<>();
	recentlryList = md.selectRecentlyProduct();
	popularList = md.selectPopularProduct();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>최신 앨범</h1>
	<table>
		<tr>
		<%
			int cnt = 0;
			for(Product p : recentlryList){
				if(cnt %3 == 0){
		%>
					</tr>
					<tr>
		<%
				}
		%>
				<td>
					<%=p.getProductName()%>
				</td>
		<%
			cnt++;
			}
		%>		
		</tr>
	</table>
	<h1>인기 앨범</h1>
	<table>
		<tr>
		<%
			cnt = 0;
			for(Product p : popularList){
				if(cnt %3 == 0){
		%>
					</tr>
					<tr>
		<%
				}
		%>
				<td>
					<%=p.getProductName()%>
				</td>
		<%
			cnt++;
			}
		%>		
		</tr>
	</table>
</body>
</html>