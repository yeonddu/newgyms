<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="cartList"  value="${cartMap.myCartList}"  />
<c:set var="productList"  value="${cartMap.myProductList}"  />
<c:set var="optList"  value="${productOptVO }"  />


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
		jQuery('#modify_popup').attr('style', 'visibility:visible');
	}

	else if (type == 'close') {
		jQuery('#modify_popup').attr('style', 'visibility:hidden');
	}
}

function fn_cartOption(product_id) {
	
		 console.log("option 호출");
	   var product_id = product_id;
	   var formObj = document.createElement("form");
	   var i_cart = document.createElement("input");
	   i_product_id.name = "product_id";
	   i_product_id = product_id;
	   
	   formObj.appendChild(i_product_id);
	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="${contextPath}/cart/selectCartOption.do";
	    formObj.submit();
	}
	
	
	/* $.ajax({
		type:"GET",
		url: "${contextPath}/cart/selectCartOption.do",
		data : {
	          product_id:currentProduct_id,
	          
	       },
	       success : function(data) {
	        },
	        error : function(data, textStatus) {
	           alert("에러가 발생했습니다."+data);
	        },
	        complete : function(data, textStatus) {
	           //alert("작업을완료 했습니다");
	        }
	}); */
}

/*옵션변경 창에 옵션값 전송*/
$(document).ready(function () { // 페이지 document 로딩 완료 후 스크립트 실행
	$('.modify_option_btn').on('click',function () { //제목 버튼 클릭 시 
    	var thisRow = $(this).closest('tr'); //누른 곳의 tr값을 찾는다. 
    	var currentProduct_id = thisRow.find('#current_product_id').val();
    	
    	//fn_cartOption(currentProduct_id);
    	
    	console.log("현재 product_id "+currentProduct_id);
    	
    	//선택된 product_id 값을 옵션 input에 넣기
    	$('#currentProduct_id').val(currentProduct_id);
		});
});


/*장바구니 삭제*/
function delete_cart_product(cart_id){
   var cart_id = Number(cart_id);
   var formObj = document.createElement("form");
   var i_cart = document.createElement("input");
   i_cart.name = "cart_id";
   i_cart.value = cart_id;
   
   formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartProduct.do";
    formObj.submit();
}

</script>

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
            	<!-- cart_item의 product_id -->
	          	<input id="current_product_id" type="hidden" value="${product.product_id}" />
      			<select>
						<option>[필수] 옵션 선택</option>
					<c:forEach var="opt" items="${optList }">
						<c:if test="${ cart.product_id == opt.product_id}">
						<option value="${opt.product_option_price}">${opt.product_option_name} (+<fmt:formatNumber  value="${opt.product_option_price}" type="number"/> 원)</option>
						</c:if>
					</c:forEach>
 				</select>
              <input type="checkbox" name="check_one">
            </td>
            <td>
              <a href="${contextPath}/product/productDetail.do?product_id=${product.product_id}">
	              <img alt="상품 이미지" src="${contextPath}/thumbnails.do?product_id=${cart.product_id}&fileName=${product.product_main_image}">
              </a>
            </td>
            <td>
              <div class="cart_title"><a href="${contextPath}/product/productDetail.do?product_id=${product.product_id}">${product.product_name}</a></div>
              <div class="cart_option">[옵션] ${cart.cart_option_name} (+ <fmt:formatNumber  value="${cart.cart_option_price}" type="number"/>원)</div>    
            <td class="modify_option_btn">
            	<a href="javascript:" onClick="javascript:modifyPopup('open', '.layer01');">옵션변경</a>
            	
            </td>
		     <td class="product_total_price">
		      <fmt:formatNumber  value="${product.product_sales_price+cart.cart_option_price}" type="number" var="product_total_price" />
		       ${product_total_price }원
		     </td>
		     <td class="x_button">
		       <a href="javascript:delete_cart_product('${cart.cart_id}');">X</a>
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
  	
  	<!-- 옵션 수정창 -->
  	<div id="modify_popup"  style="visibility: hidden" ><!-- style="visibility: hidden"  -->
  		<form>
  			<a class="x_button" href="javascript:" onClick="javascript:modifyPopup('close', '.layer01');">X</a>
  			<h6>옵션변경</h6>
  			
  			<input type="text" id="currentProduct_id" value="">
		         <c:if test="${cart.product_id == opt.product_id }">
  			<div id="product_name">상품명 ${product.product_name} ${cart.product_id}</div>
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