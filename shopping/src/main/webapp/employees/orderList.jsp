<%@page import="vo.order.OrdersHistory"%>
<%@page import="vo.order.Orders"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//controller
	int searchOrderStatus = 0;
	if (request.getParameter("searchOrderStatus") != null){
		searchOrderStatus = Integer.parseInt(request.getParameter("searchOrderStatus"));
	}
	String searchBeginDate = null; 
	if (!"".equals(request.getParameter("searchBeginDate"))){
		searchBeginDate = request.getParameter("searchBeginDate");
	}
	//System.out.println(searchBeginDate + " <-searchBeginDate");
	String searchEndDate = null; 
	if (!"".equals(request.getParameter("searchEndDate"))){
		searchEndDate = request.getParameter("searchEndDate");
	}
	//model
	EmployeesDao ed = new EmployeesDao();
	ArrayList<Orders> ordersList = new ArrayList<>();
	
	if (searchOrderStatus != 0
			&& searchBeginDate != null){
		ordersList = ed.ordersList(searchOrderStatus, searchBeginDate, searchEndDate);
	} else if (searchOrderStatus != 0){
		ordersList = ed.ordersList(searchOrderStatus);
	} else if (searchBeginDate != null){
		ordersList = ed.ordersList(searchBeginDate, searchEndDate);
	} else {
		ordersList = ed.ordersList();
	}
	ArrayList<OrdersHistory> ordersHistoryList = new ArrayList<>();
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
	                    <h1 class="mt-4">주문내역 관리</h1>
	                    <br>
	                    <div class="card mb-4">
	                        <div class="card-body">
	                            주문 내역 관리 데이터베이스 관리 테이블
	                        </div>
	                    </div>
	                    <div class="card mb-4">
	                        <div class="card-header">
	                            <i class="fas fa-table me-1"></i>
	                            주문내역 관리
	                        </div>
	                        <div class="card-body">
	                            <table id="datatablesSimple">
	                                <thead>
	                                    <tr>
											<th>체크박스</th>
											<th>고객ID</th>
											<th>주문번호</th>
											<th>총가격가격</th>
											<th>포인트사용</th>
											<th>주문상태</th>
											<th>주문날짜</th>
											<th>상세보기</th>
										</tr>
	                                </thead>
	                                <tbody>
	                                <%
										for (Orders o : ordersList){
											//System.out.println("checkListPage");
											ordersHistoryList = (ArrayList<OrdersHistory>)o.getOrdersHistoryList();
									%>
										<tr>
											<td>
												<input type="checkbox" name="checkedOrderNo" value="<%=o.getOrderNo()%>">
											</td>
											<td>
												<%=o.getId()%>
											</td>
											<td>
												<%=o.getOrderNo()%>
											</td>
											<td>
												<%=o.getOrderPrice()%>
											</td>
											<td>
												<%=o.getOrderPointUse()%>
											</td>
											<td>
												<%=o.getOrderStatus()%>
											</td>
											<td>
												<%=o.getCreatedate()%>
											</td>
											<td>
												<a class="subBtn" href="<%=request.getContextPath()%>/employees/orderListOne.jsp?orderNo=<%=o.getOrderNo()%>">상세보기</a>
											</td>
										</tr>
									<%
										}
									%>
	                                </tbody>
	                            </table>
	                            <div>
		                            <div>
			                   			<button style="float:right;" class="btn btn-outline-secondary" type="submit" form="update">변경</button>
										<select style="width: 300px; float:right; margin-right: 20px;" class="form-select" name="orderStatus">
											<option value="1">주문완료</option>
											<option value="2">배송중</option>
											<option value="3">배송완료</option>
											<option value="4">주문취소</option>
										</select>
									</div>
									<br><br>
									<div>
										<a style="float:right;" class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/employees/insertEmployees.jsp">
											직원 추가
										</a>
									</div>
								</div>
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
