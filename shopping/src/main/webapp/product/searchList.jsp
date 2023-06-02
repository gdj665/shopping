<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.product.*" %>
<%@ page import = "dao.main.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	// controller
	if (request.getParameter("searchWord") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	// 검색어 값 받아오기
	String searchWord = request.getParameter("searchWord");
	System.out.println(searchWord);
	String splitSearchWord[] = searchWord.split(" ");
	System.out.println(splitSearchWord[0]);
	// like 에 값을 넣을 것이고 하나라도 맞아 떨어지면 검색되게 하기위해 앞뒤로 %를 붙임
	// dao 선언
	SearchDao sd = new SearchDao();
	
	// 검색된 가수 받아오는 리스트
	ArrayList<Product> searchSingerList = new ArrayList<>(); 
	searchSingerList = sd.searchSinger(splitSearchWord);

	// 검색된 트랙 받아오는 리스트 with 가수명
	ArrayList<Product> searchTrackWithSingerList = new ArrayList<>(); 
	searchTrackWithSingerList = sd.searchTrackWithSinger(splitSearchWord);
	
	// 검색된 트랙 받아오는 리스트 with 트랙명
	ArrayList<Product> searchTrackNameList = new ArrayList<>(); 
	searchTrackNameList = sd.searchTrackName(splitSearchWord);
	
	// 검색된 트랙 받아오는 리스트 with 앨범명
	ArrayList<Product> searchTrackWithProductNameList = new ArrayList<>(); 
	searchTrackWithProductNameList = sd.searchTrackWithProductName(splitSearchWord);

	// 검색된 앨범 받아오는 리스트
	ArrayList<Product> searchProductName = new ArrayList<>(); 
	searchProductName = sd.searchProductName(splitSearchWord);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>'<%=searchWord%>'에 대한 검색 결과 입니다.</h3>
	<h2>가수(<%=searchSingerList.size()%>)</h2>
	<table>
		<tr>
	<%
			for(Product p : searchSingerList){
	%>
				<td>
					<%=p.getProductSinger()%>
				</td>
	<%
			}
	%>
		</tr>
	</table>
	<h2>곡(<%=searchTrackWithSingerList.size() + searchTrackNameList.size() + searchTrackWithProductNameList.size()%>)</h2>
	<h4>가수명으로 검색(<%=searchTrackWithSingerList.size()%>)</h4>
	<table>
	<%
		for(Product p : searchTrackWithSingerList){
	%>
			<tr>
				<td>
					<%=p.getTrackName()%>
				</td>
				<td>
					<%=p.getProductSinger()%>
				</td>
				<td>
					<%=p.getProductName()%>
				</td>
			</tr>
	<%
			}
	%>
	</table>
	<h4>곡명으로 검색(<%=searchTrackNameList.size()%>)</h4>
	<table>
	<%
		for(Product p : searchTrackNameList){
	%>
			<tr>
				<td>
					<%=p.getTrackName()%>
				</td>
				<td>
					<%=p.getProductSinger()%>
				</td>
				<td>
					<%=p.getProductName()%>
				</td>
			</tr>
	<%
			}
	%>
	</table>
	<h4>앨범명으로 검색(<%=searchTrackWithProductNameList.size()%>)</h4>
	<table>
	<%
		for(Product p : searchTrackWithProductNameList){
	%>
			<tr>
				<td>
					<%=p.getTrackName()%>
				</td>
				<td>
					<%=p.getProductSinger()%>
				</td>
				<td>
					<%=p.getProductName()%>
				</td>
			</tr>
	<%
			}
	%>
	</table>
	<h2>앨범(<%=searchProductName.size()%>)</h2>
	<table>
	<%
		for(Product p : searchProductName){
	%>
			<tr>
				<td>
					<%=p.getProductName()%>
				</td>
				<td>
					<%=p.getProductSinger()%>
				</td>
			</tr>
	<%
			}
	%>
	</table>
</body>
</html>