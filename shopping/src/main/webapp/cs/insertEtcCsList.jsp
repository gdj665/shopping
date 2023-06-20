<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의글 작성페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<form id="insertEtcCsList" action="<%=request.getContextPath() %>/cs/insertEtcCsListAction.jsp" method="post">
		<br>
		<h3 style="margin-left:10px;">신규 문의 등록</h3>
		<br>
		<table class="table">
			<tr>
				<th>제목</th>
			</tr>
			<tr>
				<td>
					<input class="form-control" type="text" name="oqTitle">
				</td>
			</tr>
			<tr>
				<th>내용</th>
			</tr>
			<tr>
				<td>
					<textarea rows="5" class="form-control" name="oqContent"></textarea>
				</td>
			</tr>
		</table>
		<div class="d-grid">
			<button style="margin:10px;" class="btn btn-outline-secondary btn-block" type="submit" onclick="submitForm()">등록</button>
		</div>
	</form>
<script>
	function submitForm() {
		// Form 데이터를 가져와서 새 창에 전송
		var form = document.getElementById('insertEtcCsList');
		form.target = 'newWindow'; // 새 창의 이름
		form.submit();
		
		// 원래 창으로 돌아가고 새로고침
		window.opener.location.reload();
		window.close();
		
	}
</script>
</body>
</html>