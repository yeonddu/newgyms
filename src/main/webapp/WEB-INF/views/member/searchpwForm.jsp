<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
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
</head>
<body>
   <h2 align = center style ="color:#000000">비밀번호 찾기<br><br></h2>
   <form action="${contextPath}/member/searchpw.do" method="post">
   <div id="detail_table"  align = center>
    
      <table style = "border-spacing : 0 10px">
         <tbody>
            <tr>
               <td class="fixed_join">아이디</td>
               <td><input name="member_id" type="text" size="21" height ="30" /></td>
          <td></td>
            </tr>
            <tr>
               <td class="fixed_join">이름</td>
               <td><input name="member_name" type="text" size="21" height ="30" /></td>
          <td></td>
            </tr>
        
            <tr>
          <td class="fixed_join">이메일</td>
          <td><input size="10px"   type="text" name="email1" /> @
                    <select name="email2" onChange="">
                           <option selected> </option>
                           <option value="hanmail.net">hanmail.net</option>
                           <option value="naver.com">naver.com</option>
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
          <td width = "20px"></td>
          <td style="text-align: center;" >
            <input type="submit" style="height: 25px; width: 100px; background-color:#0F0573; color:white" value="인증번호 받기">
         </td>
            </tr>
        <tr>
        <td></td>
           <td><input name="member_name" type="text" size="21" placeholder="인증번호 6자리 숫자 입력"/></td>
        </tr> 
       
   </tbody> </table>
      </div>
      <div class="clear"  align=center>
      <br><br>
      <table>
      <tr>
         <td style="text-align: center;">
            <input type="submit" style = "height: 35px; width: 400px; background-color:#0F0573; color:white;" value="다음">
         </td>
      </tr>
   </table>
   </div>
</form>   
</body>
</html>