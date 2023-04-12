<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${ pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Perfume</title>
    <!-- CSS 불러오기 -->
    <link rel="stylesheet" href="${ path }/css/planning/main.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.6.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- jQuery 불러오기 -->
    <script src="${ path }/js/jquery-3.6.3.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <!-- 로그인 API 자바스크립트 불러오기 -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
</head>
<body>
    <header>
        <div class="header-container">
            <nav class="main-nav">
                <ul>
                    <li><a href="#">ABOUT US</a></li>
                    <li><a href="#">SPECIAL</a></li>
                    <li><a href="#">SCENT</a></li>
                    <li><a href="#">SACHET</a></li>
                </ul>
            </nav>
            <h1 class="logo"><a href="${ path }/">Perfume</a></h1>
            <nav class="user-nav">
                <ul>
                    <li><a href="#">EVENT</a></li>
                    <li><a href="#">COMMUNITY</a></li>
                    <c:if test="${ empty loginMember }">
	                    <li><a href="#" class="openLogin">LOGIN</a></li>
	                    <li><a href="#">JOIN</a></li>
                    </c:if>
                    <c:if test="${ not empty loginMember }">
						<li><a href="${ path }/logout">LOGOUT</a></li>
						<c:if test="${ not empty loginMember && loginMember.division == '2' }">
							<li><a href="#">MY PAGE</a></li>                                        
						</c:if>
						<c:if test="${ not empty loginMember && loginMember.division == '1' }">
							<li><a href="#">ADMIN PAGE</a></li>                                        
						</c:if>              
                    </c:if>
                </ul>
            </nav>
        </div>

        <!-- 로그인 모달창 구현 -->
        <div class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h2 style="text-align: center;">LOGIN</h2>
                <form id="loginForm" action="${ path }/login" method="POST">
                    <div>
                        <label for="id" style="font-weight: bold;">아이디</label><br>
                        <input type="text" id="id" name="id" required placeholder="아이디를 입력하세요."><br>
                        <label for="pwd" style="font-weight: bold;">비밀번호</label><br>
                        <input type="password" id="pwd" name="pwd" required placeholder="비밀번호를 입력하세요."><br><br>
                        <button type="submit">Login</button><br><br>
                    </div>
                </form>
                    <div>
                        <button type="button" id="findId"><a href="${ path }/planning/findId">아이디 찾기</a></button>
                        <button type="button" id="findPwd"><a href="${ path }/planning/findPwd">비밀번호 찾기</a></button><br><br>
                        <button type="submit">회원가입</button><br><br>
                    </div>
                    <ul style="list-style: none;">
                        <li onclick="naverLogin();"><button type="button" href="javascript:void(0)">네이버로 로그인</button></li>
                        <li onclick="kakaoLogin();"><button type="button" href="javascript:void(0)">카카오로 로그인</button></li>
                        <li onclick="googleLogin();"><button type="button" href="javascript:void(0)">구글로 로그인</button></li>
                        <li onclick="appleLogin();"><button type="button" href="javascript:void(0)">애플로 로그인</button></li>
                    </ul>
            </div>
        </div>
    </header>
    <section class="slider">
	  <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
	    <!-- 인디케이터 -->
	    <ol class="carousel-indicators">
	      <li data-bs-target="#myCarousel" data-bs-slide-to="0" class="active"></li>
	      <li data-bs-target="#myCarousel" data-bs-slide-to="1"></li>
	      <li data-bs-target="#myCarousel" data-bs-slide-to="2"></li>
	    </ol>
	
	    <!-- 슬라이드 이미지 -->
	    <div class="carousel-inner">
	      <div class="carousel-item active">
	        <a href="#">
	          <img src="${ path }/images/planning/slider001.png" class="d-block w-100" alt="Slider Image 1">
	        </a>
	      </div>
	      <div class="carousel-item">
	        <a href="#">
	          <img src="${ path }/images/planning/slider002.png" class="d-block w-100" alt="Slider Image 2">
	        </a>
	      </div>
	      <div class="carousel-item">
	        <a href="#">
	          <img src="${ path }/images/planning/slider003.png" class="d-block w-100" alt="Slider Image 3">
	        </a>
	      </div>
	    </div>
	
	    <!-- 이전, 다음 버튼 -->
	    <button class="carousel-control-prev border-0" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
		  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		  <span class="visually-hidden">이전</span>
		</button>
		<button class="carousel-control-next border-0" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
		  <span class="carousel-control-next-icon" aria-hidden="true"></span>
		  <span class="visually-hidden">다음</span>
		</button>
	  </div>
	</section>

    <section id="main-content">
        <div id="article" class="article1">
            <div>NEW</div>
        </div>
        <div id="banner" class="banner1">
        </div>
        <div id="article" class="article2">
            <div>BRAND</div>
        </div>
        <div id="banner" class="banner2">
        </div>
        <div id="article" class="article3">
            <div>BEST</div>
        </div>
        <div id="banner" class="banner3">
        </div>
    </section>
    <footer>
        <div>
            <nav class="footer-nav">
                <ul>
                    <li><a href="#">GIFT</a>
                        <p>지금 당장 당신의 마음을 보여주세요.</p>
                    </li>
                    <li><a href="#">SAMPLE</a>
                        <p>적당량의 SAMPLE을 소개합니다.</p>    
                    </li>
                    <li><a href="#">시향지 요청</a>
                        <p>원하는 향을 신청해보세요.</p>
                    </li>
                    <li><a href="#">문의하기</a>
                        <p>언제나 고객과 함께하겠습니다.</p>
                    </li>
                </ul>
            </nav>
        </div>
        <pre class="footer-text">
            상호명 <b>PERFUME</b>     대표자 <b>이정수</b>     사업자등록번호 <b>123-45-67890</b>     통신판매업신고번호 <b>제 2023-서울강남-0001호</b><br>
            고객센터 <b>070-1212-3434</b>     주소 <b>06234 서울특별시 강남구 테헤란로 14길 6 (역삼동) 남도빌딩 4층 PERFUME </b><br>
            개인정보보호책임자 <b>공민지(cs@perfume.com)</b><br><br>    
            ※ <b>PERFUME</b>에서 제공하는 모든 콘텐츠는 <b>저작권법에 의하여 보호받는 저작물</b>로서, 모든 권리는 <b>PERFUME</b>에 있습니다.<br>
            본사이트에서 제공되는 콘텐츠를 무단으로 복제 및 배포하는 경우 <b>저작권법에 의하여 처벌</b>받을 수 있습니다.<br><br>
            <b>Copyright ⓒ PERFUME. All rights reserved.</b>
        </pre>
    </footer>

    <script>
    	// 로그인 모달창
        // 모달창 가져오기
        var modal = document.querySelector('.modal');
    
        // 모달창을 열 버튼 가져오기
        var btn = document.querySelector('.openLogin');
    
        // 모달창을 닫는 span 요소 가져오기
        var span = document.querySelector('.close');
    
        // 모달창 버튼 클릭 시 모달창 구현 
        btn.onclick = function() {
            modal.style.display = 'block';
        }
    
        // X버튼 클릭 시 모달창 닫기
        span.onclick = function() {
            modal.style.display = 'none';
        }
    
        // 모달창 바깥 클릭 시 모달창 닫기
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }

        // 카카오로 로그인 구현
        Kakao.init('838aa760211421e8483192e159afd189'); //발급받은 키 중 javascript키를 사용해준다.
        console.log(Kakao.isInitialized()); // sdk초기화여부판단

        function kakaoLogin() {
            Kakao.Auth.login({
            success: function (response) {
                Kakao.API.request({
                url: '/',
                success: function (response) {
                    console.log(response)
                },
                fail: function (error) {
                    console.log(error)
                },
                })
            },
            fail: function (error) {
                console.log(error)
            },
            })
        }

        // 네이버로 로그인 구현
        var naver_id_login = new naver_id_login("e8Ese8BEMBY_9FWnW9xY", "http://localhost:8088/perfume/");
		var state = naver_id_login.getUniqState();
		naver_id_login.setButton("white", 2,40);
		naver_id_login.setDomain("http://localhost:8088");
		naver_id_login.setState(state);
		naver_id_login.setPopup();
		naver_id_login.init_naver_id_login();
        
        // 부트스트랩 캐러샐 슬라이드 구현
        $(document).ready(function(){
		    $('#myCarousel').carousel();
		});
        
        $('.carousel-indicators li').click(function(){
            var goToSlide = $(this).data('slide-to');
            $('#myCarousel').carousel(goToSlide);
        });
        
        // 캐러셀 객체 생성
		$('.carousel').carousel({
			interval: 4000, // 이미지 전환 시간(ms)
		    pause: "hover", // 마우스 호버 시 멈춤 여부
		    wrap: true // 무한 루프 여부
		})
    </script>
</body>
</html>