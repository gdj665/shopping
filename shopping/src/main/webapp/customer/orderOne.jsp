<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginId"));
	
		
	//세션아이디 디버깅
	System.out.println(id+"<--orderMyPage id");	
	
	OrderListDao orderDao = new OrderListDao();
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	System.out.println(orderNo + "<-- orderMyPage orderList");
	
	ArrayList<HashMap<String, Object>> list = orderDao.orderOne(orderNo);
	System.out.println(list + "<-- orderMyPage orderList");
	
	
	ArrayList<HashMap<String, Object>> li = orderDao.totalorder(id, orderNo);
	System.out.println(li.size());
	
	
%>
<!DOCTYPE html>
<html lang="zxx">
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<div id="preloder">
        <div class="loader"></div>
    </div>

    <div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>

<!-- ---------------------------------------------------------주문내역----------------------------------------------------------------------------- -->
    <!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-table">
                        <table class="table-hover">
                            <thead>
                                <tr>
                                    <th>상품이미지</th>
									<th>상품이름</th>
									<th>주문개수</th>
									<th>상품가격</th>
									<th>합계</th>
									<th>배송상태</th>
									<th>구매일</th>
                                </tr>
                            </thead>
                    <%
						for(HashMap<String, Object> m : list){
					%>
                            <tbody>
                                <tr onclick="location.href='<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=(Integer)(m.get("productNo"))%>'" style="cursor: pointer; width: 10px; height: 10;">
                                    <td class="cart-title first-row">
                                        <img src="<%=request.getContextPath() + "/img/productImg/" + (String)(m.get("saveFile"))%>">
                                    </td>
                                    <td class="p-price first-row"><%=(String)(m.get("productName"))%></td>
                                    <td class="p-price first-row"><%=(Integer)(m.get("orderCnt"))%></td>
                                    <td class="p-price first-row"><%=(Integer)(m.get("productPrice"))%></td>
                                    <td class="p-price first-row"><%=(Integer)(m.get("totalrow"))%></td>
                                    <td class="p-price first-row">
									<%
										switch((Integer)m.get("orderStatus")){
											case 0:
												out.print("결제 미완료");
												break;
											case 1:
												out.print("결제 완료");
												break;
											case 2:
												out.print("배송 중");
												break;
											case 3:
												out.print("배송 완료");
												break;
											case 4:
												out.print("구매 확정");
												break;
										}
									%>
									</td>
                                    <td class="total-price first-row"><%=(String)(m.get("createdate"))%></td>
                                </tr>
                                
                            </tbody>
							<%
								}
                 			%>
                        </table>
                         <%
						for(HashMap<String, Object> m : li){
					%>
                        <div class="col-lg-4 offset-lg-4">
                            <div class="proceed-checkout">
                                <ul>
                                    <li class="subtotal">총금액 <span><%=(Integer)(m.get("orderPrice"))%></span></li>
                                    <li class="subtotal">포인트사용 <span><%=(Integer)(m.get("orderPointUse"))%></span></li>
                                    <li class="cart-total">결제금액 <span><%=(Integer)(m.get("totalPrice"))%></span></li>
                                </ul>
                                <a href="#" class="proceed-btn">PROCEED TO CHECK OUT</a>
                            </div>
                        </div>
                        <%
								}
                 			%>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shopping Cart Section End -->
<!-- ---------------------------------------------------------주문내역----------------------------------------------------------------------------- -->
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
    <script src="<%=request.getContextPath()%>/template/js/jquery-3.3.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.countdown.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.nice-select.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.zoom.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.dd.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.slicknav.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/main.js"></script>
</body>

</html>