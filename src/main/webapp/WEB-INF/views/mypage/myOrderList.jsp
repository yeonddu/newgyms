<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/mypage.css" rel="stylesheet" />
<style>
@charset "UTF-8";
@font-face {
	font-family: 'GmarketSansMedium';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

* {
	font-family: 'GmarketSansMedium';
	margin: 0px;
	padding: 0px;
}

body {
	margin: 0;
	padding: 0;
}

#contain {
	display: flex;
}

#contain_right {
	width: 1000px;
}

#center {
	padding-left: 125px;
}

#mypage_order_title {
	margin-top: 30px;
	margin-bottom: 20px;
	padding: 5px;
	padding-left: 275px;
	font-size: 25px;
}

#mypage_info_title {
	font-size: 20px;
	color: #0F0573;
}

#order_detail {
	width: 77%;
	padding: 10px;
	line-height: 40px;
	border-top: 2px solid #D8D8D8;
	border-bottom: 2px solid #D8D8D8;
}

#order_detail td {
	border-bottom: 1px solid #D8D8D8;
}

#order_detail2 {
	width: 77%;
	padding: 10px;
	line-height: 40px;
	border-top: 2px solid #D8D8D8;
	border-bottom: 2px solid #D8D8D8;
}

#order_detail2 td {
	border-bottom: 1px solid #D8D8D8;
	text-align: center;
}

#detail_image {
	width: 80px;
	height: 80px;
	border-radius: 5px;
}

#gray_color {
	color: #848484;
}

#navy_color {
	color: #0F0573;
}

.submit_btn {
	margin: 20px 5px 10px 5px;
	border: none;
	width: 250px;
	padding: 10px;
	text-align: center;
	font-size: 15px;
	color: #FFFFFF;
	background-color: #0F0573;
	text-decoration: none;
	border-radius: 5px;
}

.submit_btn:hover {
	cursor: pointer;
}

.submit_btn2 {
	margin: 20px 5px 10px 5px;
	border: 1px solid #0F0573;
	width: 250px;
	padding: 10px;
	text-align: center;
	font-size: 15px;
	color: #0F0573;
	background-color: #FFFFFF;
	text-decoration: none;
	border-radius: 5px;
}

.submit_btn2:hover {
	cursor: pointer;
}

#mypage_sidebar {
	width: 200px;
	height : 265px;
	padding : 10px;
	margin-right : 15px;
	margin-top : 83px;
	font-size : 17px;
	text-align : center;
	line-height : 40px;
	border : 2px solid #0F0573;
	border-radius : 5px;
}
#mypage_hr {
	border-bottom: 2px solid #0F0573;
}

#mypage_sidebar>ul>li {
	font-size: 15px;
}

#mypage_sidebar>ul>li:hover>a {
	text-decoration: underline;
	text-underline-position: under;
	color: #F9C200;
}

.cancel_inputbox {
	margin-left: 5px;
	padding: 5px;
	border: none;
	border-bottom: 1px solid #D8D8D8;
}

#upper_menu {
	width: 78%;
	display: flex;
	justify-content: space-evenly;
	margin-bottom: 10px;
}

#upper_menu ul li {
	display: inline;
}
.mypage_inputbox {
	padding : 3px;
    border : none;
	border-bottom : 1px solid #D8D8D8;
}
#search_button {
	margin-left: 5px;
	border: 1px solid #0F0573;
	width: 60px;
	height: 30px;
	text-align: center;
	font-size: 12px;
	color: #0F0573;
	background-color: #FFFFFF;
	border-radius: 5px;
}
#text_box {
	height: 25px;
	text-align: center;
	font-size: 11px;
}

#img_file {
	margin : 5px;
	border: 1px solid #D8D8D8;
	width: 100px;
	height: 100px;
	border-radius: 5px;
}

#btn_1 {
	display : inline-block;
	border: none;
	width: 60px;
	height: 30px;
	text-align: center;
	font-size: 12px;
	color: #FFFFFF;
	background-color: #0F0573;
	border-radius: 5px;
}
input#btn1:hover {
	cursor : pointer;
}

#btn_2 {
	margin-top: 5px;
	border: 1px solid black;
	width: 60px;
	height: 30px;
	text-align: center;
	font-size: 12px;
	color: #0F0573;
	background-color: #FFFFFF;
	border-radius: 5px;
}

button:hover {
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="con-min-width">
		<div class="con">
			<div id="contain">
				<!-- 마이페이지 사이드 메뉴 -->
				<jsp:include page="/WEB-INF/views/mypage/myPageSide.jsp" />


				<form action="${contextPath}/mypage/myOrderDetail.do" method="get">
					
					<div id="contain_right">
						<p id="mypage_order_title">결제 내역 조회</p>

						<!-- 상단 메뉴 -->
						<div id="upper_menu">
							<ul>
								<li>
									<span id="navy_color"> 결제상태 </span>
									<select class="mypage_inputbox" style="margin-right:15px;">
										<option value="all" selected>전체</option>
										<option value="complete">결제완료</option>
										<option value="cancel">결제취소</option>
										<option value="refund">환불완료</option>
									</select>
								</li>
								<li>
									<span id="navy_color"> 조회기간 </span>
										<input type="date" id="firstDate" class="mypage_inputbox"> ~ 
										<input type="date" id="secondDate" size="15" class="mypage_inputbox" style="margin-right:15px;">
								</li>
								<li>
									<input type="text" placeholder="검색어를 입력하세요." 	size="15" class="mypage_inputbox">
									<button id="search_button">검색</button>
								</li>
							</ul>
						</div>

						<!-- 조회된 결제 내역 -->
						<c:choose>
							<c:when test="${empty myOrderList}">
								<table id="order_detail2" align=center>
									<tr>
										<td width="5%">번호</td>
										<td width="15%">결제일자</td>
										<td width="10%"></td>
										<td width="35%">상품정보</td>
										<td width="15%">결제금액</td>
										<td width="10%">결제상태</td>
										<td width="10%">선택</td>
									</tr>
									<tr>
										<td colspan="7" style="color: blue;">조회된 결제 내역이 없습니다. 😂</td>
									</tr>
								</table>

							</c:when>
							<c:otherwise>
								<table id="order_detail2" align=center>
									<tr>
										<td width="5%">번호</td>
										<td width="15%">결제일자</td>
										<td width="15%"></td> <!-- 사진 -->
										<td width="30%">상품정보</td>
										<td width="15%">결제금액</td>
										<td width="10%">결제상태</td>
										<td width="10%">선택</td>
									</tr>

									<hr style="width: 770px; border: 1px solid #0F0573; margin-bottom:20px;">
									<span style="margin-bottom: 10px; padding: 3px;"> 총 n건 </span>
									<c:forEach var="item" items="${myOrderList}" varStatus="j">

										<tr>
											<td>${item.order_seq_num}</td>
											<td style="font-size:14px;">${item.pay_order_time}</td>
											<td align=center>
												<div id="img_file">
													<img alt="img" width="100%" height="100%" 
														src="${contextPath}/download.do?product_id=${item.product_id}&fileName=${item.product_main_image}">
												</div>
											</td>
											<td style="text-align: left; line-height:25px;">${item.product_name}<br> <span
												id="gray_color" style="font-size: 15px;">[옵션]
													${item.option_name}</span>
											</td>
											<td>${item.total_price}원</td>
											<td>${item.order_state}</td>
											<td>
												<a href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id}" style="line-height:32px;"><span id="btn_1">상세조회</span></a>
												<br>
												<button id="btn_2"
													onclick="location.href='${contextPath}/mypage/myOrderDetail.jsp'">후기작성</button>
											</td>
										</tr>
									</c:forEach>
								</table>

							</c:otherwise>
						</c:choose>
					</div>
				</form>
			</div>

			<%--   <TABLE class="list_view">
      <TBODY align=center >
   <c:choose>
     <c:when test="${empty newGoodsList }">         
         <TR>
             <TD colspan=8 class="fixed">
              <strong>조회된 상품이 없습니다.</strong>
            </TD>
           </TR>
    </c:when>
    <c:otherwise>
     <c:forEach var="item" items="${newGoodsList }">
         <table id = "line3">
    <td style = "width : 20px;">${item.order_seq_num }</td><td style = "width : 50px;"></td><td  style = "width : 100px; text-align : center;">${item.pay_order_time }</td>
    <td style = "width : 70px;"></td><td><img id ="imgfile"/></td>
    <td style = "width : 200px;">${item.product_name }<br><div style = "color : #BDBDBD;">[옵션] ${item.product_option_name }(+product_option_price)</div></td>
    <td style = "width : 60px;"></td><td style = "width : 80px; text-align : center;">${item.totalprice }</td><td style = "width : 30px;"></td>
    <td style = "width : 70px; text-align : center;">${item.order_state }</td><td style = "width : 30px;"></td>
    <td><button id="Button1">상세조회</button><br><button id="Button2">후기작성</button></td>
  </table>
       <hr style = "border : 1px solid black;">
   </c:forEach>
   </c:otherwise>
  </c:choose>
        
           <tr>
             <td colspan=8 class="fixed">
                 <c:forEach   var="page" begin="1" end="10" step="1" >
               <c:if test="${section >1 && page==1 }">
                <a href="${contextPath}/mypage/myPageMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; &nbsp;</a>
               </c:if>
                <a href="${contextPath}/mypage/myPageMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
               <c:if test="${page ==10 }">
                <a href="${contextPath}/mypage/myPageMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp; next</a>
               </c:if> 
               </c:forEach>
             </td>
        </tr>
      </TBODY>
   </TABLE> --%>
		</div>
	</div>
</body>
</html>