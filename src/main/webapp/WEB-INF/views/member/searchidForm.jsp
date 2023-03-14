<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script>
function checkOnlyOne(element) {
	  const checkboxes = document.getElementsByName("checkonly");
	  checkboxes.forEach((cb) => {
	    cb.checked = false;
	  })
	  element.checked = true;
	}
  
      function checkOnlyTwo(checkbox) {
    	  const member_name = document.getElementById("member_name");
    	  member_name.disabled = false;
      		const hp1 = document.getElementById("hp1");
      		hp1.disabled = false;
      		const hp2 = document.getElementById("hp2");
      		hp2.disabled = false;
      		const hp3 = document.getElementById("hp3");
      		hp3.disabled = false;
      		const ok = document.getElementById("ok");
      		ok.disabled = false;
      
      		const member_name1 = document.getElementById("member_name1");
      		member_name1.disabled = true;
        		const email1 = document.getElementById("email1");
        		email1.disabled = true;
        		const email2 = document.getElementById("email2");
        		email2.disabled = true;
        		const email3 = document.getElementById("email3");
        		email3.disabled = true;
        		const ok1 = document.getElementById("ok1");
        		ok1.disabled = true;
}
     
    function checkOnlyThree(checkbox) {
    	const member_name1 = document.getElementById("member_name1");
    	member_name1.disabled = false;
      		const email1 = document.getElementById("email1");
      		email1.disabled = false;
      		const email2 = document.getElementById("email2");
      		email2.disabled = false;
      		const email3 = document.getElementById("email3");
      		email3.disabled = false;
      		const ok1 = document.getElementById("ok1");
      		ok1.disabled = false;
      
      const member_name = document.getElementById("member_name");
      member_name.disabled = true;
		const hp1 = document.getElementById("hp1");
		hp1.disabled = true;
		const hp2 = document.getElementById("hp2");
		hp2.disabled = true;
		const hp3 = document.getElementById("hp3");
		hp3.disabled = true;
		const ok = document.getElementById("ok");
		ok.disabled = true;
}

    
  </script>

</head>
<body>
   <h2 align = center style ="color:#000000">아이디 찾기<br><br></h2>
  <form action="${contextPath}/member/searchid.do" method="post">	
   <div id="detail_table"  align = center>
    
      <table style = "border-spacing: 0 10px;">
         <tbody>
          <td colspan = "2"><input type ="checkbox" name = "checkonly" onClick='checkOnlyOne(this); checkOnlyTwo(this);'>회원 정보에 등록된 휴대전화로 인증</td>
            <tr>
               <td class="fixed_join">이름</td>
               <td><input name="member_name" type="text" size="21" height ="30" id = "member_name" disabled/></td>
          <td></td>
            </tr><tr>
          <td class="fixed_join">휴대폰번호</td>
               <td><select name="hp1" id = "hp1" disabled>
                     <option selected value=" "></option>
                     <option value="010">010</option>
                     <option value="011">011</option>
                     <option value="016">016</option>
                     <option value="017">017</option>
                     <option value="018">018</option>
                     <option value="019">019</option>
               </select>
          <input size="6px" type="text" name="hp2" id = "hp2" disabled>&nbsp;  <input size="6px"  type="text" name="hp3" id = "hp3" disabled>
          </td>
          <td width = "20px"></td>
          <td style="text-align: center;">
            <input type="button" style="height: 20px; width: 110px; height :25px; background-color:#0F0573; color:white; border-radius: 8px;" value="인증번호 받기">
         </td>
            </tr>
        <tr>
        <td></td>
           <td><input type="text" size="21" name = "ok" id = "ok" placeholder="인증번호 6자리 숫자 입력" disabled/></td>
        </tr> 
       
        <tr><th> &nbsp;</th></tr>
        <tr><td colspan = "4"><hr></td></tr>
        <tr><th> &nbsp;</th></tr>
        
        
        <td colspan = "2"><input type ="checkbox" name = "checkonly" onClick='checkOnlyOne(this); checkOnlyThree(this);'>본인 확인 이메일로 인증</td>
            <tr>
               <td class="fixed_join">이름</td>
               <td><input name="member_name" type="text" size="21" id = "member_name1" disabled/></td>
            </tr>
            <tr class="dot_line">
               <td class="fixed_join">이메일<br></td>
                <td><input size="10px"   type="text" name="email1" id = "email1" disabled/> @ <input  size="10px"  type="text"name="email2" id = "email2" disabled/> 
						  <select name="email3" id = "email3" onChange=""	title="직접입력" disabled>
									<option value="non">직접입력</option>
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
							</select></td>
               <td width = "20px"></td>
          <td style="text-align: center;">
               <input type="submit" style="height: 20px; width: 110px; height :25px; background-color:#0F0573; color:white; border-radius: 8px;" value="인증번호 받기"/>
         </td>   
            </tr>
        <tr>
        <td></td>
           <td><input type="text" size="21" placeholder="인증번호 6자리 숫자 입력" name = "ok" id = "ok1" disabled/></td>
        </tr> 
   </tbody></table>
      </div>
      <div class="clear"align=center>
      <br>
      <table>
      <tr>
         <td style="text-align: center;">
            <input type="submit" id ="next" style = "height: 35px; width: 400px; background-color:#0F0573; color:white;" value="다음">
         </td>
      </tr>
   </table>
   </div>
</form>   
</body>
</html>