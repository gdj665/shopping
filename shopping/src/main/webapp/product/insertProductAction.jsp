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
	String dir = request.getServletContext().getRealPath("/img/productImg");
	int maxFileSize = 1024 * 1024 * 10; // 10Mbyte
	// request 객체를 MultipartRequest의 API를 사용할 수 있도록 랩핑
	MultipartRequest mRequest = new MultipartRequest(request, dir, maxFileSize, "utf-8", new DefaultFileRenamePolicy());
	
	// MultipartRequest API를 사용하여 스트림내에서 문자값을 반환받을 수 있다.
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
		response.sendRedirect(request.getContextPath() + "/product/insertProduct.jsp");
		return;
	}
	// input type="text" 값 반환 API --> board 테이블 저장
	String categoryMainName = mRequest.getParameter("categoryMainName");
	String categorySubName = mRequest.getParameter("categorySubName");
	String productName = mRequest.getParameter("productName");
	int productPrice = Integer.parseInt(mRequest.getParameter("productPrice"));
	int productStock = Integer.parseInt(mRequest.getParameter("productStock"));
	String productSinger = mRequest.getParameter("productSinger");
	String productInfo = mRequest.getParameter("productInfo");
	
	MainDao md = new MainDao();
	// checkCategory 메소드를 통해 categoryNo를 받아서 입력
	int categoryNo = md.checkCategory(categoryMainName, categorySubName);
	
	// product insert 데이터 product class에 입력
	Product product = new Product();
	product.setCategoryNo(categoryNo);
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	product.setProductStock(productStock);
	product.setProductSinger(productSinger);
	product.setProductInfo(productInfo);
	
	// 입력한 product 값을 db에 입력
	int productNo = md.insertProduct(product);
	System.out.println(productNo + " <- productNo");
	
	
	String productFiletype = mRequest.getContentType("productImgFile");
	String productOriginFilename = mRequest.getOriginalFileName("productImgFile");
	String productSaveFilename = mRequest.getFilesystemName("productImgFile");
	
	// productImg insert 데이터 productImg class에 입력
	ProductImg productImg = new ProductImg();
	productImg.setProductOriFilename(productOriginFilename);
	productImg.setProductSaveFilename(productSaveFilename);
	productImg.setProductFiletype(productFiletype);
	
	// 입력한 product 값을 db에 입력
	int checkProductImg = md.insertProductImg(productNo, productImg);
	System.out.println(checkProductImg + " <- checkProductImg");
	
	response.sendRedirect(request.getContextPath() + "/product/productList.jsp");
	return;
%>