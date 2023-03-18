<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<link href="${contextPath}/resources/css/header.css?after" rel="stylesheet" type="text/css"/>

<style>

</style>

<script type="text/javascript">
   var loopSearch=true;
   function keywordSearch(){
      if(loopSearch==false)
         return;
    var value=document.frmSearch.searchWord.value;
      $.ajax({
         type : "get",
         async : true, //false인 경우 동기식으로 처리한다.
         url : "${contextPath}/goods/keywordSearch.do",
         data : {keyword:value},
         success : function(data, textStatus) {
             var jsonInfo = JSON.parse(data);
            displayResult(jsonInfo);
         },
         /* error : function(data, textStatus) {
            alert("에러가 발생했습니다."+data); */
         },
         complete : function(data, textStatus) {
            //alert("작업을완료 했습니다");
            
         }
      }); //end ajax   
   }
   
   function displayResult(jsonInfo){
      var count = jsonInfo.keyword.length;
      if(count > 0) {
          var html = '';
          for(var i in jsonInfo.keyword){
            html += "<a href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
          }
          var listView = document.getElementById("suggestList");
          listView.innerHTML = html;
          show('suggest');
      }else{
          hide('suggest');
      } 
   }
   
   function select(selectedKeyword) {
       document.frmSearch.searchWord.value=selectedKeyword;
       loopSearch = false;
       hide('suggest');
   }
      
   function show(elementId) {
       var element = document.getElementById(elementId);
       if(element) {
        element.style.display = 'block';
       }
      }
   
   function hide(elementId){
      var element = document.getElementById(elementId);
      if(element){
        element.style.display = 'none';
      }
   }

</script>
<body>
<div id="header">
<div class="main"><a href="#">logo</a></div>
<nav class="main_nav">
  <ul>
		<li><a href="#">사무소 소개</a></li>
		<li><a href="#">매물검색</a></li>
		<li><a href="#">시세정보</a></li>		
		<li><a href="#">매수, 매도 의뢰</a></li>		
		<li><a href="#">우리동네 이야기</a></li>				
	</ul>
</nav>
<nav class="sub_nav">
<ul>
	<li>
		<a class="mypage" href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="#43A75A" ><path d="M12 2.5a5.25 5.25 0 0 0-2.519 9.857 9.005 9.005 0 0 0-6.477 8.37.75.75 0 0 0 .727.773H20.27a.75.75 0 0 0 .727-.772 9.005 9.005 0 0 0-6.477-8.37A5.25 5.25 0 0 0 12 2.5Z"></path></svg></a>
			<ul class="mypage_list">
	           <c:choose>
               <c:when test="${isLogOn==true and not empty memberInfo }">
                   <li><a href="${contextPath}/member/logout.do">로그아웃</a></li>
               </c:when>
               <c:otherwise>
					<li><a href="${contextPath}/member/loginForm.do">로그인</a></li>
					<li><a href="${contextPath}/member/joinForm.do">회원가입</a></li>
               </c:otherwise>
            </c:choose>
				<li><a href="${contextPath}/member/loginForm.do">마이페이지</a></li>
			</ul>
	</li>	
	<li>
		<a class="wish" href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="#43A75A"><path d="m12 20.703.343.667a.748.748 0 0 1-.686 0l-.003-.002-.007-.003-.025-.013a31.138 31.138 0 0 1-5.233-3.576C3.8 15.573 1 12.332 1 8.514v-.001C1 5.053 3.829 2.5 6.736 2.5 9.03 2.5 10.881 3.726 12 5.605 13.12 3.726 14.97 2.5 17.264 2.5 20.17 2.5 23 5.052 23 8.514c0 3.818-2.801 7.06-5.389 9.262a31.148 31.148 0 0 1-5.233 3.576l-.025.013-.007.003-.002.001ZM6.736 4C4.657 4 2.5 5.88 2.5 8.514c0 3.107 2.324 5.96 4.861 8.12a29.655 29.655 0 0 0 4.566 3.175l.073.041.073-.04c.271-.153.661-.38 1.13-.674.94-.588 2.19-1.441 3.436-2.502 2.537-2.16 4.861-5.013 4.861-8.12C21.5 5.88 19.343 4 17.264 4c-2.106 0-3.801 1.389-4.553 3.643a.751.751 0 0 1-1.422 0C10.537 5.389 8.841 4 6.736 4Z"></path></svg></a>
	</li>
	<li>
		<a class="search" href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="#43A75A"><path d="M10.25 2a8.25 8.25 0 0 1 6.34 13.53l5.69 5.69a.749.749 0 0 1-.326 1.275.749.749 0 0 1-.734-.215l-5.69-5.69A8.25 8.25 0 1 1 10.25 2ZM3.5 10.25a6.75 6.75 0 1 0 13.5 0 6.75 6.75 0 0 0-13.5 0Z"></path></svg></a>
	</li>
</ul>
</nav>


<!--

         <div class="login flex">
            <ul class="login_menu_1 flex">
              </ul>
         </div>
         <div class="center flex">
                    <div class="logo">
                        <a href="${contextPath}/main/main.do"><img src="${contextPath}/resources/image/logo.png" alt="newgyms"></a>
                    </div>
                    <div class="flex-grow"></div>
                    
                    <div class="search" >
                     <form name="frmSearch" action="${contextPath}/product/searchProduct.do" >
                        <input class="search_input" name="searchWord"  type="text"  onKeyUp="keywordSearch()" placeholder="검색어를 입력하세요"> 
                        <input class="search_img" type="image" src="${contextPath}/resources/image/search.png" alt="search" style="width:20px; height:20px;" name="search">
                     </form>
                  </div>
                    
                    
                    <div class="flex-grow"></div>
                    <div>
                        <ul class="icons">
                        <c:choose>
		                     <c:when test="${isLogOn==true and not empty memberInfo}">
		                        <li><a href="${contextPath}/mypage/myPageMain.do"><img style="width:33px; height:33px;" src="${contextPath}/resources/image/person.png" alt="회원"></a></li>
		                     </c:when>
		                     <c:when test="${isLogOn==true and memberInfo.join_type =='102'}">
		                        <li><a href="#"><img style="width:33px; height:33px;" src="${contextPath}/resources/image/person.png" alt="사업자"></a></li> 
		                     </c:when>
		                     <c:when test="${isLogOn==true and memberInfo.member_id =='admin'}">
		                        <li><a href="${contextPath}/admin/goods/adminGoodsMain.do"><img style="width:33px; height:33px;" src="${contextPath}/resources/image/person.png" alt="관리자"></a></li> 
		                     </c:when> 
		                     <c:otherwise>
		                        <li><a href="#"><img style="width:33px; height:33px;" src="${contextPath}/resources/image/person.png" alt="비회원"></a></li> 
		                     </c:otherwise>
	                  	</c:choose>
                  
	                    <c:choose>
		                     <c:when test="${isLogOn==true and not empty memberInfo }">
		                        <li><a href="#"><img style="width:26px; height:26px;" src="${contextPath}/resources/image/heart.png" alt="회원찜"></a></li>
		                     </c:when>
		                     <c:otherwise>
								<li><a href="${contextPath}/member/loginForm.do" onclick="javascript:alert('로그인이 필요합니다.');"><img style="width:26px; height:26px;" src="${contextPath}/resources/image/heart.png" alt="로그인 전"></a></li> 		                     </c:otherwise>
	                    </c:choose>
                  
		                        <li><a href="${contextPath}/cart/myCartList.do"><img style="width:30px; height:30px;" src="${contextPath}/resources/image/cart.png" alt="회원장바구니"></a></li>
                </div>
-->
</div>
                
</body>
</html>