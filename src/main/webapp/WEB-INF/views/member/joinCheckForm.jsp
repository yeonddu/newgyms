<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<link href="${contextPath}/resources/css/member.css" rel="stylesheet" />
<script>
	// 회원가입(check) 유효성 검사
	function join_valid() {
		const mem_name = document.querySelector('#member_name');
		const mem_rrn1 = document.querySelector('#member_rrn1');
		const mem_rrn2 = document.querySelector('#member_rrn2');
		colsole.log("mem_name");
		colsole.log(mem_name);
		const regName = /^[가-힣]{2,10}$/; // 이름 규칙
		let checkAll = true; // 유효성 검사 결과
		if (!regName.test(mem_name.value)) {
			alert("이름은 한글 2~10자 이내로 작성해주세요.");
			mem_name.focus();
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
	
	<!-- 카카오 회원가입 -->
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
</head>
<body>
	<div id="contain" align=center>
	<p id="join_title" align="center">회원가입</p>
	<form action="${contextPath}/member/joinCheck.do" method="post" onsubmit="return join_valid()">	
	<table id="join_table">	
		<!-- 회원구분 -->
		<tr>
			<td>
				<p class="inline" class="join_textbox">회원구분 <span id="red_color">*</span></p>
			</td>
			<td>
				<input type="radio" name="join_type" value="101" checked />
					개인회원<span style="padding-left:5px"></span>
				<input type="radio" name="join_type" value="102" />
					사업자회원<span style="padding-left:5px"></span>
			</td>
		</tr>

		<!-- 이름 -->
		<tr>
			<td>
				<p class="inline" class="join_textbox">이름 <span id="red_color">*</span></p>
			</td>
			<td>
				<input name="member_name" class="join_inputbox" type="text" size="19" maxlength="10" />
			</td>
		</tr>

		<!-- 주민등록번호 -->
		<tr>
			<td>	
				<p class="inline" class="join_textbox">주민등록번호 <span id="red_color">*</span></p>
			</td>
			<td>
				<input name="member_rrn1" class="join_inputbox" type="text" size="8" maxlength="6" />
				<span> - </span>
				<input name="member_rrn2" class="join_inputbox" type="password" size="8" maxlength="7" />
			</td>
		</tr>
	</table>
			<input type="submit" value="회원가입" id="join_btn" align="center">
			<br><br>
			<a href="javascript:kakaoLogin();">
				<img src="https://developers.kakao.com/tool/resource/static/img/button/kakaosync/complete/ko/kakao_login_medium_wide.png" 
				alt="카카오 1초 회원가입" id="kakao_join">
			</a>
	</form>	
	</div>
</body>
</html>

