<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/member.css" rel="stylesheet" />
</head>
<body>
	<div id="mypage_sidebar">
		<ul>
			<li style="font-size:17px; color:#0F0573;">
				마이페이지
			</li>
			<div id="mypage_hr"></div>
			
			<!-- 글씨 크기 줄이고 hover 넣기(글씨 색 변환, 밑줄 추가) -->
			<li>
				<a href="${contextPath}/mypage/myOrderList.do?member_id=${memberInfo.member_id}">결제 내역 조회</a>
			</li>
			<li>
				<a href="#">쿠폰/적립금 조회</a>
			</li>
			<li>
				<a href="#">이용후기 관리</a>
			</li>
			<li>
				<a href="#">Q&A 관리</a>
			</li>
			<li>
				<a href="#">회원정보 수정</a>
			</li>
		</ul>
	</div>
</body>
</html>