<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	request.setCharacterEncoding("utf-8");

	//값 받아오기
	String id = (String)session.getAttribute("loginId");

	//OrderDao사용 선언
	OrderDao orderdao = new OrderDao();
	
	// 1) OrderDao 장바구니 리스트 출력 메서드
	ArrayList<HashMap<String,Object>> list = orderdao.cartList(id);
	
	// 2) OrderDao 장바구니 각 항목의 총 합계의 최종합계를 구하는 메서드
	int row = orderdao.totalPrice(id);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

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
</head>
<body>
	<div class="container">
	    <div class="inner-header">
	        <div class="row">
	            <div class="col-lg-9 col-md-9">
	                <div class="advanced-search">
	                    <div class="input-group">
	                    <form action="<%=request.getContextPath()%>/product/searchList.jsp" method="post">
							<input type="text" name="searchWord" placeholder="검색어를 입력하세요">
	                        <button type="submit"><i class="ti-search"></i></button>
						</form>
	                    </div>
	                </div>
	            </div>
	            <div class="col-lg-3 text-right col-md-3">
	                <ul class="nav-right">
	                    <li class="cart-icon">
	                        <a href="<%=request.getContextPath()%>/order/cart.jsp">
	                            <i class="icon_bag_alt"></i>
	                            <span></span>
	                        </a>
	                        <div class="cart-hover">
	                            <div class="select-items">
	                                <table>
	                                    <tbody>
	                                    	<%
												// 장바구니 리스트 출력
												for(HashMap<String,Object> m : list){
													int productNo = (int)m.get("productNo");
													int cartCnt = (int)m.get("cartCnt");
													String checked = (String)m.get("checked");
													
													
													// 3) 각 제품의 재고량을 구하는 메서드
													int tcnt = orderdao.totalstock(productNo);
											%>
	                                        <tr>
	                                            <td class="si-pic">
	                                            	<img style="width:60px; height:60px;" src="<%=request.getContextPath() + "/img/productImg/" + (String)m.get("productSaveFilename")%>">
	                                            </td>
	                                            <td class="si-text">
	                                                <div class="product-selected">
	                                                	<h6><%=(String)m.get("productName") %></h6>
	                                                    <p><%=m.get("discountPrice")%> x <%=cartCnt %></p>
	                                                </div>
	                                            </td>
	                                            <td class="si-close">
	                                                <i class="ti-close"></i>
	                                            </td>
	                                        </tr>
	                                        <%
												}
	                                        %>
	                                    </tbody>
	                                </table>
	                            </div>
	                            <div class="select-total">
	                                <span>total:</span>
	                                <h5><%=row%>원</h5>
	                            </div>
	                            <div class="select-button">
	                                <a href="<%=request.getContextPath()%>/order/cart.jsp" class="primary-btn checkout-btn">장바구니 이동</a>
	                            </div>
	                        </div>
	                    </li>
	                    <li class="cart-price"><%=row%></li>
	                </ul>
	            </div>
	        </div>
	    </div>
	</div>
	
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