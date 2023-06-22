<%@page import="vo.id.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body class="sb-nav-fixed">
	<!-- 좌측 사이드 바 시작 -->
	<div id="layoutSidenav_nav">
	    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
	        <div class="sb-sidenav-menu">
	            <div class="nav">
	                <div class="sb-sidenav-menu-heading">관리페이지</div>
	                <!-- 인적자원 관리 -->
	                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
	                    <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
	                    인적자원 관리
	                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
	                </a>
	                <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                    <nav class="sb-sidenav-menu-nested nav">
	                        <a class="nav-link" href="<%=request.getContextPath()%>/employees/customerControl.jsp">회원 관리</a>
	                        <a class="nav-link" href="<%=request.getContextPath()%>/employees/employeesControl.jsp">관리자 관리</a>
	                    </nav>
	                </div>
	                <!-- 고객 서비스 관리 -->
	                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts2" aria-expanded="false" aria-controls="collapseLayouts">
	                    <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
	                    고객서비스 관리
	                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
	                </a>
	                <div class="collapse" id="collapseLayouts2" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                    <nav class="sb-sidenav-menu-nested nav">
	                        <a class="nav-link" href="<%=request.getContextPath()%>/employees/orderList.jsp">주문 내역 관리</a>
	                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
	                            문의 내역 관리
								<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
							</a>
							<div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
								<nav class="sb-sidenav-menu-nested nav">
									<a class="nav-link" href="<%=request.getContextPath()%>/employees/empProductCsList.jsp">제품문의 내역</a>
									<a class="nav-link" href="<%=request.getContextPath()%>/employees/empCustomerCsList.jsp">1대1 문의 내역</a>
								</nav>
							</div>
	                    </nav>
	                </div>
	                <!-- 제품 서비스 관리 -->
	                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts3" aria-expanded="false" aria-controls="collapseLayouts">
	                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
	                    제품서비스 관리
	                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
	                </a>
	                <div class="collapse" id="collapseLayouts3" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
	                    <nav class="sb-sidenav-menu-nested nav">
	                        <a class="nav-link" href="<%=request.getContextPath()%>/employees/discountList.jsp">제품 할인 관리</a>
	                        <a class="nav-link" href="<%=request.getContextPath()%>/employees/productControlList.jsp">상품 정보 관리</a>
	                    </nav>
	                </div>
	            </div>
	        </div>
	    </nav>
	</div>
	<!-- 좌측 사이바 종료 -->
</body>
</html>
