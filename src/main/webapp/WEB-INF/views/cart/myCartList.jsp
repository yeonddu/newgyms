<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="cartList"  value="${cartMap.myCartList}"  />
<c:set var="productList"  value="${cartMap.myProductList}"  />

<c:set  var="totalProductNum" value="0" />  <!--주문 개수 -->
<c:set  var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 --> 
<c:set  var="totalDiscountedPrice" value="0" /> <!-- 총 할인금액 -->

<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link href="${contextPath}/resources/css/cart.css?after" rel="stylesheet" type="text/css" media="screen">

<title>장바구니</title>

</head>
<body>


<div class="con-min-width">
<div class="con">

<div id="myCartList">
  <h1>장바구니</h1>
  
  <table class="cart_list">
    <div class="select_all"><input type="checkbox" name="all"> 전체선택</div>
    <tbody>
            <c:choose>
	   <c:when test="${ empty cartList  }" >
		   <tr>
			<td colspan="6" style="text-align:center; padding:20px;">장바구니가 비어있습니다.</td>
	 		</tr>
	   </c:when>
   <c:otherwise>
            <c:forEach var="cart" items="${cartList }"> 
               <c:forEach var="product" items="${productList }"> 
          <tr class="cart_item">
            <td>
              <input type="checkbox" name="one">
            </td>
            <td>
              <img alt="상품 이미지" src="${contextPath}/thumnails.do?product_id=${cart.product_id}&fileType=main_image">
            </td>
            <td>
              <div class="cart_title">${product.product_name}</div>
              <div class="cart_option">[옵션] ${product.product_option_name} (+ ${product.product_price})</div>    
            
            <td class="modify_option"><a>옵션변경</a></td>
		     <td class="product_total_price">
		       <%-- <fmt:formatNumber  value="${product.product_sales_price+product.product_optoin+price}" type="number" var="product_total_price" /> --%>
		       ${product_total_price }
		     </td>
		     <td class="detele">
		       X
		     </td>
          </tr>
     </c:forEach>
 </c:forEach>
</c:otherwise>
</c:choose>
        </tbody>
      </table>
  <div class="cart_total_price">
  <%-- <fmt:formatNumber  value="${product_total_price +${product_total_price },,}" type="number" var="cart_total_price" /> --%>
  ${cart_total_price }
  </div>
   	선택삭제 	
<div style="text-align:center">
	<input class="order_button" name="order"  type="submit" value="주문하기">
 	<input class="back_button" name="back"  type="submit" value="쇼핑 계속하기">
  	</div>
  </div>
</div>
</div>
</body>
</html>