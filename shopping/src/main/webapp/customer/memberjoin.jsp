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
<html lang="zxx">

<head>
   
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>


<!-- ------------------------------------------------회원가입 폼----------------------------------------------------------------------------------------------------------------------------- -->                    
    <!-- Register Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="register-form">
                        <h2>Register</h2>
                        <form action="<%=request.getContextPath()%>/customer/memberJoinAction.jsp" method="post">
                            <div class="group-input">
                                <label for="username">사용자 ID</label>
                                <input type="text" id="id" name="id" required="required" >
                            </div>
                            <div class="group-input">
                                <label for="pass">비밀번호</label>
                                <input type="password" id="pw" name="pw" required="required">
                            </div>
                            <div class="group-input">
                                <label for="con-pass">비밀번호 확인</label>
                                <input type="password" id="ckpw" name="ckpw" required="required">
                            </div>
                            <div class="group-input">
                                <label for="username">이름</label>
                                <input type="text" id="name" name="cstmName" required="required">
                            </div>
                            <div class="group-input">
                                <label for="username">주소</label>
                                <input class="form-control" type="text" id="sample6_postcode" placeholder="우편번호"><br>
								<input class="site-btn register-btn" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
								<input class="form-control" name="cstmAddress1" type="text" id="sample6_address" placeholder="주소"><br>
								<input class="form-control" name="cstmAddress2" type="text" id="sample6_detailAddress" placeholder="상세주소">
								<input class="form-contro
								l" type="hidden" id="sample6_extraAddress" placeholder="참고항목"><br>
                            </div>
                            <div class="group-input">
                                <label for="username">E-mail</label>
                                <input style="width: 267px" type="text" id="email" name="cstmEmail1" required="required">@
                                <input style="width: 267px" type="text" id="email2" name="cstmEmail2" readonly="readonly">

								<select id="emailSelection" name="emailSelection">
									<option value="1" selected="selected">==선택하세요==</option>
									<option value="naver.com">네이버</option>
									<option value="gmail.com">구글</option>
									<option value="daum.net">다음</option>
								</select>
                            </div>
                            <div class="group-input">
                                <label for="username">생년월일</label>
                                <input type="date" id="birth" name="cstmBirth" required="required">
                            </div>
                            <div class="group-input">
                                <label for="username">성별</label>
                                <input type="checkbox" style="width:18px;height:18px;" name="cstmGender" value="M"> 남자
								<input type="checkbox" style="width:18px;height:18px;" name="cstmGender" value="F"> 여자
                            </div>
                            <div class="group-input">
                                <label for="username">휴대전화</label>
                                <input type="tel"  name="cstmPhone" required="required">
                            </div>
                            <tr>
								<td>개인정보 수집 동의</td>
								<td>
									<input type="checkbox" name="cstmAgree" value="y" >수신동의
									<input type="checkbox" name="cstmAgree" value="n" >수신하지않음
								</td>
							</tr>
                            <button type="submit" class="site-btn register-btn">회원가입</button>
                        </form>
                        <div class="switch-login">
                            <a href="<%=request.getContextPath()%>/customer/login.jsp" class="or-login">Or Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- ------------------------------------------------회원가입 폼----------------------------------------------------------------------------------------------------------------------------- -->                             
    <!-- Register Form Section End -->
    
    <!-- Partner Logo Section Begin -->
    <div class="partner-logo">
        <div class="container">
            <div class="logo-carousel owl-carousel">
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-1.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-2.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-3.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-4.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-5.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Partner Logo Section End -->


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
		$(function(){	

			$(document).ready(function(){

				$('select[name=emailSelection]').change(function() {

					if($(this).val()=="1"){

						$('#email2').val("");

					} else {

						$('#email2').val($(this).val());

						$("#email2").attr("readonly", true);

					}

				});

			});

		});
    
</script>
		
</body>

</html>