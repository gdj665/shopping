<%@page import="dao.main.EmployeesDao"%>
<%@page import="vo.product.Track"%>
<%@page import="dao.main.MainDao"%>
<%@page import="vo.product.Category"%>
<%@page import="vo.product.ProductImg"%>
<%@page import="vo.product.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	//유효성 검사
	if(session.getAttribute("loginId") == null){
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//값 받기
	String id = (String)session.getAttribute("loginId");
	
	// EmployeesDao 선언
	EmployeesDao ed = new EmployeesDao();
	
	// 관리자 레벨 출 력
	int empLevel = ed.checkEmployees(id);
	
	// 관리자가 아닐시 홈화면으로
	if(empLevel<1){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	// 유의성 검사
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}

	// param값 선언
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	// System.out.println(productNo + " <-productNo");
	int totalTrackCnt = Integer.parseInt(request.getParameter("totalTrackCnt"));
	// param값이 여러개이기 때문에 values로 선언
	String[] trackNo = request.getParameterValues("trackNo");
	String[] trackName = request.getParameterValues("trackName");
	String[] trackTime = request.getParameterValues("trackTime");

	MainDao md = new MainDao();
	
	// track insert 데이터 track class에 입력
	ArrayList<Track> trackList = new ArrayList<>();
	for (int i = 0; i < totalTrackCnt; i++){
		Track track = new Track();
		track.setProductNo(productNo);
		track.setTrackNo(Integer.parseInt(trackNo[i]));
		track.setTrackName(trackName[i]);
		track.setTrackTime(Integer.parseInt(trackTime[i]));
		trackList.add(track);
	}
	
	int checkInsert = md.insertTrack(trackList);
	
	System.out.printf("%d <- checkInsert, %d <- totalTrackCnt", checkInsert, totalTrackCnt);
	
	response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?prodcutNo=" + productNo);
	return;
%>