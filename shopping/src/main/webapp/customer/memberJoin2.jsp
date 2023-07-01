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
					<td>
					    <input type="text" id="id" name="id" required="required" onkeyup="checkIdDuplication()">
					    <span id="idDuplicationResult"></span>
					  </td>
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
					<input class="form-control" type="text" id="sample6_postcode" placeholder="우편번호"><br>
			<input class="form-control" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			<input class="form-control" name="address1" type="text" id="sample6_address" placeholder="주소"><br>
			<input class="form-control" name="address2" type="text" id="sample6_detailAddress" placeholder="상세주소">
			<input class="form-control" type="hidden" id="sample6_extraAddress" placeholder="참고항목"><br>
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
	<!-- 카카오톡 주소찾기 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<script>
  var delayTimer;
  
  function checkIdDuplication() {
    clearTimeout(delayTimer);
    
    delayTimer = setTimeout(function() {
      var id = document.getElementById("id").value;

      // 서버에 비동기적으로 ID 중복을 확인하기 위한 요청을 수행합니다.
      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
          var response = xhr.responseText;

          // ID 중복 결과 메시지를 업데이트합니다.
          var idDuplicationResult = document.getElementById("idDuplicationResult");
          idDuplicationResult.innerHTML = response;
        }
      };

      xhr.open("GET", "<%=request.getContextPath()%>/customer/checkIdDuplication.jsp?id=" + id, true);
      xhr.send();
    }, 500); // 0.5초 딜레이를 설정하여 사용자의 연속 입력을 기다립니다.
  }
</script>
</body>
</html>