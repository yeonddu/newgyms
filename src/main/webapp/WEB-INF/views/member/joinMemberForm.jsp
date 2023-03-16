<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<link href="${contextPath}/resources/css/member.css" rel="stylesheet" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

$(document).ready(function(){
   $("#check_all").click(function(){
   if ($("#check_all").prop("checked")){
       $("#check_all").prop("checked",true);
       $("#check_1").prop("checked",true);
       $("#check_2").prop("checked",true);
       $("#check_3").prop("checked",true);
   } else{
       $("#check_all").prop("checked",false);
       $("#check_1").prop("checked",false);
       $("#check_2").prop("checked",false);
       $("#check_3").prop("checked",false);
   }
   });
});
   
function changeFn(){
   if($("#check_1").prop("checked")){
      $("#check_1").prop("checked",true);
      $("#check_total").prop("checked",false);
   }
   if($("#check_2").prop("checked")){
      $("#check_2").prop("checked",true);
      $("#check_all").prop("checked",false);
   }
   if($("#check_3").prop("checked")){
      $("#check_3").prop("checked",true);
      $("#check_all").prop("checked",false);
   }
}
   
function fn_overlappedId(){
    var _id=$("#member_id").val();
    if(_id==''){
       alert("아이디를 입력하세요");
       return;
    }
    $.ajax({
       type:"post",
       async:false,  
       url:"${contextPath}/member/overlappedId.do",
       dataType:"text",
       data: {id:_id},
       success:function (data,textStatus){
          if(data=='false'){
               alert("사용 가능한 아이디입니다.");
              $('#id_check').text("사용 가능한 아이디입니다. :)");
            $('#id_check').css("color","green");
          } else {
             alert("사용할 수 없는 아이디입니다.");
             $('#id_check').text("사용중인 아이디입니다. ^^;");
              $('#id_check').css("color","red");
          }
       },
       error:function(data,textStatus){
          //alert("에러가 발생했습니다.");ㅣ
       },
       complete:function(data,textStatus){
          //alert("작업을완료 했습니다");
       }
    });  //end ajax    
 }   
 
//아이디 조합 검사 
function idRegexp() {
   let member_id = document.getElementById("member_id").value;
   let id_check = document.getElementById("id_check");
   
   let num = member_id.search(/[0-9]/); // 아이디 중 0부터 9까지 num에 넣음
   let eng = member_id.search(/[a-z]/); // 아이디 중 a부터 z까지 eng에 넣음
   let kor = member_id.search(/[가-힣]/); // 아이디 중 가부터 힣까지 kor에 넣음
   let spe = member_id.search(/[`~!@#$%^&*|\\\'\":;\/?]/);
   // 아이디 중 특수문자를 spe에 넣음

   if (member_id.length < 5 || member_id.length > 20) {
      id_check.style.color = "red";
      id_check.innerHTML="아이디는 5자리에서 20자리 이내로 입력해주세요. ^^"
      return false;
   } 
   if (member_id.search(/\s/) != -1) {
      id_check.style.color = "red";
      id_check.innerHTML="아이디에 공백은 입력할 수 없습니다. :("
      return false;
   } 
   if (kor != -1 || spe != -1) {
      id_check.style.color = "red";
      id_check.innerHTML="한글과 특수문자는 입력할 수 없습니다. :("
      return false;
   } 
   if (eng == -1 || num == -1) {
      id_check.style.color = "red";
      id_check.innerHTML="아이디는 영문자와 숫자로 입력해주세요. :("
      return false;
   } 
   if (eng != -1 && num != -1 && kor == -1 && spe == -1) {
      id_check.style.color = "green";
      id_check.innerHTML="그렇지~~! 잘하셨습니다. ^^"
      return true;
   }
}

// 비밀번호 조합 검사 
function pwRegexp() {
   let member_pw = document.getElementById("member_pw").value;
   let pw_help = document.getElementById("pw_help");
   
   let num = member_pw.search(/[0-9]/); // 비밀번호 중 0부터 9까지 num에 넣음
   let eng = member_pw.search(/[a-z]/); // 비밀번호 중 a부터 z까지 eng에 넣음
   let spe = member_pw.search(/[`~!@#$%^&*|\\\'\":;\/?]/);
   // 비밀번호 중 특수문자를 spe에 넣음
   
   if (member_pw.length < 8 || member_pw.length > 20) {
      pw_help.style.color = "red";
      pw_help.innerHTML="비밀번호는 8자리에서 20자리 이내로 입력해주세요. :("
      return false;
   } else if (member_pw.search(/\s/) != -1) {
      pw_help.style.color = "red";
      pw_help.innerHTML="비밀번호에 공백은 입력할 수 없습니다. :("
      return false;
   } else if (num == -1 || eng == -1 || spe == -1) {
      pw_help.style.color = "red";
      pw_help.innerHTML="특수문자, 영문자, 숫자를 혼합하여 입력해주세요. :("
      return false;
   } else {
      pw_help.style.color = "green";
      pw_help.innerHTML="사용 가능한 비밀번호입니다. :)"
      return true;
   }
}

// 비밀번호와 비밀번호 확인이 동일한지 확인
function pwCheck() {
   let member_pw = document.getElementById("member_pw").value;
   let member_pw_confirm = document.getElementById("member_pw_confirm").value;
   let pw_check = document.getElementById("pw_check");
   
   // 비밀번호와 비밀번호 확인란이 같지 않으면
   if (member_pw != member_pw_confirm) {
      pw_check.style.color = "red";
      pw_check.innerHTML="비밀번호가 다릅니다. :(";
      return false;
   } else {
      pw_check.style.color = "green";
      pw_check.innerHTML="비밀번호가 일치합니다. :)";
      return true;
   }
}

function execDaumPostcode() {
     new daum.Postcode({
       oncomplete: function(data) {
         // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

         // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
         var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
         var extraRoadAddr = ''; // 도로명 조합형 주소 변수

         // 법정동명이 있을 경우 추가한다. (법정리는 제외)
         // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
         if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
           extraRoadAddr += data.bname;
         }
         // 건물명이 있고, 공동주택일 경우 추가한다.
         if(data.buildingName !== '' && data.apartment === 'Y'){
           extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
         }
         // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
         if(extraRoadAddr !== ''){
           extraRoadAddr = ' (' + extraRoadAddr + ')';
         }
         // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
         if(fullRoadAddr !== ''){
           fullRoadAddr += extraRoadAddr;
         }

         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
         document.getElementById('roadAddress').value = fullRoadAddr;
         document.getElementById('jibunAddress').value = data.jibunAddress;

         // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
         if(data.autoRoadAddress) {
           //예상되는 도로명 주소에 조합형 주소를 추가한다.
           var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
           document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
            guideTextBox.style.display = 'none';

         } else if(data.autoJibunAddress) {
             var expJibunAddr = data.autoJibunAddress;
             document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
              guideTextBox.style.display = 'none';
         } else {
             document.getElementById('guide').innerHTML = '';
              guideTextBox.style.display = 'none';
         }
         
        
       }
     }).open();
   }

</script>
</head>
<body>
     <div id="contain" align=center>
   <h2 id="join_title" align="center">개인 회원가입</h2>
   <form action="${contextPath}/member/joinMember.do?member_name=${member_name}" method="post">   
   <table id="join_table2">   
      <!-- 이름 -->
      <tr>
         <td>
            <p class="inline" class="join_textbox">이름</p>
         </td>
         <td>
            <input name="member_name" class="join_inputbox" type="text" value="${member_name}" size="25" maxlength="10" disabled/>
         </td>
      </tr>

      <!-- 아이디 -->
      <tr>
         <td>   
            <p class="inline" class="join_textbox">아이디 <span id="red_color">*</span></p>
         </td>
         <td>
            <input name="member_id" id="member_id" class="join_inputbox" type="text" size="25" maxlength="20" 
            pattern="[a-z0-9]{6,20}" required title="아이디는 영문자(소문자)와 숫자로 이루어진 6~20 자리를 입력해주세요." onkeyup="idRegexp()" placeholder="영문, 숫자 혼합 5자리 이상" >
         </td>
         <td>
            <input type="button" class="btn" id="btnOverlappedId" value="중복확인" onClick="fn_overlappedId()" />
         </td>
      </tr>
      <tr>
         <td colspan="3">
            <span id="id_check"></span>
         </td>
      </tr>
      
      <!-- 비밀번호 -->
      <tr>
         <td>   
            <p class="inline" class="join_textbox">비밀번호 <span id="red_color">*</span></p>
         </td>
         <td>
            <input name="member_pw" id="member_pw" class="join_inputbox" type="password" size="25" maxlength="20" onkeyup="pwRegexp()" placeholder="영문, 숫자, 특수문자 혼합 8자리 이상" required />
         </td>
      </tr>
      <tr>
         <td colspan="3">
            <span id="pw_help"></span>
         </td>
      </tr>
      
      <!-- 비밀번호 확인 -->
      <tr>
         <td>   
            <p class="inline" class="join_textbox">비밀번호 확인 <span id="red_color">*</span></p>
         </td>
         <td>
            <input name="member_pw_confirm" id="member_pw_confirm" class="join_inputbox" type="password" size="25" maxlength="20" onkeyup="pwCheck()" required />
         </td>
      </tr>
      <tr>
         <td colspan="3">
            <span id="pw_check"></span>
         </td>
      </tr>
      
      <!-- 주소 -->
      <tr>
         <td>   
            <p class="inline" class="join_textbox">주소 <span id="red_color">*</span></p>
         </td>
         <td>
            <input type="text" class="join_inputbox" required id="zipcode" name="zipcode" size="12" readonly >
            &nbsp;&nbsp;<a href="javascript:execDaumPostcode()" class="btn" >우편번호</a>
         </td>
      </tr>
      
      <!-- 도로명 OR 지번 주소 -->
      <tr>
         <td>
            <p class="inline" class="join_textbox"></p>
         </td>
         <td>
            <input name="road_address" id="roadAddress" class="join_inputbox" type="text" size="25" required>
            <input name="jibun_address" id="jibunAddress" class="join_inputbox" type="hidden" size="25" required>
         </td>
      </tr>      
      
      <!-- 나머지 주소 -->
      <tr>
         <td>
            <p class="inline" class="join_textbox"></p>
         </td>
         <td>
            <input name="namuji_address" id="namujiAddress" class="join_inputbox" type="text" size="25" required>
         </td>
      </tr>
      
      <!-- 휴대폰번호 -->
      <tr>
         <td>   
            <p class="inline" class="join_textbox">휴대폰번호 <span id="red_color">*</span></p>
         </td>
         <td>
            <select name="hp1" class="join_inputbox" required> 
               <option selected>010</option>
               <option>011</option>
               <option>017</option>
               <option>019</option>
            </select> -
            &nbsp;<input name="hp2" class="join_inputbox" type="text" size="6" maxlength="4" pattern="[0-9]{4}" required title="중간번호 4자리를 숫자로 입력해주세요." /> -
            &nbsp;<input name="hp3" class="join_inputbox" type="text" size="6" maxlength="4" pattern="[0-9]{4}" required title="뒷번호 4자리를 숫자로 입력해주세요." />         
         </td>
         <td> <!-- SMS 수신 동의 -->
            <input type="checkbox" name="smssts_yn" value="Y" checked /><span id="join_subtext"> SMS 수신 동의</span>
         </td>
      </tr>
      
      <!-- 이메일 -->
      <tr>
         <td>   
            <p class="inline" class="join_textbox">이메일 <span id="red_color">*</span></p>
         </td>
         <td>
            <input name="email1" class="join_inputbox" type="text" size="9" pattern="[a-z0-9]{3,20}" required title="이메일 주소를 입력해주세요."> @
            <select name="email2" class="join_inputbox" required>
               <option selected> </option>
               <option>naver.com</option>
               <option>gmail.com</option>
               <option>kakao.com</option>
               <option>hanmail.net</option>
               <option>nate.com</option>
            </select>
         </td>
         <td>
            <input type="checkbox" name="emailsts_yn" value="Y" checked /><span id="join_subtext"> 이메일 수신 동의</span>
         </td>
      </tr>
      
      <!-- 성별 -->
      <tr>
         <td>   
            <p class="inline" class="join_textbox">성별</p>
         </td>
         <td>
            <input type="radio" name="member_gender" value="M" checked /> 남자
            <input type="radio" name="member_gender" value="W" /> 여자
         </td>
      </tr>
      
      <!-- 주민등록번호 & 회원유형 -->
      <tr>
         <td>
            <input name="member_rrn1" type="hidden" value="${member_rrn1}" size="10" maxlength="6" />
            <input name="member_rrn2" type="hidden" value="${member_rrn2}" size="10" maxlength="7" />
            <input name="join_type" type="hidden" value="${join_type}" size="10" maxlength="3" />
         </td>
      </tr>
   </table>
   
   
   
   <table id="join_agree">   
      <!-- 이용약관동의 -->
      <tr>
         <td colspan="4">   
            <p class="inline" class="join_textbox">이용약관동의 <span id="red_color">*</span></p>
         </td>
           <td>
              <div class="checkbox_group">
                 <input type="checkbox" id="check_all">
                 <label for="check_all">전체 동의합니다.</label>
                 <br>
                 <input type="checkbox" id="check_1" class="normal" onclick="changeFn();" required>
                 <label for="check_1">이용약관동의(필수)</label>
                 <br>
                 <input type="checkbox" id="check_2" class="normal" onclick="changeFn();" required>
                 <label for="check_2">개인정보 수집/이용 동의(필수)</label>
                 <br>
                 <input type="checkbox" id="check_3" class="normal" onclick="changeFn();">
                 <label for="check_3">위치기반서비스 이용약관 동의(선택)</label>
              </div>
           </td>
           <td>
              <br>
               <a href="" style ="color:blue">약관보기></a><br>
              <a href="" style ="color:blue">약관보기></a><br>
               <a href="" style ="color:blue">약관보기></a>
           </td>
        </tr>
   </table>
    
         <input type="submit" value="가입하기" id="join_btn" align="center">
      </form>
      </div>
</body>
</html>