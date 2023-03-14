<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<link href="${contextPath}/resources/css/join.css" rel="stylesheet" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
let idChecked="false";
let pwChecked="false";
function fn_overlappedId(){
    var _id=$("#member_id").val();
    if(_id==''){
   	 alert("ID를 입력하세요");
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
       	  	alert("사용할 수 있는 ID입니다.");
       	 	$('#id_check').text("사용가능한 아이디입니다. :)");
    	  	$('#id_check').css("color","green");
    	  	idChecked="true";
          } else {
        	  alert("사용할 수 없는 ID입니다.");
        	  $('#id_check').text("사용중인 아이디입니다. ^^;;");
         	  $('#id_check').css("color","red");
         	  idChecked="false";
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
function pwCheck() {
	let member_pw = document.getElementById("member_pw").value;
	let member_pw_confirm = document.getElementById("member_pw_confirm").value;
	let pwResult2 = document.getElementById("pwResult2");
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
				<input name="member_name" class="join_inputbox" type="text" value="${member_name}" size="23" maxlength="10" disabled/>
			</td>
		</tr>

		<!-- 아이디 -->
		<tr>
			<td>	
				<p class="inline" class="join_textbox">아이디 <span id="red_color">*</span></p>
			</td>
			<td>
				<!-- <input name="_member_id" class="join_inputbox" type="text" id="_member_id" size="23" maxlength="20" /> -->
				<input name="member_id" id="member_id" class="join_inputbox" type="text" size="23" maxlength="20" />
				<br>
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
				<input name="member_pw" id="member_pw" class="join_inputbox" type="password" size="23" maxlength="20" />
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
				<input name="member_pw_confirm" id="member_pw_confirm" class="join_inputbox" type="password" size="23" maxlength="20" />
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
				<input type="text" class="join_inputbox" id="zipcode" name="zipcode" size="12" >
				&nbsp;&nbsp;<a href="javascript:execDaumPostcode()">우편번호</a>
			</td>
		</tr>
		
		<!-- 도로명 OR 지번 주소 -->
		<tr>
			<td>
				<p class="inline" class="join_textbox"></p>
			</td>
			<td>
				<input name="road_address" id="roadAddress" class="join_inputbox" type="text" size="23"/>
				<input name="jibun_address" id="jibunAddress" class="join_inputbox" type="hidden" size="23"/>
			</td>
		</tr>		
		
		<!-- 나머지 주소 -->
		<tr>
			<td>
				<p class="inline" class="join_textbox"></p>
			</td>
			<td>
				<input name="namuji_address" class="join_inputbox" type="text" size="23"/>
			</td>
		</tr>
		
		<!-- 휴대폰번호 -->
		<tr>
			<td>	
				<p class="inline" class="join_textbox">휴대폰번호 <span id="red_color">*</span></p>
			</td>
			<td>
				<select name="hp1" class="join_inputbox"> 
					<option selected>010</option>
					<option>011</option>
					<option>017</option>
					<option>019</option>
				</select> -
				<input name="hp2" class="join_inputbox" type="text" size="5" maxlength="4" /> -
				<input name="hp3" class="join_inputbox" type="text" size="5" maxlength="4" />			
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
				<input name="email1" class="join_inputbox" type="text" size="7" /> @
				<select name="email2" class="join_inputbox">
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
        		<input type="checkbox" name="all_check" />전체 동의합니다.<br>
        		<input type="checkbox" name="one_check" />이용약관동의(필수)<br>
		        <input type="checkbox" name="two_check" />개인정보 수집.이용 동의(필수)<br>
        		<input type="checkbox" name="three_check" />위치기반서비스 이용약관 동의(선택)
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