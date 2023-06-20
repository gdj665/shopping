<%@page import="vo.product.Discount"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	//유효성 검사
	if(session.getAttribute("loginId") == null){
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//값 받기
	String id = (String)session.getAttribute("loginId");
	
	// EmployeesDao 선언
	EmployeesDao ed = new EmployeesDao();
	
	// 관리자 레벨 출 력
	int empLevel = ed.checkEmployees(id);
	
	// 관리자가 아닐시 홈화면으로
	if(empLevel<1){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 유의성 검사
	if(request.getParameter("discountNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// 수정할 discountNo param값 선언
	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	Discount d = new Discount();
	
	// dicountNo을 매개값으로 db 값 가져오기
	d = ed.selectDiscountOne(discountNo);
%>
<!DOCTYPE html>
<html>
<head>
<style>
	.subBtn {
		text-decoration: none;
		color : #000000;
	}
</style>
</head>
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
                <div class="container-fluid px-4">
                    <h1 class="mt-4">할인 제품 수정</h1>
                    <br>
                    <div class="card mb-4">
                        <div class="card-body">
                            할인제품 수정 데이터베이스 관리 테이블
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            할인제품 수정
                        </div>
                        <div class="card-body">
                        	<form action="<%=request.getContextPath()%>/employees/updateDiscountAction.jsp">
								<input type="hidden" name="discountNo" value="<%=discountNo%>">
	                            <table id="datatablesSimple">
	                            	<thead>
		                                <tr>
											<th>품목</th>
											<th>품명</th>
											<th>할인시작날짜</th>
											<th>할인종료날짜</th>
											<th>할인율</th>
											<th>작성일</th>
											<th>수정일</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<input type="hidden" name="productNo" value="<%=d.getProductNo()%>">
												<%=d.getProductNo()%>
											</td>
											<td>
												<%=d.getProductName()%>
											</td>
											<td>
												<input class="form-control" type="date" name="discountBegin" value="<%=d.getDiscountBegin()%>">
											</td>
											<td>
												<input class="form-control" type="date" name="discountEnd" value="<%=d.getDiscountEnd()%>">
												
											</td>
											<td>
												<input class="form-control"type="number" name="discountRate" value="<%=(int)(d.getDiscountRate() * 100)%>">
											</td>
											<td>
												<%=d.getCreatedate()%>
											</td>
											<td>
												<%=d.getUpdatedate()%>
											</td>
										</tr>
									</tbody>
	       		                </table>
	       		                <button style="float:right;" class="btn btn-outline-secondary" type="submit">수정</button>
	       		             </form>
                        </div>
                    </div>
                </div>
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
