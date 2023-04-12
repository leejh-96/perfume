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
    <title>비밀번호 찾기</title>
</head>
<body>
	<h2>비밀번호 찾기</h2>
	<h3>등록한 회원정보 또는 본인인증으로 비밀번호를 찾을 수 있습니다.</h3>
	<form action="#" name="findPwdInfo" id="findPwdInfo" method="POST">
		<h4>등록된 회원정보로 찾기</h4>
		<p>회원 가입 시 등록한 정보를 정확히 입력해주세요.</p>
		<!-- 아이디 -->
		<p>
			<label for="userId">
				<input type="text" placeholder="아이디" name="userId" id="userId" required>
			</label>
		</p>
		<!-- 이름 -->
		<p>
			<label for="userName">
				<input type="text" placeholder="이름" name="userName" id="userName" required>
			</label>
		</p>
		<!-- 이메일 -->
		<p>
			<label for="userEmail">
				<input type="email" placeholder="이메일" name="userEmail" id="userEmail" required>
			</label>
		</p>
		<!-- 비밀번호 찾기 -->
		<p>
			<button type="submit">비밀번호 찾기</button>
		</p>
	</form>
	<form action="#" name="findPwdCert" id="findPwdCert" method="POST">
		<h4>본인인증 수단으로 찾기</h4>
		<p>아이디 확인 후 본인인증을 선택해주세요.</p>
		<!-- 아이디 -->
		<p>
			<label for="userId2">
				<input type="text" placeholder="아이디" name="userId" id="userId2" required>
			</label>
			<button type="submit">확인</button>
		</p>
		<!-- 인증수단 -->
		<div class="cert">
			<a href="#">휴대폰 인증</a>
		</div>
		<!-- 	비밀번호 찾기-->
		<p>
			<button type="submit">비밀번호 찾기</button>
		</p>	
	</form>
	<p>위 방법으로 비밀번호를 찾을수 없는 경우 <a href="#">고객센터</a>에 문의해주세요.</p>
</body>
</html>