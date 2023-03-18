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
<script>
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
		id_check.innerHTML="아이디는 4자리-16자리 이내로 입력해주세요 :("
		return false;
	} 
	if (member_id.search(/\s/) != -1) {
		id_check.style.color = "red";
		id_check.innerHTML="아이디에 공백은 입력할 수 없습니다 :("
		return false;
	} 
	if (kor != -1 || spe != -1) {
		id_check.style.color = "red";
		id_check.innerHTML="한글과 특수문자는 입력할 수 없습니다 :("
		return false;
	} 
	if (eng == -1 || num == -1) {
		id_check.style.color = "red";
		id_check.innerHTML="아이디는 영문자와 숫자로 입력해주세요. :("
		return false;
	} 
	if (eng != -1 && num != -1 && kor == -1 && spe == -1) {
		id_check.style.color = "green";
		id_check.innerHTML="아이디가 입력되었습니다 :)"
		return true;
	}
}

//아이디 중복검사
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
        	  $('#id_check').text("사용중인 아이디입니다. :(");
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

//비밀번호 조합 검사 
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

//주소
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

//이메일 
$(function(){	
	$(document).ready(function(){
		$("select[name=email_op]").on("change", function(){
		    var $addr = $('input[name=email_addr]');
		    if ($(this).val() == "etc") {
		    	$addr.val('');
		    	$addr.prop("readonly",false);
		
		    } else {
		    	$addr.val($(this).val());
		    	$addr.prop("readonly",true);
		    }
		});
	});
});

</script>
</head>
<body>
<div id="joinForm">
<h1>Join</h1>

<table>
	<tbody>
		<tr>
			<td>이름 <span style="color:tomato;">*</span></td>
			<td><input type="text" required></td>
		</tr>
	
		<tr>
			<td>아이디 <span style="color:tomato;">*</span></td>
			<td>
				<input  name="member_id" id="member_id" pattern="[a-z0-9]{6,20}" title="아이디는 영문자(소문자)와 숫자로 4~16 자리를 입력해주세요."  onkeyup="idRegexp()" type="text" placeholder="영문 소문자/숫자, 4~16자"  required>
				<a id="btnOverlappedId" href="#" onClick="fn_overlappedId()" >중복확인</a>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<span id="id_check"></span>
			</td>
		</tr>
		
		<tr>
			<td>비밀번호 <span style="color:tomato;">*</span></td>
			<td><input name="member_pw" id="member_pw" onkeyup="pwRegexp()" type="password" placeholder="영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자"  required></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<span id="pw_help"></span>
			</td>
		</tr>
		<tr>
			<td>비밀번호 확인 <span style="color:tomato;">*</span></td>
			<td><input name="member_pw_confirm" id="member_pw_confirm" onkeyup="pwCheck()" type="password" placeholder="비밀번를 한번 더 입력해주세요"required></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<span id="pw_check"></span>
			</td>
		</tr>
		
		<tr>
			<td>휴대전화 <span style="color:tomato;">*</span></td>
			<td>
			<select class="hp" name="hp1" required >
			  <option selected>010</option>
			  <option>011</option>
			  <option>016</option>
			  <option>017</option>
			  <option>018</option>  
			  <option>019</option>
			</select>
			-  <input class="hp" name="hp2" type="text" maxlength="4" pattern="[0-9]{4}" required>
			-  <input class="hp" name="hp3" type="text" maxlength="4" pattern="[0-9]{4}" required>
			</td>
		</tr>
		
		<tr>
			<td>주소</td>
			<td>
				<input type="text"required id="zipcode" name="zipcode" size="12" readonly >
				&nbsp;&nbsp;<a href="javascript:execDaumPostcode()">우편번호</a>
			</td>
		</tr>
		
		<!-- 도로명 OR 지번 주소 -->
		<tr>
			<td>
			</td>
			<td>
				<input name="road_address" id="roadAddress" type="text" required placeholder="기본주소">
				<input name="jibun_address" id="jibunAddress" type="hidden" required>
			</td>
		</tr>		
		
		<!-- 나머지 주소 -->
		<tr>
			<td>
			</td>
			<td>
				<input name="namuji_address" id="namujiAddress" type="text" required placeholder="나머지주소">
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<input class="email" name="email_id" type="text">
				@ <input class="email" name="email_addr" type="text" value="">
				<select name="email_op">
					<option value="etc">직접입력</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net">daum.net</option>
					<option value="nate.com">nate.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="yahoo.com">yahoo.com</option>
					<option value="hotmail.com">hotmail.com</option>
				</select>
			</td>
		</tr>
	</tbody> 
</table>
<div>
</div>

<!-- 이용약관 동의 -->
<div>
  
<input type="checkbox">이용약관 및 개인정보수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.
  <p>[필수] 이용약관 동의</p>
  <input type="">  
  이용약관에 동의하십니까? <input type="checkbox"> 동의함

  <p>[필수] 개인정보 수집 및 이용 동의</p>
  개인정보 수집 및 이용에 동의하십니까? <input type="checkbox"> 동의함
  
  <p>[선택] 쇼핑정보 수신 동의</p>
 
  SMS 수신을 동의하십니까? <input type="checkbox"> 동의함
이메일 수신을 동의하십니까? <input type="checkbox"> 동의함
</div>

<div class="join_button"><a href="#">회원가입</a></div>

</div>

<!-- 
<div class="con-min-width">
<div class="con">

	<div id="contain" align=center>
	<p id="join_title" align="center">회원가입</p>
	<form action="${contextPath}/member/joinCheck.do" method="post" onsubmit="return join_valid();" >	
	<table id="join_table">	
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

		<tr>
			<td>
				<p class="inline" class="join_textbox">이름 <span id="red_color">*</span></p>
			</td>
			<td>
				<input name="member_name" class="join_inputbox" type="text" size="19" maxlength="10" id="member_name" 
				pattern="[가-힣]{2,10}" required title="이름은 공백없이 한글로 입력해주세요." />
			</td>
		</tr>

		<tr>
			<td>	
				<p class="inline" class="join_textbox">주민등록번호 <span id="red_color">*</span></p>
			</td>
			<td>
				<input name="member_rrn1" class="join_inputbox" type="text" size="8" maxlength="6" id="member_rrn1" 
				pattern="[0-9]{6}" required title="주민등록번호 앞 6자리를 숫자로 입력해주세요." />
				<span> - </span>
				<input name="member_rrn2" class="join_inputbox" type="password" size="8" maxlength="7" id="member_rrn2" 
				pattern="[0-9]{7}" required title="주민등록번호 뒤 7자리를 숫자로 입력해주세요." />
			</td>
		</tr>
	</table>
			<input type="submit" value="회원가입" id="join_btn" align="center">
			<br><br>
		<div style="width:300px; heigh:40px;">
        	<a id="kakao_join" href="javascript:kakaoLogin();">
       			<img src="https://developers.kakao.com/tool/resource/static/img/button/kakaosync/complete/ko/kakao_login_medium_wide.png" alt="카카오 로그인" >
        	</a>
      	</div>
	</form>	
	</div>
</div>
</div>
 -->
</body>
</html>

