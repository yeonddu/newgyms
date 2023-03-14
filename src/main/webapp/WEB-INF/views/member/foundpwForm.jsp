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
	<h2 align = center style ="color:#000000">비밀번호 찾기<br><br></h2>
	<form action="${contextPath}/member/newpw.do" method="post">	
	<input type = "hidden" name = "member_id" value = "${member_id}">
	<div id="detail_table"  align = center>
    
    <h4>고객님 계정의 비밀번호를 재설정합니다.</h4><br><br>
		<table style="border: 1px solid #D8D8D8; width: 450px; height : 150px;"><tbody>
      <tr align = "center" >
        <td colspan = "3" style = "color:#D8D8D8">새로운 비밀번호를 입력해주세요.</td>
        <td></td>
      </tr>
      <tr align = "center">
        <td width ="60px"></td>
        <td class="fixed_join" align = "left">비밀번호</td>
				<td><input name ="member_pw" type="text" style = "width : 200px; height : 30px;"/></td>
      </tr>
      <tr align = "center">
        <td width = "60px"></td>
        <td class="fixed_join" align = "left">비밀번호 확인</td>
				<td><input name ="new_pw" type="text" style = "width : 200px; height : 30px;" /></td>
      </tr>
   </tbody></table>
		</div>
    <br>
		<div class="clear"  align=center>
		<table>
		<tr>
			<td style="text-align: center;">
				<input type="submit" style="height: 30px; width: 100px; background-color:#0F0573; border-radius: 8px; color:white;" value="완료">
			</td>
		</tr>
	</table>
	</div>
</form>	
</body>
</html>