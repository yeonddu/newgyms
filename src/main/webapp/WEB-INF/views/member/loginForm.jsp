<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<script src="https://developers.kakao.com/sdk/js/kakao.js" charset="utf-8"></script>
<script type="text/javascript">
	Kakao.init("b72869301ce448407f587e4c23f08553");
	Kakao.isInitialized();
	
	function kakaoLogin() {
		Kakao.Auth.authorize({
			redirectUri: 'http://localhost:8080/newgyms/member/kakaoLogin.do',
		});
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<div id="loginForm">
<h1>Login</h1>

<div class="member_input">
	<input id="member_id" name="member_id" type="text" placeholder="ID">
</div>

<div class="member_input">
	<input id="member_pw" name="member_pw" type="password" placeholder="Password">
</div>

<div class="member_find">
       <a href="${contextPath}/member/searchIdForm.do">아이디 찾기</a> 
       <a href="${contextPath}/member/searchPwForm.do">비밀번호 찾기</a> 
       
</div>

<ul>
	<li>
		<a class="login_button" href="#">로그인</a>
	</li>
	<li>
		<a class="join_button" href="${contextPath}/member/joinCheck.do">회원가입</a>
	</li>
</ul>


		<div style="width:200px; heigh:40px;">
        	<a id="kakao_join" href="javascript:kakaoLogin();">
       			<img src="https://developers.kakao.com/tool/resource/static/img/button/login/full/ko/kakao_login_medium_wide.png" alt="카카오 로그인" >
        	</a>
      	</div>      
</div>


<!-- 
	<p id="join_title" align="center">로그인</p>
	<form action="${contextPath}/member/login.do" method="post" onsubmit="valid();">
      <div align = center>
	<table id="login_table">	
		<tr>
			<td>
				<input id="member_id" name="member_id" class="login_inputbox" type="text" size="26" maxlength="20" placeholder="아이디" required />
			</td>
		</tr>

		<tr>
			<td>
				<input id="member_pw" name="member_pw" class="login_inputbox" type="password" size="26" maxlength="20" placeholder="비밀번호" required />
			</td>
		</tr>
	</table>
      <br>
      <input type="submit" value="로그인" id="join_btn" align="center"> <br><br>
		<div style="width:300px; heigh:40px;">
        	<a id="kakao_join" href="javascript:kakaoLogin();">
       			<img src="https://developers.kakao.com/tool/resource/static/img/button/login/full/ko/kakao_login_medium_wide.png" alt="카카오 로그인" >
        	</a>
      	</div>      
    	<br>
       <a href="${contextPath}/member/searchIdForm.do">아이디 찾기</a> 
       <a href="${contextPath}/member/searchPwForm.do">비밀번호 찾기</a> 
       <a href="${contextPath}/member/joinCheck.do">회원가입</a>
    
    </div></form>    
 -->
</body>
</html>