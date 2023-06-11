<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.cs.*" %>
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
	if(request.getParameterValues("oqNo")==null){
		
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값 받아오기
	String id = "admin";
	int oqNo = Integer.parseInt(request.getParameter("oqNo"));
	
	//OrderDao 선언
	CsDao csdao = new CsDao();

	// 7) 1대1문의 상세 페이지불러오기
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = csdao.oneCs(oqNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의 수정페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<form id="updateEtcCsOne" action="<%=request.getContextPath() %>/cs/updateEtcCsOneAction.jsp">
		<br>
		<h3 style="margin-left:10px;">문의 내역 수정</h3>
		<br>
		<table class="table">
			<%
				for(HashMap<String,Object> m : list){
			%>
					<tr>
						<th>제목</th>
						<td>
							<input class="form-control" type ="text" name="oqTitle" value="<%=(String)m.get("oqTitle") %>">
							<input type="hidden" name="oqNo" value="<%=oqNo %>">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="5" class="form-control" name="oqContent"><%=(String)m.get("oqContent") %></textarea></td>
					</tr>
			<%
				}
			%>
		</table>
		<div class="d-grid">
			<button style="margin:10px;" class="btn btn-outline-secondary btn-block" type="submit" onclick="submitForm()">수정하기</button>
		</div>
	</form>
<script>
	function submitForm() {
		// Form 데이터를 가져와서 새 창에 전송
		var form = document.getElementById('updateEtcCsOne');
		form.target = 'newWindow'; // 새 창의 이름
		form.submit();
		
		// 원래 창으로 돌아가고 새로고침
		window.opener.location.reload();
		window.close();
	}
</script>	
</body>
</html>