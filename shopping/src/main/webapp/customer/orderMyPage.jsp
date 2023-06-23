<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 로그인 세션 확인
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	//세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginId"));
	
	//보여줄페이지 첫번째 행 선언
	int currentPage = 1; 
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//페이지당 보여줄 행
	int rowPerPage = 10;

	int beginRow = (currentPage -1) * rowPerPage;
		
	//세션아이디 디버깅
	System.out.println(id+"<--orderMyPage id");	
	
	OrderListDao orderDao = new OrderListDao();

	ArrayList<HashMap<String, Object>> list = orderDao.orderList(id, beginRow, rowPerPage);
	System.out.println(list + "<-- orderMyPage orderList");
	
	
	int totalRow = orderDao.orderCnt();
	System.out.println(totalRow+"<-- orderMyPage totalRow");
	
	// 마지막 페이지 구하는 변수
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage++;
	}
	int pageCount = 10;// 페이지당 출력될 페이지수
	
	int startPage = ((currentPage -1)/pageCount)*pageCount+1;
	
	int endPage = startPage+9;
	if(endPage > lastPage){
	endPage = lastPage;
	}
	System.out.println(startPage+"<-- orderMyPage startPage");
	System.out.println(endPage+"<-- orderMyPage endPage");
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
                                    <th>상품이름</th>
                                    <th>배송상태</th>
                                    <th>주소</th>
                                    <th>결제금액</th>
                                    <th>구매일</th>
                                </tr>
                            </thead>
                    <%
						for(HashMap<String, Object> m : list){
					%>
                            <tbody>
                                <tr onclick="location.href='<%=request.getContextPath()%>/customer/orderOne.jsp?orderNo=<%=(Integer)(m.get("orderNo"))%>'" style="cursor: pointer; ">
                                    <td class="cart-pic first-row"><%=(String)(m.get("productName"))%></td>
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
											case 5:
												out.print("주문 취소");
												break;
										}
									%>
									</td>
                                    <td class="qua-col first-row"><%=(String)(m.get("Address"))%></td>
                                    <td class="p-price first-row"><%=(Integer)(m.get("totalPrice"))%></td>
                                    <td class="qua-col first-row"><%=(String)(m.get("createdate"))%></td>
                                </tr>
                                
                            </tbody>
							<%
								}
                 			%>
                        </table>
                        <div>
	
							<%
								if(startPage > 5){
							%>
								<a href="<%=request.getContextPath()%>/customer/ordierMyPage.jsp?currentPage=<%=startPage-1%>">이전</a>
							<%
								}
								for(int i = startPage; i<=endPage; i++){
							%>
								<a href="<%=request.getContextPath()%>/customer/ordierMyPage.jsp?currentPage=<%=i%>"><%=i%></a>
							<%
								}
								if(endPage<lastPage){
							%>
								<a href="<%=request.getContextPath()%>/customer/ordierMyPage.jsp?currentPage=<%=endPage+1%>">다음</a>
							<%
								
								}
							%>
						</div>
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