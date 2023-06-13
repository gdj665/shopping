<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String employeesId = request.getParameter("employeesId");
	System.out.println(employeesId + " <-employeesId");
	String employeesIdLevel = employeesId + "Level";
	System.out.println(employeesIdLevel + " <-employeesIdLevel");
	int employeesLevel = Integer.parseInt(request.getParameter(employeesIdLevel));
	System.out.println(employeesLevel + " <-employeesLevel");
%>
