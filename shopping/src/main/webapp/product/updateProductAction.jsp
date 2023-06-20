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
	MainDao md = new MainDao();

	String dir = request.getServletContext().getRealPath("/img/productImg");
	int maxFileSize = 1024 * 1024 * 10; // 10Mbyte
	// request 객체를 MultipartRequest의 API를 사용할 수 있도록 랩핑
	// MultipartRequest API를 사용하여 스트림내에서 문자값을 반환받을 수 있다.
	MultipartRequest mRequest = new MultipartRequest(request, dir, maxFileSize, "utf-8", new DefaultFileRenamePolicy());
	
	if (mRequest.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
	
	// file 넣었을 경우에 실행
	if(mRequest.getContentType("productImgFile") != null){
		// 업로드 파일이 jpg 파일이 아니면
		if (mRequest.getContentType("productImgFile").equals("image/jpeg") == false
				&& mRequest.getContentType("productImgFile").equals("image/jpg") == false){
			// 이미 저장된 파일을 삭제
			System.out.println("jpg파일이 아닙니다.");
			String saveFilename = mRequest.getFilesystemName("productImgFile");
			File f = new File(dir + "\\" + saveFilename);
			if(f.exists()){
				f.delete();
			System.out.println(dir + "\\" + saveFilename + "파일삭제");
			}
			response.sendRedirect(request.getContextPath() + "/product/updateProduct.jsp?productNo" + productNo);
			return;
		}
		
		// 이전 파일 삭제
		String preSaveFilename = md.selectProductImg(productNo);
		File f = new File(dir + "\\" + preSaveFilename);
		if(f.exists()){
			f.delete();
		System.out.println(dir + "\\" + preSaveFilename + "파일삭제");
		}
		
		String productFiletype = mRequest.getContentType("productImgFile");
		String productOriginFilename = mRequest.getOriginalFileName("productImgFile");
		String productSaveFilename = mRequest.getFilesystemName("productImgFile");
		
		// productImg update 데이터 productImg class에 입력
		ProductImg productImg = new ProductImg();
		productImg.setProductOriFilename(productOriginFilename);
		productImg.setProductSaveFilename(productSaveFilename);
		productImg.setProductFiletype(productFiletype);
		
		// 입력한 product 값을 db에 입력
		int checkProductImg = md.updateProductImg(productNo, productImg);
		System.out.println(checkProductImg + " <- checkProductImg");
	}
	
	// product, track 데이터 선언
	String productName = mRequest.getParameter("productName");
	String productStatus = mRequest.getParameter("productStatus");
	int productPrice = Integer.parseInt(mRequest.getParameter("productPrice"));
	int productStock = Integer.parseInt(mRequest.getParameter("productStock"));
	String categoryMainName = mRequest.getParameter("categoryMainName");
	String categorySubName = mRequest.getParameter("categorySubName");
	String productSinger = mRequest.getParameter("productSinger");
	String productInfo = mRequest.getParameter("productInfo");
	// String으로 받고 값 넣을때 형변환
	String[] trackNo = mRequest.getParameterValues("trackNo");
	String[] productTrackNo = mRequest.getParameterValues("productTrackNo");
	String[] trackName = mRequest.getParameterValues("trackName");
	String[] trackTime = mRequest.getParameterValues("trackTime");
	
	// checkCategory 메소드를 통해 categoryNo를 받아서 입력
	int categoryNo = md.checkCategory(categoryMainName, categorySubName);
	
	// product insert 데이터 product class에 입력
	Product product = new Product();
	product.setProductNo(productNo);
	product.setCategoryNo(categoryNo);
	product.setProductName(productName);
	product.setProductStatus(productStatus);
	product.setProductPrice(productPrice);
	product.setProductStock(productStock);
	product.setProductSinger(productSinger);
	product.setProductInfo(productInfo);
	
	// 입력한 product 값을 db에 입력
	int checkUpdateProduct = md.updateProduct(product);
	System.out.println(checkUpdateProduct + " <- checkUpdateProduct");
	
	// track insert 데이터 track class에 입력
	ArrayList<Track> trackList = new ArrayList<>();
	for (int i = 0; i < trackNo.length; i++){
		Track track = new Track();
		track.setProductNo(productNo);
		track.setTrackNo(Integer.parseInt(trackNo[i]));
		track.setProductTrackNo(Integer.parseInt(productTrackNo[i]));
		track.setTrackName(trackName[i]);
		track.setTrackTime(Integer.parseInt(trackTime[i]));
		trackList.add(track);
	}
	int checkUpdateTrack = md.updateTrack(trackList);
	System.out.println(checkUpdateTrack + " <- checkUpdateTrack");
	
	
	response.sendRedirect(request.getContextPath() + "/product/updateProduct.jsp?productNo=" + productNo);
	return;
%>