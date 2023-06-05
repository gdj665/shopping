<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// subName을 위한 mainName pram받기
	String mainName = "한국";
	if (request.getParameter("mainName") != null){
		mainName = request.getParameter("mainName");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 카테고리 기능구현 나중에 css로 드롭박스 형태 -->
	<h4>앨범 카테고리</h4>
	<table>
		<tr>
			<th>
				<a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=한국&subName=전체">
					한국
				</a>
			</th>
			<th>
				<a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=미국&subName=전체">
					미국
				</a>
			</th>
			<th>
				<a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=일본&subName=전체">
					일본
				</a>
			</th>
		</tr>
		<tr>
			<th>
				<a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=전체">
					전체
				</a> 
			</th>
			<th>
				<a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=싱글">
					싱글
				</a>
			</th>
			<th>
				<a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=정규">
					정규
				</a>
			</th>
		</tr>
	</table>
</body>
</html>