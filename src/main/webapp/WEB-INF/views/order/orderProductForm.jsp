<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!-- 주문자 휴대폰 번호 -->
<c:set  var="orderer_hp" value=""/>
<!-- 최종 결제 금액 -->
<c:set var="final_total_order_price" value="0" />

<!-- 총주문 금액 -->
<c:set var="total_order_price" value="0" />
<!-- 총 상품수 -->
<c:set var="total_order_goods_qty" value="0" />
<!-- 총할인금액 -->
<c:set var="total_discount_price" value="0" />
<!-- 총 배송비 -->
<c:set var="total_delivery_price" value="0" />
<!DOCTYPE html>
<html>
<head>
<link href="${contextPath}/resources/css/order.css?after" rel="stylesheet" type="text/css" media="screen">

</head>
<body>
   <div class="con">
  <div class="orderPay">주문/결제</div>
  <div class="line"></div>
<!-- 상품 정보   -->
  <div class="prodInfo">상품 정보</div>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>상품정보</th>
        <th>판매자</th>
        <th>상품금액</th>
      </tr>
    </thead>
    <tbody style="text-align:center;">
	<c:forEach var="item" items="${myOrderList }">
      <tr>
        <td>
			<img alt="상품 이미지" src="${contextPath}/thumbnails.do?product_id=${item.product_id}&fileName=${item.product_main_image}">
		</td>
        <td>
          <div>${item.product_name}</div>
          <div>[옵션] ${item.product_option_name} (+${item.product_option_price}원)</div>
        </td>
        <td>${item.center_name}</td>
        <td>
          <div style="text-decoration:line-through;">${item.product_price}</div>
          <div>${item.product_sales_price}</div>
        </td>
      </tr>
      </c:forEach>
    </tbody>
  </table>
<!-- 이용자 정보  -->
  <div class="memberInfo">이용자 정보</div>
  <table>
    <tbody>
      <tr>
        <td style="padding-left:40px; color:">구매자 :</td>
        <td><input type="text" value="${orderer.member_name}"></td>
        <td style="margin">
    		<input type="text" value="${orderer.hp1}">-    
	        <input type="text" value="${orderer.hp2}">-<input type="text" value="${orderer.hp3}"></td>
        <td style="width:200px;"></td>
        <td>이용자 :</td>
        <td>${order.receiver_name}</td>
        <td>${receiver_hp1}-${receiver_hp2}-${receiver_hp3}</td>
      </tr>
    </tbody>
  </table>
<!-- 적립금 사용   -->
   <div class="pointInfo">적립금 사용</div>
  <table style="margin-bottom:30px;">
    <tr>
      <th>보유</th>
      <td>${product.product_point}</td>
    </tr>
    <tr>
      <th>적립금 사용</th>
      <td>
        <input type="text" style="margin-right:5px;">원
          <button class="all-use-btn">전액사용</button>
          <input type="checkbox" id="b"><label for="b">항상 전액사용</label>
        </td>
    </tr>
  </table>
<!-- 결제수단   -->
  <div class="payInfo">결제수단</div>
  <div class="line"></div>
  <div class="pay_method">
    <div><input name="method" type="radio">신용카드</div>
    <div><input name="method" type="radio">에스크로(실시간 계좌이체)</div>
    <div><input name="method" type="radio">무통장 입금</div>
    <div><input name="method" type="radio">카카오 페이(간편결제)</div>
    <div><input name="method" type="radio">페이코(간편결제)</div>
  </div>
  
    <span style="margin-left:72px; margin-bottom:20px;">카드 선택:</span>
    <select name='card-op' id="">
      <option value='' selected>선택</option>
      <option value=''>신한은행</option>
      <option value=''>KB국민은행</option>
      <option value=''>IBK기업은행</option>
      <option value=''>NH농협은행</option>
      <option value=''>우리은행</option>
      <option value=''>KDB산업은행</option>
      <option value=''>KEB하나은행</option>
      <option value=''>SH수협은행</option>
      <option value=''>SC제일은행</option>
      <option value=''>한국씨티은행</option>
      <option value=''>우체국</option>
      <option value=''>토스뱅크</option>
      <option value=''>카카오뱅크</option>
      <option value=''>케이뱅크</option>
    </select>
 
    <span>할부 기간:</span>
    <select name="" id="">
      <option value="" selected>일시불</option>
      <option value="">2개월</option>
      <option value="">3개월</option>
      <option value="">4개월</option>
      <option value="">5개월</option>
      <option value="">6개월</option>
    </select>
  
<!-- 최종주문결제내역 -->
  <div class="totalInfo">결제상세</div>
   <table>
     <tr>
       <td>주문금액</td>
       <td>적립금 사용</td>
       <td>최종 결제 내역</td>
       <td>총 적립금
     </tr>
     <tr>
       <td>${order.product_sales_price}</td>
       <td></td>
       <td>70,000원</td>
       <td>1,000원</td>
     </tr>
   </table>
<!-- 버튼 -->
   <div class="submit">
     <button class="submit_btn1">결제하기</button>
     <button class="submit_btn2">취소하기</button>
   </div>
</div>
</body>
</html>
</body>
</html>