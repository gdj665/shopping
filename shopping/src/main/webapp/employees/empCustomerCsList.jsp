<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="dao.cs.*"%>
<%
	CsDao csdao = new CsDao();
	ArrayList<HashMap<String,Object>> list = csdao.empOneQuestion();
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
                    <h1 class="mt-4">1대1 문의 관리</h1>
                    <br>
                    <div class="card mb-4">
                        <div class="card-body">
                            1대1 문의 미응답 답변 관리 데이터베이스 관리 테이블
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            1대1 문의관리
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple" onclick="handleTableRowClick(event)">
                                <thead>
                                    <tr>
										<th>번호</th>
										<th>아이디</th>
										<th>제목</th>
										<th>질문내용</th>
										<th>작성일</th>
										<th>수정일</th>
										<th>상세보기</th>
									</tr>
									</thead>
									<tbody>
									<%
										for(HashMap<String,Object> m : list){
									%>
										<tr>
											<td><%=m.get("oqNo") %></td>
											<td><%=(String)m.get("id") %></td>
											<td><%=(String)m.get("oqTitle") %></td>
											<td><%=(String)m.get("oqContent") %></td>
											<td><%=(String)m.get("createdate") %></td>
											<td><%=(String)m.get("updatedate") %></td>
											<td><a class="subBtn" href="<%=request.getContextPath()%>/cs/etcCsOne.jsp?oqNo=<%=m.get("oqNo") %>">상세보기</a></td>
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
