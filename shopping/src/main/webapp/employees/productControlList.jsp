<%@page import="vo.product.Discount"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@page import="dao.order.*"%>
<%@page import="java.util.*" %>
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
	OrderDao orderdao = new OrderDao();
	
	// 관리자 레벨 출 력
	int empLevel = ed.checkEmployees(id);
	
	// 관리자가 아닐시 홈화면으로
	if(empLevel<1){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = orderdao.productControlList();
	
	
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
                    <h1 class="mt-4">제품 관리</h1>
                    <br>
                    <div class="card mb-4">
                        <div class="card-body">
                            제품 관리 데이터베이스 관리 테이블
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            제품 관리
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                    <tr>
                                    	<th>할인</th>
										<th>품번</th>
										<th>카테고리</th>
										<th>품명</th>
										<th>가격</th>
										<th>상태</th>
										<th>재고량</th>
										<th>가수</th>
										<th>등록일</th>
										<th>수정일</th>
										<th>상세보기</th>
									</tr>
                                </thead>
                                <tbody>
                                <%
									for (HashMap<String,Object> m : list){
										int productNo = (int)m.get("productNo");
										int row = orderdao.discountProductCheck(productNo);
								%>
										<tr>
											<%
												if(row==1){
											%>
												<td><span style="color:red; font-weight:bold;">할인중</span></td>
											<%
												} else if(row==0){
											%>
												<td>&nbsp;</td>
											<%
												}
											%>
											<td>
												<%=(int)m.get("productNo") %>
											</td>
											<td>
												<%=(String)m.get("categoryMainName") %> / <%=(String)m.get("categorySubName") %>
											</td>
											<td>
												<%=(String)m.get("productName") %>
											</td>
											<td>
												<%=(int)m.get("productPrice") %>
											</td>
											<td>
											<%
												if(((int)m.get("productStatus"))==1){
											%>
												<span style="font-weight: bold;">판매중</span>
											<%
												} else if (((int)m.get("productStatus"))==2){
											%>
												<span style="color:red; font-weight: bold;">품절</span>	
											<%
												} else {
											%>
												<span style="color:red; text-decoration:line-through; font-weight: bold;">단종</span>											
											<%
												}
											%>
											</td>
											<td>
												<%=(int)m.get("productStock") %>
											</td>
											<td>
												<%=(String)m.get("productSinger") %>
											</td>
											<td>
												<%=(String)m.get("createdate") %>
											</td>
											<td>
												<%=(String)m.get("updatedate") %>
											</td>
											<td>
												<a class="subBtn" href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=(int)m.get("productNo") %>">
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
