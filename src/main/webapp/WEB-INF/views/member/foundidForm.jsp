<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<h2 align = center style ="color:#000000">아이디 찾기<br><br></h2>
	<form action="${contextPath}/member/addMember.do" method="post">
	<div id="detail_table" align = center>
    
    <h4>고객님의 정보와 일치하는 아이디 목록입니다.</h4><br>
		<table style="border: 1px solid; width: 450px; height : 200px;"><tbody>
      <tr><td style = "color : #3ADF00;" align = "center">${member_id}</td><tr>
   </tbody> </table>
		</div>
    <br>
		<div class="clear"  align=center>
		<table>
		<tr>
			<td style="text-align: center;">
			<input type="submit" style="height: 30px; width: 100px; background-color:#0F0573; color:white" value="회원가입하기">
			</td>
      <td>&nbsp</td><td>&nbsp</td><td>&nbsp</td><td>&nbsp</td>
			<td style="text-align: center;">
			<a href="${contextPath}/member/searchpwForm.do" style="height: 30px; width: 100px; background-color:#0F0573; color:white">비밀번호 찾기</a>
			</td>
		</tr>
	</table>
	</div>
</form>	
</body>
</html>