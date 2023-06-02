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
	
	// 메세지 출력 설정
	String msg = null;
	
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
	table,td,th {
		border:1px solid #000000;
		border-collapse: collapse;
	}
</style>
</head>
<body>
	<table>
		<%
			//질문부터출력
			for(Qa q : list){
				// 질문 번호 저장
				int qNo = q.getqNo();
				// 저장된 질문번호를 받아서 변수값에 넣기
				list2 = csdao.answerList(qNo);
				System.out.println("qNo-->"+qNo);
		%>
				<tr>
					<th colspan="3">질문</th>
				</tr>
				<tr>
					<td><%=q.getId() %></td>
					<td><%=q.getqContent() %></td>
					<td><%=q.getCreatedate()%></td>
				</tr>
	</table>
		<%
				//질문번호와 answer 테이블에 있는 질문번호가 일치하면 출력
				boolean answer = false;
				for(HashMap<String,Object> m : list2){
					int aqNo = (int)m.get("qNo");
					System.out.println("aqNo-->"+aqNo);
					if (qNo == aqNo){
						answer = true;
		%>
						<table>
							<tr>
								<th colspan="3">답변</th>
							</tr>
							<tr>
								<td><%=(String)m.get("id")%></td>
								<td><%=(String)m.get("aContent")%></td>
								<td><%=(String)m.get("createdate")%></td>
							</tr>
						</table>
		<%
					}// qNo==apNo 비교 if문
					
				}// list2 for 문
				if(answer != true){
		%>
					<form>
						<table>
							<tr>
								<td colspan="3">답변입력</td>
							</tr>
							<tr>
								<td><input type = "text" name="aContent"></td>
							</tr>
						</table>
						<button type="submit">입력</button>
					</form>
		<%	
				}//답변이 없을경우에는 입력창 출력
			}//list for문
		%>
</body>
</html>