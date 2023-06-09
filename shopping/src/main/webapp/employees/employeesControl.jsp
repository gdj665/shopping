<%@page import="vo.id.Employees"%>
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
	EmployeesDao ed = new EmployeesDao();
	
	// 관리자 레벨 출 력
	int empLevel = ed.checkEmployees(id);
	
	// 관리자가 아닐시 홈화면으로
	if(empLevel<2){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
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
										<th>상세보기</th>
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
