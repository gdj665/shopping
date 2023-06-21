<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mainName = null;
	if (request.getParameter("mainName") != null){
		mainName = request.getParameter("mainName");
	}
	String subName = "전체";
	if (request.getParameter("subName") != null){
		subName = request.getParameter("subName");
	}
	boolean checkLogin = false;
	String loginId = null;
	if (session.getAttribute("loginId") != null){
		checkLogin = true;
		loginId = (String)session.getAttribute("loginId");
	}
	EmployeesDao ed = new EmployeesDao();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>head</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/themify-icons.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/style.css" type="text/css">
</head>
<body>
	<div class="nav-item">
	    <div class="container">
	        <nav class="nav-menu mobile-menu">
	            <ul>
	                <li><a href="<%=request.getContextPath()%>/home.jsp">Home</a></li>
	                <li><a href="<%=request.getContextPath()%>/product/newProduct.jsp">최신 앨범</a></li>
	                <li><a href="<%=request.getContextPath()%>/product/chartProduct.jsp">앨범 차트</a></li>
	                <li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=한국&subName=전체">국가별 앨범</a>
	                    <ul class="dropdown">
	                        <li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=한국&subName=전체">한국</a></li>
	                        <li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=일본&subName=전체">일본</a></li>
	                        <li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=미국&subName=전체">미국</a></li>
	                    </ul>
	                </li>
			<%
					// checkLogin 이 false면 login창 아니면 아이디에 따라 다른 화면
					if(!checkLogin){
			%>
		                <li><a href="<%=request.getContextPath()%>/customer/login.jsp" class="login-panel"><i class="fa fa-user"></i>&nbsp; Login</a></li>
		                <li><a href="<%=request.getContextPath()%>/customer/memberjoin.jsp" class="login-panel"><i class="fa fa-user"></i>&nbsp; 회원가입</a></li>
			<%
					} else {
						// employees 일경우 아닐경우 분기
						if (ed.checkEmployees(loginId) == 0){
			%>
			                <li><a href="<%=request.getContextPath()%>/customer/myPage.jsp"><%=loginId%></a>
			                    <ul class="dropdown">
			                        <li><a href="<%=request.getContextPath()%>/customer/myPage.jsp">마이 페이지</a></li>
			                        <li><a href="<%=request.getContextPath()%>/customer/orderMyPage.jsp">주문내역</a></li>
			                        <li><a href="<%=request.getContextPath()%>/customer/pointMyPage.jsp">포인트조회</a></li>
			                        <li><a href="<%=request.getContextPath()%>/customer/logoutAction.jsp">logout</a></li>
			                    </ul>
			                </li>
			<%
						} else {
			%>
			                <li><a href="<%=request.getContextPath()%>/employees/orderList.jsp"><%=loginId%></a>
			                    <ul class="dropdown">
			                        <li><a href="<%=request.getContextPath()%>/employees/orderList.jsp">주문 내역</a></li>
			                        <li><a href="<%=request.getContextPath()%>/employees/discountList.jsp">할인 관리</a></li>
			                        <li><a href="<%=request.getContextPath()%>/employees/customerControl.jsp">고객 관리</a></li>
			                        <li><a href="<%=request.getContextPath()%>/employees/employeesControl.jsp">직원 관리</a></li>
			                        <li><a href="<%=request.getContextPath()%>/customer/logoutAction.jsp">logout</a></li>
			                    </ul>
			                </li>
			<%
						}
					}
			%>
	            </ul>
	        </nav>
	        <div id="mobile-menu-wrap"></div>
	    </div>
	</div>
	        <%
	        	if (mainName != null){
	        %>
	        		<div class="nav-item">
						<div class="container">
						    <nav class="nav-menu">
						        <ul>
								     <li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=한국&subName=전체">국가</a>
					                    <ul class="dropdown">
					                        <li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=한국&subName=전체">한국</a></li>
					                        <li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=일본&subName=전체">일본</a></li>
					                        <li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=미국&subName=전체">미국</a></li>
					                    </ul>
					                </li>
									<li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=전체">전체</a></li>
									<li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=싱글">싱글</a></li>
									<li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=ep">ep</a></li>
									<li><a href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=정규">정규</a></li>
						        </ul>
						    </nav>
						</div>
					</div>
	        <%
	        	}
	        %>
</body>
</html>