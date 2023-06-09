<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.cs.*" %>
<%@ page import = "vo.id.*" %>
<%@ page import = "vo.cs.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	
	// 값 받아오기
	int productNo = 1;
	
	//OrderDao 선언
	CsDao csdao = new CsDao();

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
<title>Insert title here</title>
<style>
	table {
		border:1px solid #000000;
		border-collapse: collapse;
	}
</style>
</head>
<body>
	<!-- 제품문의 입력 테이블 (고객 사용 가능) -->
	<form action="<%=request.getContextPath() %>/cs/insertProductCsAction.jsp">
		<input type="hidden" name="productNo" value="<%=productNo %>">
		<table>
			<tr>
				<td colspan="2">질문입력</td>
			</tr>
			<tr>
				<td><input type = "text" name="qContent"></td>
				<td><button type="submit">입력</button></td>
			</tr>
		</table>
		<br>
	</form>
	
	<%
		// 질문 리스트 출력
		for(Qa q : list){
			// 질문 번호 저장
			int qNo = q.getqNo();
			// 저장된 질문번호를 받아서 변수값에 넣기
			list2 = csdao.answerList(qNo);
	%>
			<!-- 질문리스트 출력 -->
			<table>
				<tr>
					<td style="background-color: grey; color:white;">질문</td>
					<td><%=q.getId() %></td>
					<td><%=q.getCreatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/cs/deleteProductQuestionAction.jsp?qNo=<%=q.getqNo()%>&productNo=<%=productNo%>">X</a></td>
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
			<table>
				<tr>
					<td style="font-weight: bold;">↳<span style="background-color: blue; color:white;">답변</span></td>
					<td style="font-weight: bold;">[관리자]</td>
					<td><%=(String)m.get("createdate")%></td>
					<td><a href="<%=request.getContextPath()%>/cs/deleteProductAnswerAction.jsp?productNo=<%=productNo%>&aNo=<%=(int)m.get("aNo")%>">X</a></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="3"><%=(String)m.get("aContent")%></td>
				</tr>
			</table>
			<br>
			
	<%
				}// qNo==apNo 비교 if문
			}// list2 for 문
	%>
	<%		// 질문에 대한 답변이 없을 경우에만 테이블 출력
			if(answer != true){
	%>
				<form action="<%=request.getContextPath()%>/cs/productCsListAction.jsp">
					<table>
						<tr>
							<td colspan="2">답변입력</td>
						</tr>
						<tr>
							<td><input type = "text" name="aContent"></td>
							<td><button type="submit">입력</button></td>
						</tr>
					</table>
					<br>
					<!-- 값 넘기기 -->
					<input type="hidden" name="qNo" value="<%=qNo %>">
					<input type="hidden" name="productNo" value="<%=productNo %>">
				</form>
	<%	
			}// 답변이 없을경우에는 입력창 출력하는 if문
		}// 질문 리스트 출력 for문
	%>
</body>
</html>