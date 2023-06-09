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
	// 세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginId"));

	// 첫번쨰 페이지
	int currentPage = 1; 
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 페이지당 보여줄 행
	int rowPerPage = 10;
	
	int beginRow = (currentPage -1) * rowPerPage;	
	System.out.println(id+"<-- id");	
	
	
	PointDao pointDao = new PointDao();
	ArrayList<HashMap<String, Object>> list = pointDao.cstmPointList(beginRow, rowPerPage, id);
	
	// 총 행의 수를 얻기위한 메소드 사용
	PointDao totalPoint = new PointDao();
	int totalRow = totalPoint.pointRow();
	System.out.println(totalRow+"<-- totalRow");
	
	// 마지막 페이지 구하기
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
	System.out.println(startPage+"<-- startPage");
	System.out.println(endPage+"<-- endPage");
	
	int row = pointDao.totalpoint(id);
	System.out.println(row);
	
%>
<!DOCTYPE html>
<html lang="zxx">

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
    
    <!-- Breadcrumb Section Begin -->
<!-- ----------------------------------------------------------------포인트조회-------------------------------------------------------------------- -->
    <!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-table">
                   
                        <table>
                            <thead>
                                <tr>
                                    <th>주문번호</th>
                                    <th>사용</th>
                                    <th>포인트</th>
                                    <th>적립일자</th>
                                </tr>
                            </thead>
                             <%
								for(HashMap<String, Object> s : list){
									if((Integer)(s.get("point")) == 0){
										continue;
									}
							%>
                            <tbody>
                                <tr>
                                    <td class="cart-pic first-row">
                                    <%=(Integer)(s.get("orderNo"))%>
                                    </td>
                                    <td>
                                    <% if("+".equals((String)(s.get("pointPm")))){
                                    	out.print("적립");
                                    } else {
                                    	out.print("사용");
                                    }
                                    %>
                                    </td>
                                    <td class="p-price first-row">
                                    <%=(Integer)(s.get("point"))%>
                                    </td>
                                    <td class="total-price first-row">
                                    <%=(String)(s.get("createdate"))%>
                                    </td>
                                </tr>
                                
                            </tbody>
                        <%
							}
						%>
                        </table>
							<div>
						<%
							if(currentPage > 1){
						%>
							<a class="btn btn-sm" href="<%=request.getContextPath()%>/customer/pointMyPage.jsp?currentPage=<%=startPage-1%>">이전</a>
						<%
							}
							for(int i = startPage; i<=endPage; i++){
						%>
							<a href="<%=request.getContextPath()%>/customer/pointMyPage.jsp?currentPage=<%=i%>"><%=i%></a>
						<%
							}
							if(currentPage < lastPage){
						%>
							<a class="btn btn-sm" href="<%=request.getContextPath()%>/customer/pointMyPage.jsp?currentPage=<%=endPage+1%>">다음</a>
						<%
							}
						%>
						</div>
                    </div>
                    <div class="row">
                        
                        <div class="col-lg-4 offset-lg-4">
                            <div class="proceed-checkout">
                                <ul>
                                    <li class="cart-total">Total <span><%=row%></span></li>
                                </ul>
                                <a href="#" class="proceed-btn">PROCEED TO CHECK OUT</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shopping Cart Section End -->
<!-- ----------------------------------------------------------------포인트조회-------------------------------------------------------------------- -->
    

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