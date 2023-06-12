<%@page import="vo.product.Discount"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.AdminDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String[] splitSearchProduct = null;
	int searchProductNo = 0;
	// searchProduct의 값이 parseInt 못하는 값이면 String으로 값을 받는다 
	if (request.getParameter("searchProduct") != null){
		try{
			searchProductNo = Integer.parseInt(request.getParameter("searchProduct"));
		} catch(NumberFormatException n) {
		String searchProduct = request.getParameter("searchProduct");
		System.out.println(searchProduct + " <-searchProduct");
		// split 함수를 써서 array를 만들면 최소값이 1이다
		splitSearchProduct = searchProduct.split(" ");
		System.out.println(splitSearchProduct[0] + " <-splitSearchProduct[0]");
		System.out.println(splitSearchProduct.length + " <-splitSearchProduct.length");
		}
	}
	
	double searchRate = 0;
	System.out.println(request.getParameter("searchRate") + " <-request.getParameter(\"searchRate\")");
	if (request.getParameter("searchRate") != null
			&& !"".equals(request.getParameter("searchRate"))){
		searchRate = (double)Integer.parseInt(request.getParameter("searchRate")) / 100;
	}
	System.out.println(searchRate + " <-searchRate");
	
	String searchDate = request.getParameter("searchDate");
	String searchBeginDate = null; 
	if (!"".equals(request.getParameter("searchBeginDate"))){
		searchBeginDate = request.getParameter("searchBeginDate");
	}
	//System.out.println(searchBeginDate + " <-searchBeginDate");
	String searchEndDate = null; 
	if (!"".equals(request.getParameter("searchEndDate"))){
		searchEndDate = request.getParameter("searchEndDate");
	}
	// System.out.println(searchProductNo + " <- searchProductNo");
	AdminDao ad = new AdminDao();
	ArrayList<Discount> discountList = new ArrayList<>();
	
	if (searchProductNo != 0){
		System.out.println("check1");
		discountList = ad.selectDiscount(searchProductNo);
	} else if(splitSearchProduct != null
			&& !"".equals(splitSearchProduct[0])){
		System.out.println("check2");
		discountList = ad.selectDiscount(splitSearchProduct);
	} else if(searchBeginDate != null){
		System.out.println("check3");
		discountList = ad.selectDiscount(searchDate, searchBeginDate, searchEndDate);
	} else if(searchRate != 0){
		System.out.println("check4");
		discountList = ad.selectDiscount(searchRate);
	} else {
		System.out.println("check5");
		discountList = ad.selectDiscount();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>할인품목 관리</h1>
	<a href="<%=request.getContextPath()%>/admin/insertDiscount.jsp">
		할인 추가
	</a>
	<h4>할인 검색</h4>
	<form action="<%=request.getContextPath()%>/admin/discountList.jsp" method="get">
		상품명, 번호<input type="text" name="searchProduct">
		할인율 <input type="number" name="searchRate">
		<select name="searchDate">
			<option value="discountWhole">전체</option>
			<option value="discountBegin">할인시작날짜</option>
			<option value="discountEnd">할인종료날짜</option>
		</select>
		<input type="date" name="searchBeginDate">
		<input type="date" name="searchEndDate">
		<button type="submit">검색</button>
	</form>
	<table>
		<tr>
			<th>품목</th>
			<th>품명</th>
			<th>할인시작날짜</th>
			<th>할인종료날짜</th>
			<th>할인율</th>
			<th>작성일</th>
			<th>수정일</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
	<%
		for (Discount d : discountList){
	%>
			<tr>
				<td>
					<%=d.getProductNo()%>
				</td>
				<td>
					<%=d.getProductName()%>
				</td>
				<td>
					<%=d.getDiscountBegin()%>
				</td>
				<td>
					<%=d.getDiscountEnd()%>
				</td>
				<td>
					<%=(int)(d.getDiscountRate() * 100)%>%
				</td>
				<td>
					<%=d.getCreatedate()%>
				</td>
				<td>
					<%=d.getUpdatedate()%>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/admin/updateDiscount.jsp?discountNo=<%=d.getDiscountNo()%>">
						수정
					</a>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/admin/deleteDiscountAction.jsp?discountNo=<%=d.getDiscountNo()%>">
						삭제
					</a>
				</td>
			</tr>
	<%		
			
		}
	%>
	</table>
</body>
</html>