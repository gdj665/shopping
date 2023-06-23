<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//새션 확인 로그인 안되어있다면 못들어와야됩니다.
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}
	String id = (String)(session.getAttribute("loginId"));
%>

<!DOCTYPE html>
<html lang="zxx">

<head>
   
</head>

<body>
    <div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
    <!-- Page Preloder -->
    <div id="preloder">
    
        <div class="loader"></div>
    </div>

    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text">
                        <a href="#"><i class="fa fa-home"></i> Home</a>
                        <span>Login</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Form Section Begin -->
<!-- ------------------------------------로그인폼------------------------------------------------------------------------------------------------------------------------------- -->
    <!-- Register Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="login-form">
                        <h2>Login</h2>
                        <form action="<%=request.getContextPath()%>/customer/updatePasswordAction.jsp" method="post">
                            <div class="group-input">
                                <input type="hidden" name="id" value="<%=id%>"><!-- 세션값아이디 히든으로 넘기기 -->
                            </div>
                            <div class="group-input">
                                <label for="username">기존 비밀번호</label>
                                <input type="password" name="onePw" placeholder="비밀번호">
                            </div>
                            <div class="group-input">
                                <label for="pass">변경할 비밀번호</label>
                                <input type="password" name="pw" placeholder="비밀번호">
                            </div>
                            <div class="group-input">
                                <label for="pass">변경할 비밀번호 확인</label>
                                <input type="password" name="checkPw" placeholder="비밀번호 재확인">
                            </div>
                            <button type="submit" class="site-btn login-btn">변경</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Register Form Section End -->
<!-- ------------------------------------로그인폼------------------------------------------------------------------------------------------------------------------------------- -->
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