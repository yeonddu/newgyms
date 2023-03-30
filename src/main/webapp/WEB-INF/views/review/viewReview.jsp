<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="review"  value="${reviewVO}"  />
<c:set var="reviewImageList"  value="${reviewImageList }"  />
<%
   //치환 변수 선언합니다.
    //pageContext.setAttribute("crcn", "\r\n"); //개행문자
    pageContext.setAttribute("crcn" , "\n"); //Ajax로 변경 시 개행 문자 
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link href="${contextPath}/resources/css/community.css" rel="stylesheet" />
</head>
<body>
<div class="con-min-width">
<div class="con">
	<div id="contain">
			<!-- 커뮤니티 사이드 메뉴 -->
			<jsp:include page="/WEB-INF/views/common/communitySide.jsp" />
			
			
				<div id="contain_right">
				<div id="viewReview">

				<form name="frmReview" method="post" action="${contextPath}" enctype="multipart/form-data">
						
						<table style="width: 100%">
							<tr>
								<!-- 글 제목 -->
								<td align=left><input type="text" value="${review.review_title}" name="review_title" id="review_title" style="margin-left: 15px;" disabled>
									<br></td>

								<!-- 글쓴이 & 작성일 -->
								<td align=right style="padding-top: 90px;">
									<span id="gray_color" style="font-size: 12px;">작성자 &nbsp; ${review.member_id}</span>&nbsp; &nbsp; &nbsp; 
<%-- 									<input type="text" value="${review.member_id}" name="member_id" id="member_id" disabled style="color: #848484; font-size: 12px; background-color: white; border: none;"> --%>
									<span id="gray_color" style="font-size: 12px; text-align: right; margin-top: 68px; margin-bottom: 5px;">
									작성일 &nbsp;${review.review_write_date} 
									</span>
								</td>
							</tr>
							
						</table>

						<hr>
							<!-- 상품 메인이미지 -->
							<div class="product_info">
	            		   <img alt="상품 메인이미지" src="${contextPath}/thumbnails.do?product_id=${review.product_id}&fileName=${review.product_main_image}">			  
								<div>
									<a class="product_name" href="${contextPath}/product/productDetail.do?product_id=${review.product_id}">${review.product_name }</a> 
								</div>
								<div>
								<a class="center_name" href="#">${review.center_name }</a>
								</div>
							</div>

									
						<table id="review_table" >	
						<tr>
						<td>
								<div style="float:left">
								<a class="product_option">[옵션] ${review.product_option_name } (+<fmt:formatNumber value="${review.product_option_price}" type="number"/>원) </a>
								</div>
								<div class="review_score" style="text-align:right">
					            	<c:choose>
					            		<c:when test="${review.review_score == 1  }">
					            			<div class="review_score">★☆☆☆☆</div>
					            		</c:when>
					            		<c:when test="${review.review_score == 2  }">
					            			<div class="review_score">★★☆☆☆</div>
					            		</c:when>
					            		<c:when test="${review.review_score == 3  }">
					            			<div class="review_score">★★★☆☆</div>
					            		</c:when>
					            		<c:when test="${review.review_score == 4  }">
					            			<div class="review_score">★★★★☆</div>
					            		</c:when>
	          							   <c:otherwise>
					            			<div class="review_score">★★★★★</div>
	          							   </c:otherwise>
					            	</c:choose>
								</div>		
							</td>
							</tr>							
							<!-- 글 내용 -->
							<tr>
								<td colspan="3" align=left>${review.review_contents}
								
								리뷰 이미지 ${image.review_no} ${image.fileName}
								
								</td>
							</tr>

							<!-- 사진 -->
							<tr>
							<td>
								<c:forEach var="image" items="${reviewImageList}">
								리뷰 이미지 ${image.review_no} ${image.fileName}
						          <img alt="리뷰 이미지" src="${contextPath}/reviewImage.do?review_no=${image.review_no}&fileName=${image.fileName}">
								</c:forEach>
							</td>
							</tr>
					
						<!-- 이용후기 작성자에게만 보이는 수정/삭제 버튼 -->
						<c:if test="${memberInfo.member_id == review.member_id}">
							<tr>
								<td width="50%" align=right>
									<input type="button" id="modify_btn" value="수정하기"
										onclick="fn_modify_article('${contextPath}/board/modReviewForm.do', ${review.review_no})">
								</td>
								<td width="50%" align=left>
									<input type="button" id="delete_btn" value="삭제하기"
									onClick="fn_remove_article('${contextPath}/board/removeReview.do', ${review.review_no})">
								</td>
							<tr>
						</c:if>				
					</table>
						<div style="text-align:right; margin-top:15px;">
							<a href="${contextPath}/review/reviewList.do" style="line-height:32px;"><span id="btn_1">목록으로</span></a>
						</div>
				</form>
				</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>