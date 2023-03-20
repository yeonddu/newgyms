<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"   isELIgnored="false"
   %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%> 
<link href="${contextPath}/resources/css/main.css?after" rel="stylesheet" type="text/css"/>

     <!-- 슬라이드 -->
      <div id="ad_main_banner" style="margin-top:7px;">
        <ul class="bjqs">       
           <li><img width="1920" height="700" src="${contextPath}/resources/image/main_slide1.png"></li>
           <li><img width="1920" height="700" src="${contextPath}/resources/image/main_slide2.png"></li>
           <li><img width="1920" height="700" src="${contextPath}/resources/image/main_slide3.png"></li> 
           <li><img width="1920" height="700" src="${contextPath}/resources/image/main_slide4.png"></li> 
        </ul>
     </div> 
 <div class="con-min-width" >
   <div class="con"> 
      <!-- 1. 이런분들께 추천합니다 -->
      <div>
      	<div class="section-1">
            <img src="${contextPath}/resources/image/recommand.png" alt="이런분들에게 추천합니다!" style="width:600px; height:548px;">
        </div>
      </div>
        
      <!-- 2. 인기이용권 -->
      <h2>인기 이용권</h2>
	   <c:set  var="product_count" value="0" />   
		<div class="container">
					<c:choose>
					   <c:when test="${ empty productList  }" >
							<div style="font-size:16px;">등록된 상품이 없습니다.</div>
					   </c:when>
				   <c:otherwise>
					<c:forEach var="item" items="${productList }"> 
					   <c:set  var="product_total_count" value="${product_count+1 }" />
				        <div class="item">
				          <div class="product_image">
				            <a href="${contextPath}/product/productDetail.do?product_id=${item.product_id}">
							   <img alt="" src="${contextPath}/download.do?product_id=${item.product_id}&fileName=${item.product_main_image}">
							</a>
							<div class="wish" >
							</div>
								<a id="wish" href=""><img src="${contextPath}/resources/image/heart.png" alt="찜하기"></a>
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
        
        <!-- 3. 이용후기 -->
        <div class="tab_content" id="tab2">
        <h2 class="review_title">이용후기</h2>
        <table class="review_list">
          <tbody>
            <c:choose>
			   <c:when test="${ empty reviewList  }" >
				   <tr>
					<td>등록된 이용후기가 없습니다.</td>
			 		</tr>
			   </c:when>
			   	<c:otherwise>
			        <c:forEach var="review" items="${reviewList }"> 
			          <tr class="review_item">
			            <td>
			              <img alt="이용후기 이미지" src="${contextPath}/reviewImage.do?review_no=${review.review_no}&fileName=${review.review_image}">
			            </td>
			            <td>
			              <div class="review_title">${review.review_title}</div>
			              <div class="review_option">[옵션] ${review.product_option}</div>    
			              <div class="review_content">${review.review_contents}</div>
			            </td>
			            <td class="review_writer">                          
			              <div>${review.member_id}</div>
			            </td>
			            <td class="review_writeDate">
			              <div>${review.review_write_date}</div>
			            </td>
			          </tr>
				 </c:forEach>
				</c:otherwise>
			</c:choose>
	        </tbody>
	      </table>
	      </div> 
	      </div>
	      </div>
      
      <div class="line-1" style="width:1920px; height: 2px; background-color:#f4f2f2;"></div>
          
   <%--      <div class="line-2" style="width:1200px; height: 2px; background-color:#f4f2f2;"></div>
        <div class="section-3">
           <div class="section-3_title">이용후기</div>
           <div class="section-3_review">
              <ul style="display:flex;">
                 <li><a href="#"><img style="width:220px; height:220px;" src="${contextPath}/resources/image/review-1.jpg" alt=""></a></li>
                 <li><a href="#"><img style="width:220px; height:220px;" src="${contextPath}/resources/image/review-2.jpg" alt=""></a></li>
                 <li><a href="#"><img style="width:220px; height:220px;" src="${contextPath}/resources/image/review-3.jpg" alt=""></a></li>
                 <li><a href="#"><img style="width:220px; height:220px;" src="${contextPath}/resources/image/review-4.jpg" alt=""></a></li>
                 <li><a href="#"><img style="width:220px; height:220px;" src="${contextPath}/resources/image/review-5.jpg" alt=""></a></li>
              </ul>
           </div>
        </div>
        <div class="line-3" style="width:1200px; height: 2px; background-color:#f4f2f2;"></div> --%>


   
   