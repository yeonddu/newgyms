<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="cartList" value="${cartMap.myCartList}" />
<c:set var="productList" value="${cartMap.myProductList}" />
<c:set var="optList" value="${productOptList}" />

<!-- 장바구니 총 상품금액 -->
<c:set var="cart_total_price" value="0" />

<!-- 총 할인금액 -->
<c:set var="totalDiscountedPrice" value="0" />


<%
//치환 변수 선언합니다.
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link href="${contextPath}/resources/css/cart.css?after"
	rel="stylesheet" type="text/css" media="screen">

<title>장바구니</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
	$(document).ready(function() {
		$("#check_all").click(function() {
			if ($("#check_all").is(":checked"))
				$("input[name=check_one]").prop("checked", true);
			else
				$("input[name=check_one]").prop("checked", false);
		});

		$("input[name=check_one]").click(function() {
			var total = $("input[name=check_one]").length;
			var checked = $("input[name=check_one]:checked").length;

			if (total != checked)
				$("#check_all").prop("checked", false);
			else
				$("#check_all").prop("checked", true);
		});
	});

	/* 옵션변경 팝업창 띄우기 */
	function modifyPopup(type) {

		if (type == 'open') {
			$('#modify_popup').attr('style', 'visibility:visible'); // 팝업창을 연다.
			
		} else if (type == 'close') {
			$('#modify_popup').attr('style', 'visibility:hidden');
		}
	}
	
	/* 팝업창에 옵션 출력 */
	$(document).ready(function() {
		$('.modify_option_btn').on('click', function() { 
			var thisRow = $(this).closest('tr'); //누른 곳의 tr값을 찾는다. 
			var currentProduct_id = thisRow.find('#current_product_id').val();
			
			console.log("현재 product_id " + currentProduct_id);

			//선택된 product_id 값을 옵션 input에 넣기
			$('#currentProduct_id').val(currentProduct_id);

			$.ajax({
				type : "GET",
				async : false,
				url : "${contextPath}/cart/selectProductOption.do",
				data : {
					product_id : currentProduct_id,
				},
				dataType : 'json',
				contentType : "application/json;charset=UTF-8",
				success : function(data) {
					var data_length = Object.keys(data).length; //JSON 객체의 길이 구하기
					
					$('#cart_product_opt').empty(); //option 초기화
					$('#cart_product_opt').append("<option value=''>[필수] 옵션 선택</option>");
					
					for (var i=0;i<data_length;i++) {
						console.log(data[i]);
						var product_option_name = data[i].product_option_name;
						var product_option_price = data[i].product_option_price;
						$('#cart_product_opt').append("<option value='"+product_option_price+"'>" + product_option_name +  " (+"+product_option_price + "원)" + "</option>");
					}
				},
				error : function(data) {
					alert("에러가 발생했습니다." + data);
				},
				complete : function(data) {
					//alert("작업을완료 했습니다");
				}

			});
		});
	});
		

	/*변경한 옵션 저장하기*/
	function modify_cart_option(){
		var product_id = $('#currentProduct_id').val();
		
		//선택된 옵션
		var cart_product_opt = $("#cart_product_opt option:checked").text();
		
		if ($("#cart_product_opt option:checked").val() == '') {
			alert("옵션을 선택해주세요");
			return;
		} 
	
		/* 옵션명 가져오기 */
		var cart_product_opt_spl = cart_product_opt.split(" (+"); 
		
		var cart_option_name = cart_product_opt_spl[0]; /*옵션명*/
		
		var cart_option_price = $("#cart_product_opt option:checked").val(); /*옵션가격*/
		
	   $.ajax({
	      type : "post",
	      async : false, //false인 경우 동기식으로 처리한다.
	      url : "${contextPath}/cart/modifyCartOption.do",
	      data : {
	    	  product_id:product_id,
	    	  cart_option_name:cart_option_name,
	    	  cart_option_price:cart_option_price
	      },
	      
	      success : function(data, textStatus) {
	         //alert(data);
	         if(data.trim()=='modify_success'){
	            alert("옵션 변경이 완료되었습니다!");   
				location.reload();
	         }else{
	            alert("다시 시도해 주세요!!");   
	         }
	         
	      },
	      error : function(data, textStatus) {
	         alert("에러가 발생했습니다."+data);
	      },
	      complete : function(data, textStatus) {
	         //alert("작업을완료 했습니다");
	         
	      }
	   }); //end ajax   
	}
		
	
	/* 개별 삭제 */
	function delete_each_cart_product(cart_id) {
		var cart_id = Number(cart_id);
		var formObj = document.createElement("form");
		var i_cart = document.createElement("input");
		i_cart.name = "cart_id";
		i_cart.value = cart_id;

		formObj.appendChild(i_cart);
		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "${contextPath}/cart/removeCartProduct.do";
		formObj.submit();
	}
	
	/* 선택 삭제 */
	function javascript:delete_select_cart_product() {
		
	}
	
	
	
	$(document).ready(function() {
		$('.del_check').on('click', function() { 
			var thisRow = $(this).closest('tr'); //누른 곳의 tr값을 찾는다. 
			var product_id = thisRow.find('#current_product_id').val();
			
			console.log("현재 product_id " + product_id);


			$.ajax({
				type : "GET",
				async : false,
				url : "${contextPath}/cart/selectProductOption.do",
				data : {
					product_id : currentProduct_id,
				},
				dataType : 'json',
				contentType : "application/json;charset=UTF-8",
				success : function(data) {
					var data_length = Object.keys(data).length; //JSON 객체의 길이 구하기
					
					$('#cart_product_opt').empty(); //option 초기화
					$('#cart_product_opt').append("<option value=''>[필수] 옵션 선택</option>");
					
					for (var i=0;i<data_length;i++) {
						console.log(data[i]);
						var product_option_name = data[i].product_option_name;
						var product_option_price = data[i].product_option_price;
						$('#cart_product_opt').append("<option value='"+product_option_price+"'>" + product_option_name +  " (+"+product_option_price + "원)" + "</option>");
					}
				},
				error : function(data) {
					alert("에러가 발생했습니다." + data);
				},
				complete : function(data) {
					//alert("작업을완료 했습니다");
				}

			});
		});
	});
	
	
</script>

</head>
<body>


	<div class="con-min-width">
		<div class="con">

			<div id="myCartList">
				<h1>장바구니</h1>

				<table class="cart_list">
					<div class="select_all">
						<input type="checkbox" id="check_all"/> 전체선택
					</div>
					<tbody>
						<c:choose>
							<c:when test="${ empty cartList  }">
								<tr>
									<td colspan="6" style="text-align: center; padding: 20px;">장바구니가
										비어있습니다.</td>
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
													
												<input type="checkbox" name="check_one" id="del__product_id" value="${product.product_id}">
												</td>
												<td><a href="${contextPath}/product/productDetail.do?product_id=${product.product_id}">
														<img alt="상품 이미지" src="${contextPath}/thumbnails.do?product_id=${cart.product_id}&fileName=${product.product_main_image}">
													</a>
												</td>
												<td>
													<div class="cart_title">
														<a href="${contextPath}/product/productDetail.do?product_id=${product.product_id}">${product.product_name}</a>
													</div>
													<div class="cart_option">[옵션] ${cart.cart_option_name} (+<fmt:formatNumber value="${cart.cart_option_price}" type="number" />원)
													</div>
												<td class="modify_option_btn">
													<a href="javascript:modifyPopup('open', '.layer01');">옵션변경</a>
												</td>
												<td class="product_total_price">
													<fmt:formatNumber value="${product.product_sales_price+cart.cart_option_price}" type="number" var="product_total_price" />
													${product_total_price }원
												</td>

													<!-- 장바구니 총 상품금액 구하기 -->
													<fmt:parseNumber value="${product_total_price } " var ="product_total_price"/>
													<fmt:parseNumber value="${cart_total_price } " var ="cart_total_price"/>
													<c:set var="cart_total_price" value="${cart_total_price+product_total_price}" />
													
												<td class="x_button">
													<a href="javascript:delete_each_cart_product('${cart.cart_id}');">X</a>
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
					총 상품금액 <fmt:formatNumber value="${cart_total_price}" type="number" />원
				</div>
				<a href="javascript:delete_select_cart_product();">선택삭제</a>
				<div style="text-align: center">
					<input class="order_button" name="order" type="submit" value="주문하기">
					<input class="back_button" name="back" type="submit"
						value="쇼핑 계속하기">
				</div>

				<!-- 옵션 수정창 -->
				<div id="modify_popup" style="visibility: hidden">
					<!-- style="visibility: hidden"  -->
					<form>
						<a class="x_button" href="javascript:"
							onClick="javascript:modifyPopup('close', '.layer01');">X</a>
						<h6>옵션변경</h6>
						<input type="hidden" id="currentProduct_id">
						<select id="cart_product_opt" name="cart_product_opt">
						
						</select>
						<a class="modify_button" href="javascript:modify_cart_option();">저장</a>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>