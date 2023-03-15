<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<link href="${contextPath}/resources/css/member.css" rel="stylesheet" />
<script src="https://developers.kakao.com/sdk/js/kakao.js" charset="utf-8"></script>
<script type="text/javascript">
	Kakao.init("b72869301ce448407f587e4c23f08553");
	Kakao.isInitialized();
	
	function kakaoLogin() {
		Kakao.Auth.authorize({
			redirectUri: 'http://localhost:8080/newgyms/member/kakaoLogin.do',
		});
	}

	// 회원가입(check) 유효성 검사
	function join_valid() {
		const mem_id = document.querySelector('#member_id');
		const mem_pw = document.querySelector('#member_pw');
		colsole.log("mem_id");
		colsole.log(mem_id);
		let checkAll = true; // 유효성 검사 결과
		if (mem_id == '') {
			alert("아이디를 입력해주세요.");
			mem_id.focus();
			checkAll = false;
		}
		if (!checkAll) {
			return false;
		}
		
		if (mem_name == '' && mem_rrn1 == '' && mem_rrn2 == '') {
			return false;
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
	<p id="join_title" align="center">로그인</p>
	<form action="${contextPath}/member/login.do" method="post" onsubmit="return join_valid()">
      <div align = center>
	<table id="login_table">	
		<!-- 아이디 -->
		<tr>
			<td>
				<input id="member_id" name="member_id" class="login_inputbox" type="text" size="26" maxlength="20" placeholder="아이디" />
			</td>
		</tr>

		<!-- 비밀번호 -->
		<tr>
			<td>
				<input id="member_pw" name="member_pw" class="login_inputbox" type="password" size="26" maxlength="20" placeholder="비밀번호" />
			</td>
		</tr>
	</table>
      <br>
      <input type="submit" value="로그인" id="join_btn" align="center"> <br><br>
		<a href="javascript:kakaoLogin();">
			<img src="https://developers.kakao.com/tool/resource/static/img/button/login/full/ko/kakao_login_medium_wide.png"
			 alt="카카오 로그인" id="kakao_join">
		</a>      
    	<br>
       <a href="${contextPath}/member/searchidForm.do">아이디 찾기</a> |
       <a href="${contextPath}/member/searchpwForm.do">비밀번호 찾기</a> |
       <a href="${contextPath}/member/joinCheck.do">회원가입</a>
    
    </div></form>      
</body>
</html>