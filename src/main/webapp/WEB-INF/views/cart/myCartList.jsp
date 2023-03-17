<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 목록 조회</title>
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
</head>
<body>

<div class="con-min-width">
<div class="con">

<div id="searchProduct">
  <h1>상품검색</h1>
<form name="frmSearch" action="${contextPath}/product/searchProductByCondition.do" >
	<div class="searchByKeyword">
	    <h2>검색조건</h2>
		<select class="search_option" name="searchOption" id="searchOption"  >
			<option  value="all">선택</option>
			<option value="product_name">상품명</option>
	        <option value="center_name">시설 이름</option>
	 	</select>
	  	<input class="search_input" name="searchWord"  type="text"  onKeyUp="keywordSearch()" value="${searchWord }" placeholder="검색어를 입력하세요"> 
	  	
	</div>
  <div class="searchByPrice">
    <h2>판매가격</h2>
    <input name="minPrice" type="number"> ~ <input name="maxPrice" type="number">
  </div>
  
	<input class="search_button"name="search"  type="submit" value="검색">
</form>
</div>
			
</div>
</div>
<jsp:include page="/WEB-INF/views/product/productList.jsp"/>
</body>
</html>