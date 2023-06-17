<%@page import="vo.id.Employees"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// employees 유의성 검사
	
	
	EmployeesDao ed = new EmployeesDao();
	ArrayList<Employees> employeesList = new ArrayList<>();
	employeesList = ed.selectEmployees();
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
                <div class="container-fluid px-4">
                    <h1 class="mt-4">관리자 직원 관리</h1>
                    <br>
                    <div class="card mb-4">
                        <div class="card-body">
                            관리자 직원 관리 데이터베이스 관리 테이블
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            관리자 정보 관리
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
										<th>아이디</th>
										<th>이름</th>
										<th>레벨</th>
										<th></th>
									</tr>
                                </thead>
                                <tbody>
                                <%
									for(Employees e : employeesList){
								%>
											<tr>
												<td>
													<%=e.getId()%>
												</td>
												<td>
													<%=e.getEmpName()%>
												</td>
												<td>
													<%=e.getEmpLevel()%>
												</td>
												<td>
													<a class="subBtn" href="<%=request.getContextPath()%>/employees/employeesOneControl.jsp?employeesId=<%=e.getId()%>">
														상세보기
													</a>
												</td>
											</tr>
								<%
									}
								%>
                                </tbody>
                            </table>
							<a style="float:right;" class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/employees/insertEmployees.jsp">
								직원 추가
							</a>
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
