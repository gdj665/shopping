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
	
	//회원 출력
	ArrayList<Customer> customerList = new ArrayList<>();
	customerList = ad.selectCustomer();
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
                    <h1 class="mt-4">회원관리</h1>
                    <br>
                    <div class="card mb-4">
                        <div class="card-body">
                            회원 관리 데이터베이스 관리 테이블
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            회원관리
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
										<th>아이디</th>
										<th>상태</th>
										<th>회원등급</th>
										<th>포인트</th>
										<th>최종로그인</th>
										<th>정보동의</th>
										<th>상세보기</th>
									</tr>
                                </thead>
                                <tbody>
                                <%
									for(Customer c : customerList){
								%>
									<tr>
										<td>
											<%=c.getId()%>
										</td>
										<td>
											<%=c.getActive()%>
										</td>
										<td>
											<%=c.getCstmRank()%>
										</td>
										<td>
											<%=c.getCstmPoint()%>
										</td>
										<td>
											<%=c.getCstmLastLogin()%>
										</td>
										<td>
											<%=c.getCstmAgree()%>
										</td>
										<td>
											<a class="subBtn" href="<%=request.getContextPath()%>/employees/customerOneControl.jsp?customerId=<%=c.getId()%>">
												상세보기
											</a>
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
