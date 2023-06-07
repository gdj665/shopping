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
	if (request.getParameter("productNo") == null
			||request.getParameter("trackNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}

	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int trackNo = Integer.parseInt(request.getParameter("trackNo"));

	MainDao md = new MainDao();
	
	// track insert 데이터 track class에 입력
	ArrayList<Track> trackList = new ArrayList<>();
	Track track = new Track();
	track.setProductNo(productNo);
	track.setTrackNo(trackNo);
	trackList.add(track);
	
	int checkInsert = md.insertTrack(trackList);
	
	System.out.printf("%d <- checkInsert, %d <- trackNo", checkInsert, trackNo);
	
	response.sendRedirect(request.getContextPath() + "/product/updateProduct.jsp?productNo=" + productNo);
%>