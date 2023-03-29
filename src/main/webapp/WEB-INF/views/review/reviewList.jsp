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
<style>
#reviewList {
	width:1200px; padding:10px; 
}

#reviewList .review_count {
margin: 10px 5px 0px; color: rgb(50, 50, 50); font-size: 0.75em; float:left; width:100%; height:20px;border-bottom : solid 1px rgb(150, 150, 150); 
}

#reviewList .container {
	width: 100%; font-size: 0.75em; margin-top: 20px; display: grid; grid-template-columns:repeat(4, 300px); 
}

#reviewList .container .item {
	margin: 0 10px; padding: 10px 0px; float:left;  margin: auto;
}

#reviewList .container h2 {
	padding: 0px 0px 2px; font-size: 1.2em; font-weight: bold;
}
#reviewList .container .item .review_image {
	position:relative; margin: auto;
}

#reviewList .container .review_image img {
	width: 250px;
}

#reviewList .container .item  .review_description {
	height:50px; margin: auto;
}

#reviewList .container .review_description h2 {
	height:20px; 
}

#reviewList .container .product_description h2 a {
  color:rgb(50, 50, 50); margin: 8px 6px; font-size: 16px; 
}


</style>
</head>
<body>
<div id="reviewList"> 
<h1>이용후기</h1>
   <c:set  var="review_count" value="0" />   
	
	<div><h2 class="total_count">총 ${fn:length(reviewList)}건</h2></div>
	<div class="container">
	<c:choose>
	   <c:when test="${ empty productList  }" >
			<h1>등록된 이용후기가 없습니다.</h1>
	   </c:when>
   <c:otherwise>
	<c:forEach var="item" items="${reviewList }"> 
	   <c:set  var="review_total_count" value="${review_count+1 }" />
        <div class="item">
          <div class="review_image">
            <a href="#">
            	<img alt="" src="https://pbs.twimg.com/profile_images/1343164971681599488/ZV30t8pJ_400x400.jpg">
			</a>
   		</div>
		<div class="review_description">
  		    <h2><a href="${contextPath}/review/reviewDetail.do?review_id=${item.review_id}">${item.review_title }</a></h2>

       ${item.member_id }       ${item.review_write_date}
      
		${item.product_name }
		${item.center_name }
		</div>
		
	   </div>
	</c:forEach>
</c:otherwise>
</c:choose>
		<div class="item"></div><div class="item"></div><div class="item"></div> 
</div>
  
</div>
</body>
</html>