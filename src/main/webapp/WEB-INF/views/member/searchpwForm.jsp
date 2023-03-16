<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<link href="${contextPath}/resources/css/member.css" rel="stylesheet" />
<c:if test='${not empty message }'>
<script>
window.onload=function() {
  result();
}
function result(){
   alert("어~~~안해주면 그만이야~~~");
}
</script>
</c:if>
<script>
function submit2(frm) {
    frm.action= 'sendEmailpw.do';
    frm.submit();
    return true;
}
</script>
</head>
<body>
<div id="contain" align=center>
	<p id="join_title" align="center">비밀번호 찾기</p>
  	<form action="${contextPath}/member/searchpw.do" method="post"> 
  	<input type="hidden" value="${ran}" name = "ran">
	<table id="search_table">
	
		<!-- 아이디 -->
        <tr>
        	<td>
        	   	<p class="inline" class="join_textbox">아이디 <span id="red_color">*</span></p>
            </td>
            <td>
            	<input name="member_id" type="text" size="24" id="member_id" class="join_inputbox">
            </td>
        </tr>

		<!-- 이름 -->
        <tr>
        	<td>
        	   	<p class="inline" class="join_textbox">이름 <span id="red_color">*</span></p>
            </td>
            <td>
            	<input name="member_name" type="text" size="24" id="member_name" class="join_inputbox">
            </td>
        </tr>
        
        <!-- 이메일 -->
        <tr>
        	<td>
          		<p class="inline" class="join_textbox">이메일 <span id="red_color">*</span></p>
          	</td>
          	<td>
          		<input size="8" type="text" name="email1" id="email1" class="join_inputbox"> @ 
                <select name="email2" id="email2" class="join_inputbox">
                    <option value="naver.com" selected>naver.com</option>
                    <option value="hanmail.net">hanmail.net</option>
                	<option value="yahoo.co.kr">yahoo.co.kr</option>
               		<option value="hotmail.com">hotmail.com</option>
                	<option value="paran.com">paran.com</option>
                	<option value="nate.com">nate.com</option>
                	<option value="google.com">google.com</option>
                  	<option value="gmail.com">gmail.com</option>
                	<option value="empal.com">empal.com</option>
                	<option value="korea.com">korea.com</option>
                	<option value="freechal.com">freechal.com</option>
                </select>
          	</td>
          	<td>
          	    <input type="button" class="btn2" value="인증번호 받기" onClick="return submit2(this.form);">
          	</td>
        </tr>
        
        <!-- 인증번호 -->
         <tr>
         	<td>
          		<p class="inline" class="join_textbox">인증번호 <span id="red_color">*</span></p>
          	</td>
           	<td colspan="2">
           		<input type="text" size="24" name="ok" id="ok" class="join_inputbox" maxlength="6" placeholder="인증번호 숫자 6자리 입력" >
            </td>
         </tr> 
     </table>
            <input type="submit" id="join_btn" value="다음">
	</form>
</div>
</body>
</html>