<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/mypage.css" rel="stylesheet" />
<link href="${contextPath}/resources/css/owner.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	/* 메인 이미지 첨부 */
	function readURL(input) {
		if (input.files && input.files[0]) {
			
			var fileName = input.files[0].name;
			
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#preview_main_img').attr('src', e.target.result);
	            
	            $('#product_main_image').val(fileName);	//fileName 넣어주기
	        };
	        reader.readAsDataURL(input.files[0]);
		}
	}

	/* 옵션 추가*/
	var opt = 1;
	function fn_addOption(){
		$("#product_option").append(" &nbsp <div class='add_product_option'><input type='text' name='optionList["+opt+"].product_option_name' placeholder='옵션명'>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"
				+"&nbsp&nbsp&nbsp<input type='text' pattern='[0-9]{*}' name='optionList["+opt+"].product_option_price' placeholder='옵션가격'> 원 &nbsp&nbsp&nbsp"
				+"&nbsp<a id='del_option_btn"+opt+"' class='del_option_btn' href='javascript:fn_delOption();'>X</a></div>");		
		opt++;
	}

		var btn = document.querySelector('.del_option_btn');
		btn.addEventListener('click', function () {
		  console.log(this); //#btn
		});
		
	/* 옵션 삭제 */
	function fn_delOption() {
		console.log("삭제해조...z")
		console.log("삭제해따...z")
		
	}
/* 	$(document).ready(function() {
		$('.del_option_btn').on('click', function() { 
			var thisOption = $(this).closest('.del_option_btn'); //누른 곳의 tr값을 찾는다. 
			thisOption.remove();
			
		});
	}); */
	
	/* 프로그램 안내 이미지 첨부 */
	 function setThumbnail(event, type) {
	        for (var image of event.target.files) {
	          var reader = new FileReader();

	          reader.onload = function(event) {
	            var img = document.createElement("img");
	            img.setAttribute("src", event.target.result);
	            
	        	  if(type == 'detail_img') {
		            document.querySelector("div#preview_detail_img").appendChild(img);

	        	  } else if(type == 'price_img') {
		            document.querySelector("div#preview_price_img").appendChild(img);
		            
	        	  } else if(type == 'facility_img') {
		            document.querySelector("div#preview_facility_img").appendChild(img);
	        	  }
	          };
	          console.log(image);
	          reader.readAsDataURL(image);
	        }
	      }
	
	/* 목록으로 */
	function backToList(obj) {
		obj.action = "${contextPath}/owner/product/ownerProductList.do";
		obj.submit();
	}

</script>
</head>
<body>
	<div class="con-min-width">
		<div class="con">
			<div id="contain">
				<!-- 사업자 페이지 사이드 메뉴 -->
				<jsp:include page="/WEB-INF/views/owner/main/ownerPageSide.jsp" />
				<div id="contain_right">
				<div id="addProductForm">
				<form action="${contextPath}/owner/product/addNewProduct.do" method="post"  enctype="multipart/form-data">
					<p id="owner_product_title">상품 등록</p>

					<span class="add_product_title">기본정보</span>
					<table id="product_info_table">
						<tr>
							<td>카테고리</td>
							<td colspan="3"><select id="product_sort" name="product_sort" style="padding: 8px;">
									<option value="">[필수] 카테고리 선택</option>
									<option value="헬스/PT">헬스/PT</option>
									<option value="요가/필라테스">요가/필라테스</option>
									<option value="스피닝">스피닝</option>
									<option value="크로스핏">크로스핏</option>
									<option value="기타">기타</option>
							</select></td>
						</tr>
						<tr>
							<td>상품명</td>
							<td colspan="3"><input type="text" name="product_name"></td>
						</tr>
						<tr>
							<td>대표 이미지</td>
							<td colspan="3"> 
								<div  class="img_preview">
									<img id="preview_main_img" src="#" />
									<input id="product_main_image" type="hidden" name="product_main_image">
<!-- 									<input id="product_main_image" type="hidden"  name="product_main_image"  > -->
									<input style="border:none;" type="file" name="product_main_image" onchange="readURL(this);"/>
								</div>
							</td>
						</tr>
						<tr>
							<td>정가</td>
							<td>
								<input type="text" pattern="[0-9]{*}" name="product_price"> 원
							</td>
							
							<td style="text-align:center;">할인가</td>
							<td>
								<input type="text" pattern="[0-9]{*}" name="product_sales_price"> 원
							</td>
						</tr>
						<tr>
							<td>구매 시 적립금</td>
							<td>
								<input type="text" pattern="[0-9]{*}" name="product_point"> 원
							</td>
						</tr>
						<tr>
							<td>옵션</td>
							<td style="text-align:center;">옵션명</td>
							<td style="text-align:center;">옵션가격</td>
							<td></td>
						</tr>
						<tr>	
							<td>						
							</td>
							<td>						
								 <input type="text" name="optionList[0].product_option_name" placeholder="옵션명"> 
							</td>
							<td>						
								 <input type="text" pattern="[0-9]{*}" name="optionList[0].product_option_price" placeholder="옵션가격"> 원
							</td>
							<td>
								<a class="add_option_btn" href="javascript:fn_addOption();">옵션 추가</a>
							</td>
						</tr>
						</table>
								<div id="product_option" style="padding-left:200px;"> </div>
						
						<span class="add_product_title">프로그램 정보</span>
						<table id="product_detail_table">					
						<tr>
							<td>프로그램 상세정보</td>
							<td>
								<textarea name="product_program_details"> </textarea>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>이미지 첨부
								<input  style="border:none;" multiple="multiple" type="file" name="detail_image" accept="image/*" onchange="setThumbnail(event,'detail_img');" />
								<div id="preview_detail_img" class="img_preview"></div>
							</td>
						</tr>
						<tr>
							<td>가격 정보</td>
							<td>
								<textarea name=" product_price_details"> </textarea>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>이미지 첨부
								<input  style="border:none;" multiple="multiple" type="file" name="price_image" accept="image/*" onchange="setThumbnail(event,'price_img');" />
								<div id="preview_price_img" class="img_preview"></div>
							</td>
						</tr>
						<tr>
							<td>시설 정보</td>
							<td>
								<textarea name=" product_facility_details"> </textarea>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>이미지 첨부
								<input  style="border:none;" multiple="multiple" type="file" name="facility_image" accept="image/*" onchange="setThumbnail(event,'facility_img');"/>
								<div id="preview_facility_img" class="img_preview"></div>
							</td>
						</tr>
						<tr>
							<td>위치 정보</td>
							<td>	
								<textarea name=" product_location_details"> </textarea>
							</td>
						</tr>
						</table>
						
						<span class="add_product_title">환불 정보</span>
						<table id="product_refund_table">					
						<tr>
							<td>취소 및 환불 규정</td>
							<td>
								<textarea name="product_refund_1"> </textarea>
							</td>
						</tr>
						<tr>
							<td>취소 및 환불 불가한 경우</td>
							<td>
								<textarea name="product_refund_2"> </textarea>
							</td>
						</tr>
				</table>
				
					<div align=center>
						<input type="submit" value="등록하기" class="submit_btn">
						<button class="submit_btn2" onclick="backToList(this.form)">목록으로</button>
					</div>

				</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>