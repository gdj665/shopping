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
	
	// 유효성 검사
	if(request.getParameter("productNo")==null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("productcsList null 있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값 받아오기
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String id = (String)session.getAttribute("loginId");
	
	
	//OrderDao 선언
	CsDao csdao = new CsDao();
	EmployeesDao employeesdao = new EmployeesDao();
	
	int empLevel = employeesdao.checkEmployees(id);
	int row = 0;
	
	// 1) 제품당 문의 리스트 불러오기
	ArrayList<Qa> list = new ArrayList<>();
	list = csdao.questionList(productNo);
	
	// 2) 답변 리스트 출력
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<>();
	
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
<style>
	a{
		text-decoration: none;
		color:#000000;
	}
	td {
		height:50px;
	}
	.vertical-center {
        display: flex;
        align-items: center;
    }
</style>
</head>

<body>
  
    <!-- Faq Section Begin -->
    <div class="faq-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <!-- 제품문의 입력 테이블 (고객 사용 가능) -->
                    <%
                    	if(empLevel==0){
                    %>
						<form action="<%=request.getContextPath() %>/cs/insertProductCsAction.jsp" method="post">
							<input type="hidden" name="productNo" value="<%=productNo %>">
							<table style="width:100%;">
								<tr>
									<th colspan="2">상품문의</th>
								</tr>
								<tr>
									<td>
										<textarea rows="3" class="form-control" name="qContent" placeholder="문의 내용을 입력해주시기 바랍니다"></textarea>
									</td>
									<td style="width:100px;">
										<button style="margin-top:50px; margin-right:30px; float:right;" class="btn btn-outline-dark" type="submit">작성</button>
									</td>
								</tr>
							</table>
							<br>
							<hr>
						</form>
					<%
                    	}
					%>
					<%
						// 질문 리스트 출력
						for(Qa q : list){
							// 질문 번호 저장
							int qNo = q.getqNo();
							// 저장된 질문번호를 받아서 변수값에 넣기
							list2 = csdao.answerList(qNo);
					%>
							<!-- 질문리스트 출력 -->
							<table style="width:100%;">
								<tr>
									<th style="width:100px;"><sapn style="margin-left:10px; background-color: grey; color:white; font-size:10pt; padding:5px;">질문</sapn></sapn></th>
									<td>ID : <%=q.getId() %></td>
									<td style="float:right;" class="vertical-center">
										<%=q.getCreatedate()%>
										<!-- 쓴사람과 동일 할때만 삭제 -->
										<%
											if(q.getId().equals(session.getAttribute("loginId"))){
										%>
											<a href="<%=request.getContextPath()%>/cs/deleteProductQuestionAction.jsp?qNo=<%=q.getqNo()%>&productNo=<%=productNo%>">&nbsp;X&nbsp;</a>
										<%
											}
										%> 
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="3"><%=q.getqContent() %></td>
								</tr>
							</table>
					<%
						//질문번호와 answer 테이블에 있는 질문번호가 일치하면 답변 출력
						boolean answer = false;
						for(HashMap<String,Object> m : list2){
							int aqNo = (int)m.get("qNo");
							if (qNo == aqNo){
								answer = true;
					%>
							<table style="width:100%; background-color:#F6F6F6;">
								<tr>
									<td style="font-weight: bold; width:100px;">&nbsp;&nbsp;↳&nbsp; <span style="background-color:#1266FF; color:white; font-size: 10pt; padding:5px;">답변</span></td>
									<td style="font-weight: bold;">[관리자]</td>
									<td style="float:right;" class="vertical-center">
										<%=(String)m.get("createdate")%>
										<%
											if(empLevel>0){
										%>
											<a href="<%=request.getContextPath()%>/cs/deleteProductAnswerAction.jsp?productNo=<%=productNo%>&aNo=<%=(int)m.get("aNo")%>">&nbsp;X&nbsp;</a>
										<%
											}
										%>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="2"><%=(String)m.get("aContent")%></td>
								</tr>
							</table>
							
					<%
								}// qNo==apNo 비교 if문
							}// list2 for 문
					%>
					<%		// 질문에 대한 답변이 없을 경우에만 테이블 출력
							if(answer != true){
								if(empLevel>0){
					%>
								<form action="<%=request.getContextPath()%>/cs/productCsListAction.jsp">
									<table style="width:100%; background-color: #F6F6F6;">
										<tr>
											<th colspan="2"><label style="margin-left:10px; margin-top:10px;">&nbsp;&nbsp;↳&nbsp;답변작성필요</label></th>
										</tr>
										<tr>
											<td>
												<textarea rows="3" style="margin-left:10px; margin-bottom:20px;" class="form-control" name="aContent" placeholder="답변을 입력해주시기 바랍니다"></textarea>
											</td>
											<td style="width:100px;">
												<button style="margin-right:30px; margin-top:30px; float:right;" class="btn btn-outline-dark" type="submit">작성</button>
											</td>
										</tr>
									</table>
									<!-- 값 넘기기 -->
									<input type="hidden" name="qNo" value="<%=qNo %>">
									<input type="hidden" name="productNo" value="<%=productNo %>">
								</form>
					<%	
								}
							}// 답변이 없을경우에는 입력창 출력하는 if문
						}// 질문 리스트 출력 for문
					%>
                </div><!-- col-lg-12 -->
            </div>
        </div>
    </div>
</body>

</html>