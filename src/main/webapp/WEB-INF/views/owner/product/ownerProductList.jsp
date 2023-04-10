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

	// 상품 수정하기
	function fn_modify_product(url, product_id) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		var product_id_Input = document.createElement("input");
		product_id_Input.setAttribute("type", "hidden");
		product_id_Input.setAttribute("name", "product_id");
		product_id_Input.setAttribute("value", product_id);
		
		form.appendChild(product_id_Input);
		document.body.appendChild(form);
		form.submit();
	}
	
	// 상품 삭제하기
	function fn_remove_product(url, product_id) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		var product_id_Input = document.createElement("input");
		product_id_Input.setAttribute("type", "hidden");
		product_id_Input.setAttribute("name", "product_id");
		product_id_Input.setAttribute("value", product_id);

		form.appendChild(product_id_Input);
		document.body.appendChild(form);
		form.submit();
	}

</script>
</head>
<body>
	<form action="${contextPath}/mypage/ownerProductList.do" method="get">
		<input type="hidden" name="member_id" value="${member_id}"> <input
			type="hidden" name="chapter" value="1">
		<div class="con-min-width">
			<div class="con">
				<div id="contain">
					<!-- 사업자 페이지 사이드 메뉴 -->
					<jsp:include page="/WEB-INF/views/owner/main/ownerPageSide.jsp" />
					<div id="contain_right">
						<p id="mypage_order_title">상품 관리</p>

						<c:choose>
							<c:when test="${empty ownerProductList}">
								<table id="order_detail2" align=center>
									<tr>
										<th width="4%">번호</th>
										<th width="13%">등록일</th>
										<th width="25%" colspan="2">상품정보</th>
										<th width="12%">정가</th>
										<th width="12%">할인가</th>
										<th width="8%">판매상태</th>
										<th width="10%">선택</th>
									</tr>
									<tr>
										<td colspan="8" style="color: blue;">조회된 상품 내역이 없습니다. 😂</td>
									</tr>
								</table>

							</c:when>
							<c:otherwise>
								<table id="order_detail2" align=center>
									<tr>
										<th width="4%">번호</th>
										<th width="13%">등록일</th>
										<th width="25%" colspan="2">상품정보</th>
										<th width="12%">정가</th>
										<th width="12%">할인가</th>
										<th width="8%">판매상태</th>
										<th width="10%">선택</th>
									</tr>

									<!-- 상품 리스트 -->
									<c:forEach var="list" items="${ownerProductList}">
										<c:set var="i" value="${i+1}" />
										<tbody>
											<tr>
												<!-- 번호 -->
												<td>${list.product_id}</td>
												
												<!-- 등록일 -->
												<td style="font-size: 14px;">${list.product_entered_date}</td>
												
												<!-- 대표이미지 -->
												<td align=center>
													<div id="img_file">
														<img alt="img" width="100%" height="100%"
															src="${contextPath}/download.do?product_id=${list.product_id}&fileName=${list.product_main_image}">
													</div>
												</td>
												
												<!-- 상품정보 -->
												<td style="text-align: left; line-height: 25px; font-size: 18px;">
													<a href="${contextPath}/product/productDetail.do?product_id=${list.product_id}" style="line-height: 32px;">${list.product_name}</a>
												</td>
												
												<!-- 정가 -->
												<td>
													<fmt:formatNumber value="${list.product_price}" type="number" />원
												</td>
												
												<!-- 할인가 -->
												<td>
													<fmt:formatNumber value="${list.product_sales_price}" type="number" />원
												</td>
														
												<!-- 상품 상태 -->
												<td>
													<c:choose>
														<c:when test="${list.sale_yn == '0'}">
															승인대기
														</c:when>
														<c:when test="${list.sale_yn == '1'}">
															판매중
														</c:when>
														<c:when test="${list.sale_yn == '2'}">
															판매중지
														</c:when>
													</c:choose>
												</td>
														
												<!-- 수정 및 삭제 버튼 -->
												<td>
													<input type="button" id="owner_modify_btn" value="수정하기"
														onclick="fn_modify_product('${contextPath}/owner/product/adminProductModifyForm.do', ${item.product_id})">
													<input type="button" id="owner_delete_btn" value="삭제하기"
														onClick="fn_remove_product('${contextPath}/owner/product/removeProduct.do', ${item.product_id})">
												</td>
											</tr>
										</tbody>
									</c:forEach>
								</table>
							</c:otherwise>
						</c:choose>
						
						<div align=right style="margin-top: 10px;">
								<a href="${contextPath}/owner/product/productForm.do?member_id=${memberInfo.member_id}"
									style="line-height: 32px;"> <span id="btn_1">상품등록</span></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>