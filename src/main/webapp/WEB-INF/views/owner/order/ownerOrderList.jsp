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
</head>
<body>
	<form action="${contextPath}/mypage/ownerOrderList.do" method="get">
		<input type="hidden" name="member_id" value="${member_id}"> <input
			type="hidden" name="chapter" value="1">
		<div class="con-min-width">
			<div class="con">
				<div id="contain">
					<!-- 사업자 페이지 사이드 메뉴 -->
					<jsp:include page="/WEB-INF/views/owner/main/ownerPageSide.jsp" />
					<div id="contain_right">
						<p id="mypage_order_title">주문/결제 관리</p>

						<c:choose>
							<c:when test="${empty ownerOrderList}">
								<table id="order_detail2" align=center>
									<tr>
										<th width="4%">번호</th>
										<th width="13%">결제일자</th>
										<th width="25%" colspan="2">상품정보</th>
										<th width="12%">주문자</th>
										<th width="12%">결제금액</th>
										<th width="8%">결제상태</th>
										<th width="10%">선택</th>
									</tr>
									<tr>
										<td colspan="7" style="color: blue;">조회된 결제 내역이 없습니다. 😂</td>
									</tr>
								</table>

							</c:when>
							<c:otherwise>
								<table id="order_detail2" align=center>
									<tr>
										<th width="4%">번호</th>
										<th width="13%">결제일자</th>
										<th width="25%" colspan="2">상품정보</th>
										<th width="12%">주문자 아이디</th>
										<th width="12%">결제금액</th>
										<th width="8%">결제상태</th>
										<th width="10%">선택</th>
									</tr>

									<!-- 결제내역 대표 -->
									<c:forEach var="list" items="${ownerOrderList}">
										<c:set var="i" value="${i+1}" />
										<tbody>
											<tr>
												<!-- 번호 -->
												<td>${list.order_seq_num}</td>
												
												<!-- 결제일자 -->
												<td style="font-size: 14px;">${list.pay_order_time}</td>
												
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
												
												<!-- 주문자 아이디 -->
												<td>
													<c:choose>
														<c:when test="${fn:length(list.member_id) > 25}">
															비회원
														</c:when>
														<c:otherwise>
															${list.member_id}
														</c:otherwise>
													</c:choose>
												</td>
												
												<!-- 총 결제금액 -->
												<td><fmt:formatNumber value="${list.total_price}"
														type="number" />원</td>
														
												<!-- 결제 상태 -->
												<td>
													${list.order_state}
												</td>
														
												<!-- 상세조회 버튼 -->
												<td><a
													href="${contextPath}/owner/order/ownerOrderDetail.do?order_seq_num=${list.order_seq_num}"
													style="line-height: 32px;"><span id="btn_1">상세조회</span></a>
													<br></td>
											</tr>
										</tbody>
									</c:forEach>
								</table>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>