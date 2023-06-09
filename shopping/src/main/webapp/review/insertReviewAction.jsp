<%@page import="vo.product.ReviewImg"%>
<%@page import="vo.product.Review"%>
<%@page import="dao.main.ReviewDao"%>
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
	String dir = request.getServletContext().getRealPath("/img/reviewImg");
	int maxFileSize = 1024 * 1024 * 10; // 10Mbyte
	// request 객체를 MultipartRequest의 API를 사용할 수 있도록 랩핑
	MultipartRequest mRequest = new MultipartRequest(request, dir, maxFileSize, "utf-8", new DefaultFileRenamePolicy());
	
	/* if (mRequest.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	} */
	ArrayList<String> checkReviewImgList = new ArrayList<>();
	int maxImgCnt = 3;
	for (int i = 1; i <= maxImgCnt; i++){
		String reviewImgFile = "reviewImgFile" + i;
		// System.out.println(reviewImgFile);
		String reviewImg = mRequest.getContentType(reviewImgFile);
		// System.out.println(mRequest.getContentType(reviewImgFile));
		// System.out.println(reviewImg);
		if (reviewImg != null){
			checkReviewImgList.add(reviewImg);
		}
	}
	// System.out.println(reviewImgList.size());
	// MultipartRequest API를 사용하여 스트림내에서 문자값을 반환받을 수 있다.
	// 업로드 파일이 jpg 파일이 아니면
	for (String s : checkReviewImgList){
		if (s.equals("image/jpeg") == false
				&& s.equals("image/jpg") == false){
			// 이미 저장된 파일을 삭제
			System.out.println("jpg파일이 아닙니다.");
			String saveFilename = mRequest.getFilesystemName("reviewImgFile");
			File f = new File(dir + "\\" + saveFilename);
			if(f.exists()){
				f.delete();
			System.out.println(dir + "\\" + saveFilename + "파일삭제");
			}
			response.sendRedirect(request.getContextPath() + "/review/insertReview.jsp");
			return;
		}
	}
	
	// input type="text" 값 반환 API --> board 테이블 저장
	// String id = (String)session.getAttribute("loginId");
	String id = "aa";
	String reviewTitle = mRequest.getParameter("reviewTitle");
	String reviewContent = mRequest.getParameter("reviewContent");
	int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
	
	ReviewDao rd = new ReviewDao();
	// review insert 데이터 review class에 입력
	Review review = new Review();
	review.setId(id);
	review.setProductNo(productNo);
	review.setReviewTitle(reviewTitle);
	review.setReviewContent(reviewContent);
	
	// 입력한 review 값을 db에 입력, reviewNo 가져오기
	int reviewNo = rd.insertReview(review);
	
	// reviewImg insert 데이터 reviewImg class에 입력
	for (int i = 1; i <= maxImgCnt; i++){
		ReviewImg reviewImg = new ReviewImg();
		String reviewImgFile = "reviewImgFile" + i;
		String reviewFiletype = mRequest.getContentType(reviewImgFile);
		String reviewOriginFilename = mRequest.getOriginalFileName(reviewImgFile);
		String reviewSaveFilename = mRequest.getFilesystemName(reviewImgFile);
		reviewImg.setReviewFiletype(reviewFiletype);
		reviewImg.setReviewOriFilename(reviewOriginFilename);
		reviewImg.setReviewSaveFilename(reviewSaveFilename);
		if (reviewFiletype != null){
			// 입력한 reviewImg 값을 db에 입력
			int row = rd.insertreviewImg(reviewNo, reviewImg);
			System.out.printf("%s의 imgfile 입력 성공 유무 %d %n", reviewImgFile, row);
		}
	}
	
	response.sendRedirect(request.getContextPath() + "/review/review.jsp?reviewNo=" + reviewNo);
%>