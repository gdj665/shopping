<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	//변수에 아이디 저장
	String id = (String)(session.getAttribute("loginId"));

	System.out.println(id+"<-- myPage id");	
	
	MemberDao mamDao = new MemberDao();
	HashMap<String, Object> m = new HashMap<>();
	m = mamDao.selectCstmList(id);
	
	String address = (String)(m.get("cstmAddress"));
	String Address = address.replace(",", " ");
	System.out.println(Address + "test");
	
	System.out.println(m + "<-- myPage list");
	
	PointDao pointDao = new PointDao();
	
	PointDao totalPoint = new PointDao();
	
	int row = pointDao.totalpoint(id);
	System.out.println(row);
	
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


    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text">
                        <a href="#"><i class="fa fa-home"></i> Home</a>
                        <span>Register</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Form Section Begin -->
<!-- -------------------------------------------------------------마이페이지--------------------------------------------------------------- -->
    <!-- Register Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="register-form">
                        <h2>마이페이지</h2>
                        <%
							if(id != null){
						%>
                          <div class="specification-table">
                                        <table>
                                            <tr>
                                                <td class="p-catagory">아이디</td>
                                                <td>
                                                    <div class="cart-add"><%=(String)(m.get("cstmId"))%></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">이름</td>
                                                <td>
                                                    <div class="cart-add"><%=(String)(m.get("cstmName"))%></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">주소</td>
                                                <td>
                                                    <div class="p-stock"><%=Address%></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">이메일</td>
                                                <td>
                                                    <div class="p-weight"><%=(String)(m.get("cstmEmail"))%></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">생일</td>
                                                <td>
                                                    <div class="p-size"><%=(String)(m.get("cstmBirth"))%></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">전화번호</td>
                                                <td><%=(String)(m.get("cstmPhone"))%></td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">등급</td>
                                                <td>
                                                    <div class="p-code"><%=(String)(m.get("cstmRank"))%></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">포인트</td>
                                                <td>
                                                    <div class="p-code"><%=row%></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="p-catagory">가입일</td>
                                                <td>
                                                    <div class="p-code"><%=(String)(m.get("createdate"))%></div>
                                                </td>
                                            </tr>
                                        </table>
				                            <a style="float:right; margin-left:10px;" class="btn btn-outline-danger" href="<%=request.getContextPath()%>/customer/memberOut.jsp?id=<%=id%>" class="or-login">회원탈퇴</a>
                                            <a style="float:right;" class="btn btn-outline-danger" href="<%=request.getContextPath()%>/customer/updateMember.jsp?id=<%=id%>">회원정보수정</a>
                                    </div>
                        <div class="switch-login">
                        </div>
                        <% 			
							}
						%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<!-- -------------------------------------------------------------마이페이지--------------------------------------------------------------- -->
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
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/jquery.countdown.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/jquery.dd.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>
</body>

</html>