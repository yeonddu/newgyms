<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="cartList"  value="${cartMap.myCartList}"  />
<c:set var="productList"  value="${cartMap.myProductList}"  />
<c:set var="optList"  value="${productOptMap.productOptList }"  />

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
<script>
$(document).ready(function() {
	$("#check_all").click(function() {
		if($("#check_all").is(":checked")) $("input[name=check_one]").prop("checked", true);
		else $("input[name=check_one]").prop("checked", false);
	});
	
	$("input[name=check_one]").click(function() {
		var total = $("input[name=check_one]").length;
		var checked = $("input[name=check_one]:checked").length;
		
		if(total != checked) $("#check_all").prop("checked", false);
		else $("#check_all").prop("checked", true); 
	});
});

function modifyPopup(type) {
	if (type == 'open') {
		// 팝업창을 연다.
		jQuery('#modify_option').attr('style', 'visibility:visible');

	}

	else if (type == 'close') {
		jQuery('#modify_option').attr('style', 'visibility:hidden');
		// 팝업창을 닫는다.
		//jQuery('#layer').attr('style', 'visibility:hidden');
	}
}
</script>
<script>
$(document).ready(function () { // 페이지 document 로딩 완료 후 스크립트 실행
	$('.modify_option').on('click',function () { //제목 버튼 클릭 시 
    	var currentProduct_id = $(this).closest('#current_product_id.val()'); //누른 곳의 tr값을 찾는다. 
    	//var current_product_id = $('#current_product_id').val(); //누른 곳의 tr값을 찾는다. 
    	document.getElementById('product_id').innerHTML=current_product_id;
//    	document.getElementById('product_name').innerHTML=current_product_name;
		});
});

</script>
<%-- 
	$(document).ready(function() {
		var current_product_id = $('#current_product_id').val();
//		var current_product_id = document.getElementById('map')$('input[name=product_id]').val();
		document.getElementById('product_id').innerHTML=current_product_id;
});
 --%>
</head>
<body>


<div class="con-min-width">
<div class="con">

<div id="myCartList">
  <h1>장바구니</h1>
  
  <table class="cart_list">
    <div class="select_all">
    	<input type="checkbox" id="check_all"> 전체선택
    </div>
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
               <c:if test="${cart.product_id == product.product_id }">
               
          <tr class="cart_item">
            <td>
              <input type="checkbox" name="check_one">
            </td>
            <td>
	          <input id="current_product_id" type="text" value="${product.product_id}" >
              <a href="${contextPath}/product/productDetail.do?product_id=${product.product_id}">
	              <img alt="상품 이미지" src="${contextPath}/thumbnails.do?product_id=${cart.product_id}&fileName=${product.product_main_image}">
              </a>
            </td>
            <td>
              <div class="cart_title"><a href="${contextPath}/product/productDetail.do?product_id=${product.product_id}">${product.product_name}</a></div>
              <div class="cart_option">[옵션] ${cart.cart_option_name} (+ <fmt:formatNumber  value="${cart.cart_option_price}" type="number"/>원)</div>    
            <td class="modify_option"><a href="javascript:" onClick="javascript:modifyPopup('open', '.layer01');">옵션변경</a></td>
		     <td class="product_total_price">
		      <fmt:formatNumber  value="${product.product_sales_price+cart.cart_option_price}" type="number" var="product_total_price" />
		       ${product_total_price }원
		     </td>
		     <td class="x_button">
		       <a href="${contextPath}/cart/removeCartProduct.do?cart_id=${cart.cart_id}">X</a>
		     </td>
          </tr>
              </c:if>
     </c:forEach>
 </c:forEach>
</c:otherwise>
</c:choose>
        </tbody>
      </table>
  <div class="cart_total_price">
  <%-- <fmt:formatNumber  value="${product_total_price +${product_total_price },,}" type="number" var="cart_total_price" /> --%>
  총 상품금액 ${cart_total_price }원
  </div>
   	<a>선택삭제</a>
	<div style="text-align:center">
		<input class="order_button" name="order"  type="submit" value="주문하기">
 		<input class="back_button" name="back"  type="submit" value="쇼핑 계속하기">
  	</div>
  	
  	
  	<div id="modify_option"  style="visibility: hidden" ><!-- style="visibility: hidden"  -->
  		<form>
  			<a class="x_button" href="javascript:" onClick="javascript:modifyPopup('close', '.layer01');">X</a>
  			<h6>옵션변경</h6>
  			
  			<div id="product_id"></div>
  			
		         <c:if test="${product.product_id == opt.product_id }">
  			<div id="product_name">상품명 ${product.product_name}</div>
  			<select id="cart_product_opt" name="cart_product_opt">
				<option value="0">[필수] 옵션 선택</option>
				<c:forEach var="opt" items="${optList }">
					<option value="${opt.product_option_price}">${opt.product_option_name} (+<fmt:formatNumber  value="${opt.product_option_price}" type="number"/> 원)</option>
				</c:forEach>
	 		</select>
		 		</c:if>
	 		<a class="modify_button" href="#">저장</a>
  		</form>
  	</div>
  </div>
</div>
</div>
</body>
</html>