<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="hero-section">
		<!-- 배너 1번 -->
        <div class="hero-items owl-carousel">
            <div class="single-hero-items set-bg" data-setbg="<%=request.getContextPath() %>/template/img/rewind.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                            <span>이세계 아이돌 1집</span>
                            <h1>Re : Wind</h1>
                            <p>이세계 아이돌 첫 데뷔, 공식 1집 앨범</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 배너 2번 -->
            <div class="single-hero-items set-bg" data-setbg="<%=request.getContextPath() %>/template/img/winter.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                            <span>이세계 아이돌 2집</span>
                            <h1>겨울봄</h1>
                            <p>이세계 아이돌 공식 2집 앨범</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 배너 3번 -->
            <div class="single-hero-items set-bg" data-setbg="<%=request.getContextPath() %>/template/img/idolbanner.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                            <span>요아소비</span>
                            <h1>IDOL</h1>
                            <p>최애의 아이 OP</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>