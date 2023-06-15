<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.cs.*" %>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.id.*" %>
<%@ page import = "vo.cs.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	//유효성 검사
	if(session.getAttribute("loginId") == null){
		
		// null값이 있을 경우 로그인 페이지로 이동
		System.out.println("etcCsList ID값 null 있음");
		
		String msg = "로그인이 필요합니다.";
		String redirectUrl = request.getContextPath() + "/customer/login.jsp";
		
		// alert 메세지 출력
		String script = 
				"<script>"+
					"alert('" + msg + "');"+
					"window.location.href='" + redirectUrl + "';"+
				"</script>";
		response.getWriter().println(script);
		return;
	}
	
	// 값 받아오기
	String id = (String)session.getAttribute("loginId");
	
	//OrderDao 선언
	CsDao csdao = new CsDao();
	EmployeesDao employeesdao = new EmployeesDao();
	
	int empLevel = employeesdao.checkEmployees(id);
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	
	if(empLevel==0){
		// 5) 1대1 문의 리스트 불러오기
		list = csdao.oneCsList(id);
	}

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Fashi | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/themify-icons.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/elegant-icons.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/owl.carousel.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/nice-select.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/jquery-ui.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/slicknav.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/style.css" type="text/css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
    <!-- Faq Section Begin -->
    <div class="faq-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                	<h2>1대1 문의목록</h2>
                	<br>
                	<%
                		if(empLevel==0){
                	%>
	                    <table class="table table-hover">
							<thead class="table-dark">
								<tr>
									<th style="width:100px;">번호</th>
									<th style="width:200px;">제목</th>
									<th style="width:500px;">내용</th>
									<th style="width:200px;">등록일</th>
									<th style="width:200px;">최종수정일</th>
									<th style="width:100px;">답변확인</th>
								</tr>	
							</thead>
							<% 
								for(HashMap<String,Object> m : list){
							%>
							<tr onclick="location.href='<%=request.getContextPath()%>/cs/etcCsOne.jsp?oqNo=<%=(int)m.get("oqNo")%>'" style="cursor: pointer;">
								<td><%=(int)m.get("oqNo") %></td>
								<td><%=(String)m.get("oqTitle") %></td>
								<td><%=(String)m.get("oqContent") %></td>
								<td><%=(String)m.get("createdate") %></td>
								<td><%=(String)m.get("updatedate") %></td>
								<td>
									<%
										if(m.get("checked").equals("N")){
									%>
											답변대기중
									<%
										} else {
									%>
											답변완료
									<%
										}
									%>
								</td>
							</tr>
							<%
								}
							%>
						</table>
						<a class="btn btn-outline-dark" style="float:right;" href="#" onclick="openNewWindow()">문의하기</a>
					<%
                		}
					%>
                </div>
            </div>
        </div>
    </div>
    <!-- Faq Section End -->


    <!-- Js Plugins -->
	<script src="<%=request.getContextPath() %>/template/js/jquery-3.3.1.min.js"></script>
	<script src="<%=request.getContextPath() %>/template/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/template/js/jquery-ui.min.js"></script>
	<script src="<%=request.getContextPath() %>/template/js/jquery.countdown.min.js"></script>
	<script src="<%=request.getContextPath() %>/template/js/jquery.nice-select.min.js"></script>
	<script src="<%=request.getContextPath() %>/template/js/jquery.zoom.min.js"></script>
	<script src="<%=request.getContextPath() %>/template/js/jquery.dd.min.js"></script>
	<script src="<%=request.getContextPath() %>/template/js/jquery.slicknav.js"></script>
	<script src="<%=request.getContextPath() %>/template/js/owl.carousel.min.js"></script>
	<script src="<%=request.getContextPath() %>/template/js/main.js"></script>
	<script>
		function openNewWindow() {
			var url = "<%=request.getContextPath() %>/cs/insertEtcCsList.jsp";
			window.open(url, '신규 문의 등록', 'width=500,height=500');
		}
	</script>
</body>

</html>