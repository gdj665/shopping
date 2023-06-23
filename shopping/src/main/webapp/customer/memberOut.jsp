<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}

	String id = (String)(session.getAttribute("loginId"));
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

<!-- ------------------------------------------------------회원탈퇴---------------------------------------------------------------------- -->
    <!-- Register Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="register-form">
                        <h2>Register</h2>
                        <form action="<%=request.getContextPath()%>/customer/memberOutAction.jsp" method="post">
                            <div class="group-input">
                                <label for="username">아이디 *</label>
                                <input type="text" id="id" name="id" readonly="readonly" value="<%=id%>">
                            </div>
                            <div class="group-input">
                                <label for="pass">비밀번호*</label>
                                <input type="password" id="lastPw" name="lastPw" >
                            </div>
                            <button type="submit" class="site-btn register-btn">회원탈퇴</button>
                        </form>
                        <div class="switch-login">
                            <a href="<%=request.getContextPath()%>/home.jsp" class="or-login">돌아가기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Register Form Section End -->
<!-- ------------------------------------------------------회원탈퇴---------------------------------------------------------------------- -->
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
</body>

</html>