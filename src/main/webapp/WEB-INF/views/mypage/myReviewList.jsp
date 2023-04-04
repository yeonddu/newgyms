<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/mypage.css" rel="stylesheet" />
<script src="${contextPath}/resources/jquery/order.js"
	type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
   $('.review_emtify_btn').on('click', function() {
      var review_no = $(this).find('#review_no').val(); //누른 review의 review_no 가져오기
      $.ajax({
         type : "GET",
         async : false,
         url : "${contextPath}/review/viewReview.do",
         data : {
            review_no : review_no,
         },
         dataType : 'json',
         contentType : "application/json;charset=UTF-8",
         success : function(data) {
         var reviewVO = data.reviewVO
         var imageList = data.ImageList
         
         var review_no = reviewVO.review_no;
         var product_id = reviewVO.product_id;
         var product_main_image = reviewVO.product_main_image;
         var product_name = reviewVO.product_name;
         var center_name = reviewVO.center_name;
         var member_id = reviewVO.member_id;
         var review_write_date = reviewVO.review_write_date;
         var product_option_name = reviewVO.product_option_name;
         
         
         var product_option_price = Number(reviewVO.product_option_price.replace(/,/g, '')); 
         var review_score = reviewVO.review_score;
         var review_title = reviewVO.review_title;
         var review_contents = reviewVO.review_contents;
         
         //초기화
            $('#product_id').empty();
            $('#product_main_image').empty();
            $('#product_name').empty();
            $('#center_name').empty();
            $('#member_id').empty();
            $('#review_write_date').empty();
            $('#product_option_name').empty();
            $('#product_option_price').empty();
            $('#review_score').empty();
            $('#review_title').empty();
            $('#review_contents').empty();
            $('#review_imageList').empty();
            
         // 값 대입
            $('#product_id').append(product_id);
            $('#product_main_image').append("<img alt='상품 메인이미지' src='${contextPath}/thumbnails.do?product_id="+product_id+"&fileName="+product_main_image+"'>");
            $('#product_name').append(product_name);
            $('#center_name').append(center_name);
            $('#member_id').append(member_id);
            $('#review_write_date').append(review_write_date);
            $('#product_option_name').append(product_option_name);
            $('#product_option_price').append(product_option_price);
            
            if(review_score == 1) {
               $('#review_score').append("<div class='review_score'>★☆☆☆☆</div>");
            } else if (review_score == '2') {
               $('#review_score').append("<div class='review_score'>★★☆☆☆</div>");
            } else if (review_score == '3') {
               $('#review_score').append("<div class='review_score'>★★★☆☆</div>");
            } else if (review_score == '4') {
               $('#review_score').append("<div class='review_score'>★★★★☆</div>");
            } else if (review_score == '5') {
               $('#review_score').append("<div class='review_score'>★★★★★</div>");
            }

            $('#review_title').append(review_title);
            $('#review_contents').append(review_contents);
            
         var imageList_length = Object.keys(imageList).length;
            
         for (var i=0;i<imageList_length;i++) {
            var fileName = imageList[i].fileName;
            $('#review_imageList').append("<img class='review_image' alt='이용후기 이미지' src='${contextPath}/reviewImage.do?review_no="+review_no+"&fileName="+fileName+"'>");
         }
            
         }
      });
   });
});      
</script>
</head>
<body>
	<form action="${contextPath}/mypage/myReviewList.do" method="get">
		<input type="hidden" name="member_id" value="${member_id}"> <input
			type="hidden" name="chapter" value="1">
		<div class="con-min-width">
			<div class="con">
				<div id="contain">
					<!-- 마이페이지 사이드 메뉴 -->
					<jsp:include page="/WEB-INF/views/mypage/myPageSide.jsp" />
					<div id="contain_right">
						<p id="mypage_order_title">이용후기 조회</p>
						<a class="btn-open-popup" href="#modal1">조회하기</a>

						<!-- 조회된 이용후기 -->
						<c:choose>
							<c:when test="${empty myReviewList}">
								<table id="order_detail2" align=center>
									<tr>
										<th width="15%">번호</th>
										<th width="45%">상품명</th>
										<th width="15%" colspan="2">제목</th>
										<th width="15%">등록일</th>
										<th width="10%">선택</th>
									</tr>
									<tr>
										<td colspan="7" style="color: blue;">작성하신 이용후기가 없습니다. 😂</td>
									</tr>
								</table>
							</c:when>
							<c:otherwise>
								<table id="order_detail2" align=center>
									<tr>
										<th width="15%">번호</th>
										<th width="45%">상품명</th>
										<th width="15%" colspan="2">제목</th>
										<th width="15%">등록일</th>
										<th width="10%">선택</th>
									</tr>
									<!-- 검색내역 리스트 -->
									<c:forEach var="item" items="${myReviewList}"
										varStatus="status">
										<c:set var="i" value="${i+1}" />
										<tr>
											<!-- 번호 -->
											<td width="15%" style="font-size: 14px;">${maxnum-i+1}</td>
											<!-- 상품명 -->
											<td style="text-align: left; line-height: 25px;">${item.product_name }<br>
												<span id="gray_color" style="font-size: 14px;">[옵션]
													${item.product_option_name}(+<fmt:formatNumber
														value="${item.product_option_price}" type="number" />원)
											</span>
											</td>
											<!-- 제목 -->
											<td style="line-height: 25px;">${item.review_title}</td>
											<!-- 등록일 -->
											<td width="15%" style="font-size: 14px;">${item.review_write_date}</td>
											<!-- 선택 -->
											<td width="10%"><div class="review_emtify_btn"
													onClick="javascript:reviewPopup('open');"
													style="line-height: 32px;">
													<span id="btn_1">수정하기</span> <input type="hidden"
														id="review_no" value="${item.review_no}">
												</div> <a
												href="${contextPath}/mypage/myReviewDelete.do?review_no=${item.review_no}&member_id=${member_id}"
												style="line-height: 32px;"><span id="btn_1">삭제하기</span></a>
											</td>
										</tr>
									</c:forEach>

								</table>

							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div style="text-align: center;">
					<a
						href="${contextPath}/mypage/myReviewList.do?chapter=${chapter-1}&member_id=${member_id}&firstDate=${firstDate}&secondDate=${secondDate}&text_box=${text_box}">&#60;</a>
					<c:forEach var="page" begin="1" end="${Math.ceil(maxnum/5)}"
						step="1">
						<c:set var="section_num" value="${section_num+1}" />
						<a
							href="${contextPath}/mypage/myReviewList.do?chapter=${section_num}&member_id=${member_id}&firstDate=${firstDate}&secondDate=${secondDate}&text_box=${text_box}">${section_num }</a>
					</c:forEach>
					<a
						href="${contextPath}/mypage/myReviewList.do?chapter=${chapter+1}&member_id=${member_id}&firstDate=${firstDate}&secondDate=${secondDate}&text_box=${text_box}">&#62;</a>

				</div>
			</div>
		</div>
		<!-- 모달 매뉴 -->
		<div class="modal" id="modal1">
			<div class="modal_body">
				<ul>
					<li><input type="text" placeholder="검색어를 입력하세요" id="text_box"
						name="text_box" style="width: 300px;"></li>
					<li id="easycheck"><a id="fYear">최대(5년)</a> <a href="#"
						id="oMon">1개월</a> <a href="#" id="tMon">3개월</a> <a href="#"
						id="fMon">5개월</a></li>
					<li><span> <input type="date" name="firstDate"
							value="${firstDate}"> ~ <input type="date"
							name="secondDate" value="${secondDate}">
					</span></li>
					<li><input type="submit" id="modal_botton" value="조회하기"></li>
				</ul>
			</div>
		</div>


		<!-- 이용후기 수정창 -->
		<div id="review_change_popup" style="visibility: hidden">



			<div class="product_info">
				<div id="product_main_image" style="width: 300px; height: 200px;"></div>

				<div>
					<a class="product_name"
						href="${contextPath}/product/productDetail.do?product_id=${review.product_id}"><span
						id="product_name">${review.product_name }</span></a>
				</div>
				<div>
					<a class="center_name" href="#"> <span id="center_name"></span></a>
				</div>
			</div>

			<div class="review_info">
				<p>
					작성자 <span id="member_id"></span>
				</p>
				<p>
					작성일 <span id="review_write_date"></span>
				</p>

				<div>
					<p class="product_option">
						[옵션] <span id="product_option_name"></span> (+<span
							id="product_option_price"><fmt:formatNumber value=""
								type="number" /></span>원)
					</p>
					<div id="review_score" style="clear: both; font-size: 15px"></div>
				</div>
			</div>

			<div class="review_detail">
				<p class="review_title">
					제목 : <span id="review_title"></span>
				</p>
				<p class="review_contents">
					내용 : <span id="review_contents"></span>
				</p>
			</div>

			<div>
				<a class="x_button" href="javascript:"
					onClick="javascript:reviewPopup('close', '.layer01');">목록으로</a>
			</div>
		</div>


		<script>
      // 조회창 띄우기
      const modal = document.querySelector('.modal');
      const btnOpenPopup = document.querySelector('.btn-open-popup');

      btnOpenPopup.addEventListener('click', () => {
        modal.classList.toggle('show');

        if (modal.classList.contains('show')) {
           modal.style.overflow = 'hidden';
        }
      });

      modal.addEventListener('click', (event) => {
        if (event.target === modal) {
          modal.classList.toggle('show');

          if (!modal.classList.contains('show')) {
             modal.style.overflow = 'auto';
          }
        }
      });
      // 수정창 열고 닫기
     function reviewPopup(type) {
   if (type == 'open') {
      $('#review_change_popup').attr('style', 'visibility:visible');
      
   } else if (type == 'close') {
      $('#review_change_popup').attr('style', 'visibility:hidden');
   }
}
      /* easycheck 처리함수 */
       $(document).ready(function(){
    $("#fYear").click(changeDate);
   });
      function changeDate() {
         $.ajax({
              type : 'GET',           
              url : '${contextPath}/mypage/myReviewList.do',
              async : true,
              dataType : 'json',
              data :{
                 "chapter" : chapter,
                 "member_id" : member_id,
                 "order_state" : order_state,
                  "firstDate" : firstDate,
                 "secondDate" : secondDate,
                 "text_box" : text_box
              },
              success: function(result) {
                    if (result) {
                        alert("완료");
                    } else {
                        alert("전송된 값 없음");
                    }
                },
                error: function() {
                    alert("에러 발생");
                }
          })
   }
    </script>
	</form>
</body>
</html>