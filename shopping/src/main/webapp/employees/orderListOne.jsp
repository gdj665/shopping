<%@page import="vo.order.OrdersHistory"%>
<%@page import="vo.order.Orders"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.order.*"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//controller
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	//model
	OrderDao od = new OrderDao();
	
	ArrayList<HashMap<String,Object>> list = od.orderHistoryOne(orderNo);
%>
<!DOCTYPE html>
<html>
<head>
</head>
<style>
	.subBtn {
		text-decoration: none;
		color : #000000;
	}
</style>
<body class="sb-nav-fixed">
	<div>
		<jsp:include page="/inc/employeesNav.jsp"></jsp:include>
	</div>
    <div id="layoutSidenav">
    	<!-- 좌측 사이드 바 시작 -->
        <div>
			<jsp:include page="/inc/employeesSideNav.jsp"></jsp:include>
		</div>
        <!-- 좌측 사이바 종료 -->
        
        <!-- 본문 시작 -->
        <div id="layoutSidenav_content">
        	<!-- 내용 시작 -->
            <main>
           		 <form action="<%=request.getContextPath()%>/employees/orderListAction.jsp" method="post" id="update">
	                <div class="container-fluid px-4">
	                    <h1 class="mt-4">주문내역 상세보기</h1>
	                    <br>
	                    <div class="card mb-4">
	                        <div class="card-body">
	                            주문 내역 상세보기 데이터베이스 관리 테이블
	                        </div>
	                    </div>
	                    <div class="card mb-4">
	                        <div class="card-header">
	                            <i class="fas fa-table me-1"></i>
	                            주문내역 상세보기
	                        </div>
	                        <div class="card-body">
	                            <table id="datatablesSimple">
	                                <thead>
	                                    <tr>
											<th>품목</th>
											<th>품명</th>
											<th>제품가격</th>
											<th>수량</th>
										</tr>
	                                </thead>
	                                <tbody>
	                                <%
										for (HashMap<String,Object> m : list){
											
									%>
												<tr>
													<td>
														<%=m.get("productNo")%>
													</td>
													<td>
														<%=(String)m.get("productName") %>
													</td>
													<td>
														<%=m.get("orderCnt") %>
													</td>
													<td>
														<%=m.get("productDiscountPrice") %>
													</td>
												</tr>
									<%
										}
									%>
	                                </tbody>
	                            </table>
	                        </div>
	                    </div>
	                </div>
                </form>
            </main>
            <!-- 내용 종료 -->
            
            <!-- footer 시작 -->
            <div>
				<jsp:include page="/inc/employeesFooter.jsp"></jsp:include>
			</div>
            <!-- footer종료 -->
        </div>
        <!-- 본문 종료 -->
    </div>
</body>
</html>
