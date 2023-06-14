<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%
	
	request.setCharacterEncoding("utf-8");
	
	if(request.getParameter("loginId") != null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberJoin</title>
<script>

</script>
</head>
<body>
	<h1> 회원가입 </h1>
	<form action="<%=request.getContextPath()%>/customer/memberJoinAction.jsp" method="post">
		<fieldset>
			<legend>01 로그인 정보</legend>
			<table border="1">
				<tr>
					<td>사용자 ID</td>
					<td><input type="text" id="id" name="id" required="required"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" id="pw" name="pw" required="required"></td>
				</tr>
				<tr>
					<td>비밀번호확인</td>
					<td><input type="password" id="ckpw" name="ckpw" required="required"></td>
				</tr>
			</table>
		</fieldset>
		<fieldset>
			<legend>02 개인 정보</legend>
			<table border="1">
				<tr>
					<td>이름</td>
					<td><input type="text" id="name" name="cstmName" required="required"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
					<input class="form-control" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<input class="form-control" name="address2" type="text" id="sample6_detailAddress" placeholder="상세주소">
					</td>
				</tr>
				<tr>
					<td>E-mail 주소</td>
					<td><input type="email" id="email" name="cstmEmail" required="required"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td>
						<input type="date" id="birth" name="cstmBirth" required="required">
						<input type="radio" class="lunarSolar" name="lunarSolar">양력
						<input type="radio" class="lunarSolar" name="lunarSolar">음력
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" name="cstmGender" value="M"> 남자
					
						<input type="radio" name="cstmGender" value="F"> 여자
					</td>
				</tr>
				<tr>
					<td>휴대전화</td>
					<td>
						<input type="tel"  name="cstmPhone" required="required">
					</td>
				</tr>
				
			</table>
		</fieldset>
		<fieldset>
			<legend>03 기타정보</legend>
			<table border="1">
				<tr>
					<td>마케팅 메일 수신</td>
					<td>
						<input type="radio" name="cstmAgree" value="y" >수신동의
						<input type="radio" name="cstmAgree" value="n" >수신하지않음
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div>개인정보의 수집 및 이용에 대한 동의 (필수)</div>
						<div>
							<p>
							1. 수집하는 개인정보 항목
							본인은 『개인정보보호법』제15조 및 제17조, 제30조에 따라 개인정보의 수집, 개인정보의 제공, 이용목적과 수집하려는 개인정보 항목, 개인정보 보유기간에 대해 동의합니다.
							</p>
							<p>
							가. 필수정보: 아이디, 이름, 성별, 출생년도, 비밀번호, 이메일
							나. 서비스 이용 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
							(접속로그, 접속IP정보, 쿠키, 방문 일시, 서비스 이용기록, 불량 이용 기록)
							</p>
							<p>							
							2. 이용자 회원가입 시 직접 개인정보를 입력 및 수정하여 개인정보를 수집합니다.
							</p>
							<p>							
							3. 수집 개인정보의 이용목적
							회원가입, 회원활동 실적 관리, 회원탈퇴 의사 확인 등 회원관리
							제공되는 서비스 이용에 관한 인구통계학적 분석, 서비스 방문 및 이용기록 분석, 관심사에 기반한 맞춤형 서비스 등 제공
							신규 서비스 개발 및 활성화, 홍보 및 이벤트, 전자우편 서비스 등 정보 전달
							향후 법정 대리인 본인확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달 등
							</p>
							<p>							
							4. 개인정보의 보유 및 이용기간
							이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다.
							따라서 최종 로그인 후 2년이 경과하였거나 정보주체의 회원 탈퇴 신청 시 회원의개인정보를 지체 없이 파기합니다.
							</p>
							<p>							
							동의 거부 권리 사실 및 불이익 내용
							이용자는 동의를 거부할 권리가 있습니다. 동의를 거부할 경우에는 서비스 이용에제한됨을 알려드립니다.
							</p>
						</div>
						<div><input type="checkbox" class="ck" name="ck">동의합니다</div>
					</td>
				</tr>
			</table>
		</fieldset>
		<div>
			<button type="submit">회원가입</button>
		</div>
	</form>
	<br>

</body>
</html>