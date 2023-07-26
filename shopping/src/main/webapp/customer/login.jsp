<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//새션 확인 로그인 되어있다면 못들어와야됩니다.
	/* if(session.getAttribute("loginId") != null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	} */
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

    
    <!-- Register Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="login-form">
<!-- ------------------------------------로그인폼------------------------------------------------------------------------------------------------------------------------------- -->
                        <h2>Login</h2>
                        <h4>
                        	Admin test : admin, 1234 <br>
                        	Customer test : test, 1234
                        </h4>
                        <div>&nbsp;</div>
                         <%
        					if(request.getParameter("msg") != null){
        				 %>
		        			<%=request.getParameter("msg") %>
		       			 <% 
        					}
      					 %>		
                        <form action="<%=request.getContextPath()%>/customer/loginAction.jsp" method="get">
                            <div class="group-input">
                                <label for="username">아이디 *</label>
                                <input type="text" name="id">
                            </div>
                            <div class="group-input">
                                <label for="pass">비밀번호 *</label>
                                <input type="password" name="lastPw">
                            </div>
                            
                            <button type="submit" class="site-btn login-btn">로그인</button>
                        </form>
 <!-- ------------------------------------로그인폼------------------------------------------------------------------------------------------------------------------------------- -->
                    </div>
                </div>
            </div>
        </div>
    </div>
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
</body>

</html>