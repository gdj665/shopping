<%@page import="vo.id.Customer"%>
<%@page import="java.util.ArrayList"%>
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
	EmployeesDao ad = new EmployeesDao();
	
	// 관리자 레벨 출 력
	int empLevel = ad.checkEmployees(id);
	
	// 관리자가 아닐시 홈화면으로
	if(empLevel<1){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//회원정보출력
	Customer customer = new Customer();
	customer = ad.selectCustomer(id);
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
	<!-- 상단 nav 출력 -->
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
                    <h1 class="mt-4">회원 정보 상세 페이지</h1>
                    <br>
                    <div class="card mb-4">
                        <div class="card-body">
                            회원 상세보기 데이터베이스 관리 테이블
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            회원 상세보기 관리
                        </div>
                        <div class="card-body">
	                        <form action="<%=request.getContextPath()%>/employees/updateCustomerAction.jsp" method="post">
	                            <table class="table">
	                                <tr>
										<th>아이디</th>
										<td>
											<input type="hidden" value="<%=customer.getId()%>" name="cstmId">
											<%=customer.getId()%>
										</td>
									</tr>
									<tr>
										<th>상태</th>
										<td>
											<input type="number" value="<%=customer.getActive()%>" name="cstmActive">
										</td>
									</tr>
									<tr>
										<th>이름</th>
										<td>
											<%=customer.getCstmName()%>
										</td>
									</tr>
									<tr>
										<th>주소</th>
										<td>
											<%=customer.getCstmAddress()%>
										</td>
									</tr>
									<tr>
										<th>E-mail</th>
										<td>
											<%=customer.getCstmEmail()%>
										</td>
									</tr>
									<tr>
										<th>생일</th>
										<td>
											<%=customer.getCstmBirth()%>
										</td>
									</tr>
									<tr>
										<th>휴대폰번호</th>
										<td>
											<%=customer.getCstmPhone()%>
										</td>
									</tr>
									<tr>
										<th>회원등급</th>
										<td>
											<%=customer.getCstmRank()%>
										</td>
									</tr>
									<tr>
										<th>포인트</th>
										<td>
											<%=customer.getCstmPoint()%>
										</td>
									</tr>
									<tr>
										<th>최종로그인</th>
										<td>
											<%=customer.getCstmLastLogin()%>
										</td>
									</tr>
									<tr>
										<th>정보동의</th>
										<td>
											<%=customer.getCstmAgree()%>
										</td>
									</tr>
									<tr>
										<th>가입날짜</th>
										<td>
											<%=customer.getCreatedate()%>
										</td>
									</tr>
									<tr>
										<th>수정날짜</th>
										<td>
											<%=customer.getUpdatedate()%>
										</td>
									</tr>
	                            </table>
                           		<button class="btn btn-outline-secondary" type="submit">수정</button>
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
