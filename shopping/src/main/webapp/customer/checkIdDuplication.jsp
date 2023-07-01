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


<script>
  var delayTimer;
  
  function checkIdDuplication() {
    clearTimeout(delayTimer);
    
    delayTimer = setTimeout(function() {
      var id = document.getElementById("id").value;

      // 서버에 비동기적으로 ID 중복을 확인하기 위한 요청을 수행합니다.
      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
          var response = xhr.responseText;

          // ID 중복 결과 메시지를 업데이트합니다.
          var idDuplicationResult = document.getElementById("idDuplicationResult");
          idDuplicationResult.innerHTML = response;
        }
      };

      xhr.open("GET", "<%=request.getContextPath()%>/customer/checkIdDuplication.jsp?id=" + id, true);
      xhr.send();
    }, 500); // 0.5초 딜레이를 설정하여 사용자의 연속 입력을 기다립니다.
  }
</script>


</body>
</html>