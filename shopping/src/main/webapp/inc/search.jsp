<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>search</title>

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
	                    <li class="heart-icon">
	                        <a href="#">
	                            <i class="icon_heart_alt"></i>
	                            <span>1</span>
	                        </a>
	                    </li>
	                    <li class="cart-icon">
	                        <a href="#">
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