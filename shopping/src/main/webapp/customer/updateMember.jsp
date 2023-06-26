<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	// 로그인 세션 확인
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	String id = (String)(session.getAttribute("loginId"));
	
	MemberDao mamDao = new MemberDao();
	HashMap<String, Object> m = new HashMap<>();
	m = mamDao.selectCstmList(id);
	String address = (String)(m.get("cstmAddress"));
	String splitAddress[] = address.split(",");
	String address1 = splitAddress[0];
	String address2 = splitAddress[1];

	String Email = (String)(m.get("cstmEmail"));
	String splitEmail[] = Email.split("@");
	String email1 = splitEmail[0];
	String email2 = splitEmail[1];
	
	System.out.println(m + "<-- myPage list");
%>
<!DOCTYPE html>
<html lang="zxx">
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

<!-- ------------------------------------------회원정보 수정------------------------------------------------- -->
    <!-- Register Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="register-form">
                        <h2>Register</h2>
                        <form action="<%=request.getContextPath()%>/customer/updateMemberAction.jsp" method="post">
                            <div class="group-input">
                                <label for="username">아이디*</label>
                                <input type="text" id="id" name="id" readonly="readonly" value="<%=id%>">
                            </div>
                            <div class="group-input">
                                <label for="pass">이름*</label>
                                <input type="text" id="name" name="cstmName" required="required" value="<%=(String)(m.get("cstmName"))%>">
                            </div>
                            <div class="group-input">
                                <label for="con-pass">주소*</label>
                                <input class="form-control" type="hidden" id="sample6_postcode" placeholder="우편번호"><br>
								<input class="site-btn register-btn" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
								<input class="form-control" name="cstmAddress1" type="text" id="sample6_address" placeholder="주소" value="<%=address1%>" readonly="readonly"><br>
								<input class="form-control" name="cstmAddress2" type="text" id="sample6_detailAddress" placeholder="상세주소" value="<%=address2%>">
								<input class="form-control" type="hidden" id="sample6_extraAddress" placeholder="참고항목"><br>
                            </div>
                            <div class="group-input">
                                <label for="pass">이메일*</label>
                                <input style="width: 267px" type="email" id="email1" name="cstmEmail1" required="required" value="<%=email1%>">
                                <input style="width: 267px" type="email" id="email2" name="cstmEmail2" readonly="readonly" required="required" value="<%=email2%>">
                                <select id="emailSelection" name="emailSelection">
									<option value="1" selected="selected">==선택하세요==</option>
									<option value="naver.com">네이버</option>
									<option value="gmail.com">구글</option>
									<option value="daum.net">다음</option>
								</select>
                            </div>
                            <div class="group-input">
                                <label for="pass">전화번호*</label>
                                <input type="tel"  name="cstmPhone" required="required" value="<%=(String)(m.get("cstmPhone"))%>">
                            </div>
                            <div class="group-input">
                                <label for="pass">비밀번호 확인*</label>
                                <input type="password" name="pw" >
                            </div>
                            <button type="submit" class="site-btn register-btn">회원정보수정</button>
                        </form>
                        <div class="switch-login">
                            <a href="<%=request.getContextPath()%>/customer/myPage.jsp" class="or-login">돌아가기</a>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Register Form Section End -->
<!-- ------------------------------------------회원정보 수정------------------------------------------------- -->
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