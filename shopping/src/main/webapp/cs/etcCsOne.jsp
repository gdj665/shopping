<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.cs.*" %>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.id.*" %>
<%@ page import = "vo.cs.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	/*
	//유효성 검사
	if(request.getParameterValues("oqNo")==null
		|| session.getAttribute("loginId")==null){
		
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	*/
	// 값 받아오기
	//int oqNo = Integer.parseInt(request.getParameter("oqNo"));
	int oqNo = 14;
	String id = (String)session.getAttribute("loginId");
	
	
	
	//OrderDao 선언
	CsDao csdao = new CsDao();
	EmployeesDao employeesdao = new EmployeesDao();
	
	int empLevel = employeesdao.checkEmployees(id);

	// 7) 1대1문의 상세 페이지불러오기
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = csdao.oneCs(oqNo);
	
	// 10) 1대1 문의 답변 불러오기
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<>();
	list2 = csdao.etcAnswerList(oqNo);
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Fashi | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/themify-icons.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/elegant-icons.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/owl.carousel.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/nice-select.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/jquery-ui.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/slicknav.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/style.css" type="text/css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
    <header class="header-section">
        <div class="header-top">
            <div class="container">
                <div class="ht-left">
                    <div class="mail-service">
                        <i class=" fa fa-envelope"></i>
                        hello.colorlib@gmail.com
                    </div>
                    <div class="phone-service">
                        <i class=" fa fa-phone"></i>
                        +65 11.188.888
                    </div>
                </div>
                <div class="ht-right">
                    <a href="#" class="login-panel"><i class="fa fa-user"></i>Login</a>
                    <div class="lan-selector">
                        <select class="language_drop" name="countries" id="countries" style="width:300px;">
                            <option value='yt' data-image="img/flag.jpg" data-imagecss="flag yt"
                                data-title="English">English</option>
                            <option value='yu' data-image="img/flag.jpg" data-imagecss="flag yu"
                                data-title="Bangladesh">Bangla</option>
                            <option value='yt' data-image="img/flag.jpg" data-imagecss="flag yt"
                                data-title="English">English</option>
                            <option value='yu' data-image="img/flag.jpg" data-imagecss="flag yu"
                                data-title="Bangladesh">Bangla</option>
                        </select>
                    </div>
                    <div class="top-social">
                        <a href="#"><i class="ti-facebook"></i></a>
                        <a href="#"><i class="ti-twitter-alt"></i></a>
                        <a href="#"><i class="ti-linkedin"></i></a>
                        <a href="#"><i class="ti-pinterest"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="inner-header">
                <div class="row">
                    <div class="col-lg-2 col-md-2">
                        <div class="logo">
                            <a href="./index.html">
                                <img src="img/logo.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-7 col-md-7">
                        <div class="advanced-search">
                            <button type="button" class="category-btn">All Categories</button>
                            <form action="#" class="input-group">
                                <input type="text" placeholder="What do you need?">
                                <button type="button"><i class="ti-search"></i></button>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-3 text-right col-md-3">
                        <ul class="nav-right">
                            <li class="heart-icon"><a href="#">
                                    <i class="icon_heart_alt"></i>
                                    <span>1</span>
                                </a>
                            </li>
                            <li class="cart-icon"><a href="#">
                                    <i class="icon_bag_alt"></i>
                                    <span>3</span>
                                </a>
                                <div class="cart-hover">
                                    <div class="select-items">
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td class="si-pic"><img src="img/select-product-1.jpg" alt=""></td>
                                                    <td class="si-text">
                                                        <div class="product-selected">
                                                            <p>$60.00 x 1</p>
                                                            <h6>Kabino Bedside Table</h6>
                                                        </div>
                                                    </td>
                                                    <td class="si-close">
                                                        <i class="ti-close"></i>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="si-pic"><img src="img/select-product-2.jpg" alt=""></td>
                                                    <td class="si-text">
                                                        <div class="product-selected">
                                                            <p>$60.00 x 1</p>
                                                            <h6>Kabino Bedside Table</h6>
                                                        </div>
                                                    </td>
                                                    <td class="si-close">
                                                        <i class="ti-close"></i>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="select-total">
                                        <span>total:</span>
                                        <h5>$120.00</h5>
                                    </div>
                                    <div class="select-button">
                                        <a href="#" class="primary-btn view-card">VIEW CARD</a>
                                        <a href="#" class="primary-btn checkout-btn">CHECK OUT</a>
                                    </div>
                                </div>
                            </li>
                            <li class="cart-price">$150.00</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="nav-item">
            <div class="container">
                <div class="nav-depart">
                    <div class="depart-btn">
                        <i class="ti-menu"></i>
                        <span>All departments</span>
                        <ul class="depart-hover">
                            <li class="active"><a href="#">Womenâs Clothing</a></li>
                            <li><a href="#">Menâs Clothing</a></li>
                            <li><a href="#">Underwear</a></li>
                            <li><a href="#">Kid's Clothing</a></li>
                            <li><a href="#">Brand Fashion</a></li>
                            <li><a href="#">Accessories/Shoes</a></li>
                            <li><a href="#">Luxury Brands</a></li>
                            <li><a href="#">Brand Outdoor Apparel</a></li>
                        </ul>
                    </div>
                </div>
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <li><a href="./index.html">Home</a></li>
                        <li><a href="./shop.html">Shop</a></li>
                        <li><a href="#">Collection</a>
                            <ul class="dropdown">
                                <li><a href="#">Men's</a></li>
                                <li><a href="#">Women's</a></li>
                                <li><a href="#">Kid's</a></li>
                            </ul>
                        </li>
                        <li><a href="./blog.html">Blog</a></li>
                        <li><a href="./contact.html">Contact</a></li>
                        <li><a href="#">Pages</a>
                            <ul class="dropdown">
                                <li><a href="./blog-details.html">Blog Details</a></li>
                                <li><a href="./shopping-cart.html">Shopping Cart</a></li>
                                <li><a href="./check-out.html">Checkout</a></li>
                                <li><a href="./faq.html">Faq</a></li>
                                <li><a href="./register.html">Register</a></li>
                                <li><a href="./login.html">Login</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
                <div id="mobile-menu-wrap"></div>
            </div>
        </div>
    </header>
    <!-- Header End -->

    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text">
                        <a href="#"><i class="fa fa-home"></i> Home</a>
                        <span>FAQs</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->

    <!-- Faq Section Begin -->
    <div class="faq-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                	<div class="row">
                		<div class="col-lg-1">
                		</div>
                		<div class="col-lg-1" style="border-left: 1px solid #D5D5D5;">
                		</div>
                		<div class="col-lg-8">
		                	<h2>1대1 상세보기</h2>
		                	<%
								for(HashMap<String,Object> m : list2){
									if(m.get("id").equals(id)) {
							%>
				                	<div>
				                		<a class="btn btn-outline-secondary btn-sm" style="float:right; margin-right:10px;" href="<%=request.getContextPath() %>/cs/deleteEtcCsOneAction.jsp?oqNo=<%=oqNo %>">삭제하기</a>
					                	<a class="btn btn-outline-secondary btn-sm" style="float:right; margin-right:10px;" href="#" onclick="openNewWindow()">수정하기</a>
				                	</div>
		                	<%
									}
								}
		                	%>
		                	<br><br>
		                	<form action="<%=request.getContextPath() %>/cs/insertEtcCsAnswerAction.jsp">
			                	<table class="table">
									<%
										for(HashMap<String,Object> m : list){
									%>
										<tr>
											<th colspan="2" style="width:500px; font-size:18pt;">
												제목: <%=(String)m.get("oqTitle") %>
											</th>
										</tr>
										<tr>
											<th colsapn="2" style="height:500px;">
												<%=(String)m.get("oqContent") %>
											</th>
										</tr>
									<%
										}
									%>
										<tr>
											<%
												//일반 고객일 경우 댓글 작성
												if(empLevel==0){
											%>
												<td style="width:780px;">
													<label for="comment">댓글 작성&nbsp;&nbsp;&nbsp;<sapn style="font-weight:bold;"><%=id %></sapn></label>
													<textarea class="form-control" rows="5" id="comment" name="oaContent"></textarea>
												</td>
												<td>
													<button class="btn btn-secondary" style="margin-top: 130px;" type="submit">작성</button>
													<input type="hidden" name="oqNo" value="<%=oqNo %>">
												</td>
											<%
												// 관리자 일경우 댓글작성
												} else if (empLevel>0){
											%>
												<td style="width:780px;">
													<label for="comment">댓글 작성&nbsp;&nbsp;&nbsp;<sapn style="font-weight:bold;">관리자</sapn></label>
													<textarea class="form-control" rows="5" id="comment" name="oaContent"></textarea>
												</td>
												<td>
													<button class="btn btn-secondary" style="margin-top: 130px;" type="submit">작성</button>
													<input type="hidden" name="oqNo" value="<%=oqNo %>">
												</td>
											<%
												}
											%>
										</tr>
								</table>
							</form>
							<h4>💬댓글</h4>
							<hr>
							<%
								for(HashMap<String,Object> m : list2){
							%>
							<table class="table">
								<tr>
									<th style="font-size:10pt; background-color: #F6F6F6;">
										<%
											if((int)m.get("checked")==1){
										%>
											관리자
										<%
											} else {
										%>
											<%=(String)m.get("id") %>
										<%
											}
										%>
										<div style="float:right; color:#BDBDBD;">
											<%=(String)m.get("updatedate") %>
										<%
											if(m.get("id").equals(id) || empLevel>0){
										%>
											<a style="text-decoration: none; color:#000000;" href="<%=request.getContextPath()%>/cs/deleteEtcCsCommentAction.jsp?oaNo=<%=(int)m.get("oaNo") %>&oqNo=<%=oqNo%>">삭제</a>
										<%
											}
										%>
										</div>
									</th>
								</tr>
								<tr>
									<td style="font-size:12pt;">
										<%=(String)m.get("oaContent") %>
									</td>
								</tr>
							</table><br>
							<%
								}
							%>
						</div><!-- col-lg-8 -->
						<div class="col-lg-1" style="border-right:1px solid #D5D5D5;">
						</div>
						<div class="col-lg-1">
						</div>
					</div><!-- row -->
                </div><!-- col lg 12 -->
            </div>
        </div>
    </div>
    <!-- Faq Section End -->

    

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
	<script>
		function openNewWindow() {
			var url = "<%=request.getContextPath() %>/cs/updateEtcCsOne.jsp?oqNo=<%=oqNo %>";
			window.open(url, '문의 내용 수정', 'width=500,height=500');
		}
	</script>
</body>

</html>