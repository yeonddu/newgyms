<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="${contextPath}/resources/css/mypage.css" rel="stylesheet" />
</head>
<body>
	<div class="con-min-width">
		<div class="con">
			<form action="${contextPath}/mypage/myOrderRefund.do" method="post">
				<div id="contain">
					<!-- 마이페이지 사이드 메뉴 -->
					<div id="mypage_sidebar">
						<jsp:include page="/WEB-INF/views/mypage/myPageSide.jsp" />
					</div>

					<div id="contain_right">
						<p id="mypage_order_title">결제 취소 및 환불</p>
						<table style="margin-bottom: 10px; padding: 3px;">
							<tr>
								<td>주문번호 &nbsp; <span id="gray_color">${myOrderDetail[0].order_seq_num}</span>
								</td>
								<td style="padding-left: 487px;">결제상태 &nbsp; <span
									id="gray_color">${myOrderDetail[0].order_state}</span>
								</td>
							</tr>
						</table>

						<table id="order_detail">
							<!-- 상품 정보 -->
							<tr>
								<td colspan="6"><span id="mypage_info_title">상품 정보</span></td>
							</tr>

							<!-- 1건의 주문에 대한 상품이 2개 이상일 경우 여러개 표시 -->
							<c:forEach var="item" items="${myOrderDetail}" varStatus="j">
								<tr>
									<td width="15%"><input type="hidden" name="cancel"
										value="${item.order_seq_num}">
										<div id="img_file">
											<img alt="img" width="100%" height="100%"
												src="${contextPath}/download.do?product_id=${item.product_id}&fileName=${item.product_main_image}">
										</div></td>
									<td colspan="2"
										style="width: 55%; line-height: 25px; padding-left: 10px;">${item.product_name}<br>
										<span id="gray_color" style="font-size: 15px;">[옵션]
											${item.option_name}</span><br> <span>${item.center_name}</span>
									</td>

									<td align=center width="13%">판매가 <br> 할인가
									</td>
									<td width="13%">${item.product_price}원<br>
										${item.product_sales_price}원
									</td>
							</c:forEach>
						</table>

						<table id="order_detail">
							<!-- 주문자 정보 -->
							<tr>
								<td colspan="6"><span id="mypage_info_title">주문자 정보</span></td>
							</tr>

							<tr>
								<td>&nbsp;&nbsp;구매자</td>
								<td colspan="5">이름 <span id="gray_color">&nbsp;
										${myOrderDetail[0].orderer_name}</span> <br> 전화번호 <span
									id="gray_color">&nbsp;
										${myOrderDetail[0].orderer_hp1}-${myOrderDetail[0].orderer_hp2}-${myOrderDetail[0].orderer_hp3}</span>
								</td>
							</tr>

							<tr>
								<td>&nbsp;&nbsp;이용자</td>
								<td colspan="5">이름 <span id="gray_color">&nbsp;
										${myOrderDetail[0].receiver_name}</span> <br> 전화번호 <span
									id="gray_color">&nbsp;
										${myOrderDetail[0].receiver_hp1}-${myOrderDetail[0].receiver_hp2}-${myOrderDetail[0].receiver_hp3}</span>
								</td>
							</tr>

							<!-- 결제 정보 -->
							<tr>
								<td colspan="6"><span id="mypage_info_title">결제 정보</span></td>
							</tr>

							<tr>
								<td width="10%" style="padding-left: 10px;">주문금액 <br>
									결제수단
								</td>
								<td width="20%"><span id="gray_color">&nbsp;
										${myOrderDetail[0].total_price}원</span> <br> <span
									id="gray_color">&nbsp; ${myOrderDetail[0].pay_method}</span>
								<td width="10%" align=right>은행 <br> 할부기간
								</td>
								<td colspan="3"><span id="gray_color">&nbsp;
										${myOrderDetail[0].card_com_name}</span> <br> <span
									id="gray_color">&nbsp;
										${myOrderDetail[0].card_pay_month}</span></td>
							</tr>

							<!-- 환불 정보 -->
							<tr>
								<td colspan="6"><span id="mypage_info_title">환불 정보</span></td>
							</tr>

							<tr>
								<td align=right colspan="2">예금주 &nbsp; <input type="text"
									size="13" name="account_holder" class="cancel_inputbox"
									required> <br> 취소사유 <select name="cancel_reason"
									class="cancel_inputbox" required>
										<option selected>단순변심</option>
										<option>응대미흡/불친절</option>
										<option>서비스부족</option>
										<option>가격변동</option>
										<option>판매자책임</option>
										<option>기타</option>
								</select>
								</td>

								<td colspan="3">&nbsp;&nbsp; 은행
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select name="account_bank"
									class="cancel_inputbox" required>
										<option selected>선택</option>
										<option>신한은행</option>
										<option>KB국민은행</option>
										<option>IBK기업은행</option>
										<option>NH농협은행</option>
										<option>우리은행</option>
										<option>KDB산업은행</option>
										<option>KEB하나은행</option>
										<option>SH수협은행</option>
										<option>SC제일은행</option>
										<option>한국씨티은행</option>
										<option>우체국</option>
										<option>토스뱅크</option>
										<option>카카오뱅크</option>
										<option>케이뱅크</option>
								</select> <br> &nbsp;&nbsp; 계좌번호 <input type="text" size="15"
									name="account_number" class="cancel_inputbox"
									placeholder="-없이 숫자로만 입력">
								</td>

								<td>환불금액 <span id="gray_color">&nbsp;
										${myOrderDetail[0].product_sales_price
									 +myOrderDetail[1].product_sales_price
									 +myOrderDetail[2].product_sales_price
									 +myOrderDetail[3].product_sales_price
									 +myOrderDetail[4].product_sales_price
									 +myOrderDetail[5].product_sales_price
									 +myOrderDetail[6].product_sales_price
									 +myOrderDetail[7].product_sales_price
									 +myOrderDetail[8].product_sales_price
									 +myOrderDetail[9].product_sales_price
									 +myOrderDetail[10].product_sales_price}
								원</span>
								</td>
							</tr>
						</table>

						<div id="center">
							<input type="submit" class="submit_btn" value="주문취소">

							<button class="submit_btn2"
								onclick="location.href='${contextPath}/mypage/myOrderList.do?member_id=${memberInfo.member_id}'">목록으로</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
