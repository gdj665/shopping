<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.member.*" %>
<%
  // 요청에서 ID 매개변수를 가져옵니다.
  String id = request.getParameter("id");
   MemberDao mamDao = new MemberDao();
  boolean isDuplicated = mamDao.checkIdDuplication(id);

  // 결과를 응답으로 반환합니다.
  if (isDuplicated) {
    out.print("<span style='color: red;'>이미 사용 중인 ID입니다.</span>");
  } else {
    out.print("<span style='color: green;'>사용 가능한 ID입니다.</span>");
  }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>




</body>
</html>