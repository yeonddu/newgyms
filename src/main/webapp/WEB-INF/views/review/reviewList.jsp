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
<link href="${contextPath}/resources/css/community.css" rel="stylesheet" />
<title>상품 목록 조회</title>
</head>
<body>
<div class="con-min-width">
<div class="con">
			<div id="contain">
			<!-- 커뮤니티 사이드 메뉴 -->
			<jsp:include page="/WEB-INF/views/common/communitySide.jsp" />
				<div id="contain_right">
			<div id="reviewList"> 
			<p id="review_title">이용후기</p>
			   <c:set  var="review_count" value="0" />   
				<p>총 ${fn:length(reviewList)}건</p>
				<div class="container">
				<c:choose>
				   <c:when test="${ empty reviewList  }" >
						<h1>등록된 이용후기가 없습니다.</h1>
				   </c:when>
			   <c:otherwise>
				<c:forEach var="item" items="${reviewList }"> 
				   <c:set  var="review_total_count" value="${review_count+1 }" />
			        <div class="item">
			          <div class="review_image">
			            <a href="${contextPath }/review/viewReview.do?review_no=${item.review_no}">
			            <img alt="이용후기 이미지" src="${contextPath}/reviewImage.do?review_no=${item.review_no}&fileName=${item.review_main_image}">
						</a>
			   		</div>
					<div class="review_description">
			  		    <h2><a href="${contextPath}/review/viewReview.do?review_no=${item.review_no}">${item.review_title }</a></h2>
			
<%-- 			       		<div class="review_writer">${item.member_id }</div>       <div class="write_date">${item.review_write_date}</div>
 --%>					
			            <div class="review_score">
			            	<c:choose>
			            		<c:when test="${item.review_score == 1  }">
			            			<div class="review_score">★☆☆☆☆</div>
			            		</c:when>
			            		<c:when test="${item.review_score == 2  }">
			            			<div class="review_score">★★☆☆☆</div>
			            		</c:when>
			            		<c:when test="${item.review_score == 3  }">
			            			<div class="review_score">★★★☆☆</div>
			            		</c:when>
			            		<c:when test="${item.review_score == 4  }">
			            			<div class="review_score">★★★★☆</div>
			            		</c:when>
         							   <c:otherwise>
			            			<div class="review_score">★★★★★</div>
         							   </c:otherwise>
			            	</c:choose>
			            </div>
						<div>
						
	            		   <img alt="상품 메인이미지" src="${contextPath}/thumbnails.do?product_id=${item.product_id}&fileName=${item.product_main_image}">			  
							<div class="product_name"><a href="${contextPath}/product/productDetail.do?product_id=${item.product_id}">${item.product_name }</a> </div>
							<div class="center_name"><a href="#">${item.center_name }</a></div>
						</div>	
					</div>
					
				   </div>
				</c:forEach>
			</c:otherwise>
			</c:choose>
			</div>
			  
			</div>
			</div>
			</div>
</div>
</div>

</body>
</html>