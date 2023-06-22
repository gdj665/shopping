<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("msg") != null){
		String msg = request.getParameter("msg");
		String redirectUrl = request.getContextPath() + "/employees/insertEmployees.jsp";
		//alert 메세지 출력
		String script = 
				"<script>"+
					"alert('" + msg + "');"+
					"window.location.href='" + redirectUrl + "';" +
				"</script>";
		response.getWriter().println(script);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			$('#btn').click(function(){
				if ($('#employeesPw').val() != $('#checkPw').val()){
					alert('비밀번호가 같지 않습니다.');
				} else {
					$('#form').submit();
				}
			})
		})
	</script>
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
                    <h1 class="mt-4">관리자 추가 페이지</h1>
                    <br>
                    <div class="card mb-4">
                        <div class="card-body">
                            관리자 추가 데이터베이스 관리 테이블
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            관리자 추가 관리
                        </div>
                        <div class="card-body">
	                        <form action="<%=request.getContextPath()%>/employees/insertEmployeesAction.jsp" method="post" id="form">
	                            <table class="table">
	                                <tr>
										<th>아이디</th>
										<td>
											<input class="form-control" type="text" name="employeesId" required="required">
										</td>
									</tr>
									<tr>
										<th>비밀번호</th>
										<td>
											<input class="form-control" type="password" name="employeesPw" id="employeesPw" required="required">
										</td>
									</tr>
									<tr>
										<th>비밀번호 확인</th>
										<td>
											<input class="form-control" type="password" name="checkPw" id="checkPw" required="required">
										</td>
									</tr>
									<tr>
										<th>이름</th>
										<td>
											<input class="form-control" type="text"  name="employeesName" required="required">
										</td>
									</tr>
									<tr>
										<th>레벨</th>
										<td>
											<input class="form-control" type="number" name="employeesLevel" required="required">
										</td>
									</tr>
	                            </table>
                           		<button class="btn btn-outline-secondary" type="button" id="btn">추가</button>
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
