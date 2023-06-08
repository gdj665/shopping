<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	// 로그인 세션 확인
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	String id = (String)(session.getAttribute("loginId"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>회원 정보 수정</h1>
	
	<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
		<table>	
			<tr>
					<td>아이디</td>
					<td>
						<input type="text" id="id" name="id" required="required">
					</td>
				</tr>
			<tr>
				<td>주소</td>
					<td>
						<textarea name ="cstmAddress" cols ="33" rows="5" ></textarea>
					</td>
				</tr>	
				<tr>
					<td>이메일</td>
					<td>
						<input type="email" id="email" name="cstmEmail" required="required">
					</td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td>
						<input type="tel"  name="cstmPhone" required="required">
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
				<td>
					<input type="password" name="pw" >
				</td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>
</body>
</html>