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


</style>

</head>
<body>
<div class="con-min-width">
<div class="con">

<div id="productList">
   <c:set  var="product_count" value="0" />   
	<h1 id="category">${productSort}</h1>
	<!-- 총 건 -->
	<h2 id="total_count">총 ${fn:length(productList)}건</h2>
	<div id="sorting">
		<ul>
			<li><a href="${contextPath}/product/productList.do?productSort=${productSort}">신상품순</a></li>
			<li><a href="${contextPath}/product/productSorting.do?productSort=${productSort}&sortBy=popular">인기순</a></li>
			<li><a href="${contextPath}/product/productSorting.do?productSort=${productSort}&sortBy=lowPrice">낮은가격순</a></li>
			<li><a style="border: currentColor; border-image: none;" href="${contextPath}/product/productSorting.do?productSort=${productSort}&sortBy=highPrice">높은가격</a></li>
		</ul>
	</div>
	
	<div class="container">
	<c:choose>
	   <c:when test="${ empty productList  }" >
			<h1>등록된 상품이 없습니다.</h1>
	   </c:when>
   <c:otherwise>
	<c:forEach var="item" items="${productList }"> 
	   <c:set  var="product_total_count" value="${product_count+1 }" />
        <div class="item">
          <div class="product_image">
            <a href="${contextPath}/product/productDetail.do?product_id=${item.product_id}">
			   <img alt="" src="${contextPath}/download.do?product_id=${item.product_id}&fileName=${item.product_main_image}">
			</a>
			<div class="wish" ></div>
				<a id="wish" href="${contextPath }/wish/addWishList.do?product_id=${item.product_id}"><img src="${contextPath}/resources/image/heart.png" alt="찜하기"></a>
   		</div>
		<div class="product_description">
  		    <h2><a href="${contextPath}/product/productDetail.do?product_id=${item.product_id}">${item.product_name }</a></h2>
<!-- 사업장관리 페이지로 이동 -->
            <h3><a href="">${item.center_name }</a></h3>
		</div>
		<div class="product_price">
            <div class="discount_rate"><fmt:formatNumber  value="${item.product_sales_price/item.product_price}" type="percent" var="discount_rate" />${discount_rate }</div>
            <div class="sales_price"><fmt:formatNumber  value="${item.product_sales_price}" type="number"/>원</div>
            <div class="price"><fmt:formatNumber  value="${item.product_price}" type="number"/>원</div>					
		</div>
	   </div>
	</c:forEach>
</c:otherwise>
</c:choose>
	</div>
</div>
</div>
</div>
</body>
</html>