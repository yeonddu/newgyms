<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<link href="${contextPath}/resources/css/customer.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	function backToList(obj) {
		obj.action = "${contextPath}/event/listEvents.do";
		obj.submit();
	}

	var cnt = 1;
	function fn_addFile() {
		$("#d_file.").append(
				"<br>" + "<input type='file' name='file"+cnt+"' />");
		cnt++;
	}
</script>

</head>
<body>
	<div class="con-min-width">
		<div class="con">
			<div id="contain">
				<!-- 커뮤니티 사이드 메뉴 -->
				<jsp:include page="/WEB-INF/views/common/customerSide.jsp" />

				<div id="contain_right">
					<p id="event_title">이벤트 글 쓰기</p>
					<form name="eventForm" method="post"
						action="${contextPath}/event/addNewEvent.do"
						enctype="multipart/form-data">

						<table id="event_table" align=center>
							<!-- 제목 -->
							<tr>
								<td width="10%"><span id="event_textbox">제목</span></td>
								<td colspan="3" align=left><input type="text" size="91"
									class="event_inputbox" maxlength="50" name="event_title"
									placeholder="제목을 입력하세요." required /></td>
							</tr>

							<!-- 작성자 아이디 -->
							<tr>
								<td><span id="event_textbox">아이디</span></td>
								<td align=left><input type="text" size="10"
									class="event_inputbox" maxlength="20"
									value="${memberInfo.member_id}" name="member_id" readonly /></td>

							<!-- 이벤트 기간 -->
								<td width="5%" rowspan="2"><span id="event_textbox">기간</span>
								</td>
								<td align=left rowspan="2"><input type="date"
									name="event_start_date" class="event_inputbox" required> ~ <input
									type="date" name="event_end_date" class="event_inputbox" required>
								</td>
							</tr>

							<!-- 사업장명 -->
							<tr>
								<td><span id="event_textbox">사업장명</span></td>
								<td align=left><input type="text" size="10"
									class="event_inputbox" maxlength="20"
									value="${memberInfo.center_name}" name="center_name" readonly required />
								</td>
							</tr>

							<!-- 내용 -->
							<tr>
								<td><span id="event_textbox">내용</span></td>
								<td colspan="3" align=left><textarea name="event_content"
										rows="20" cols="90" maxlength="4000"
										placeholder="내용을 입력하세요. (최대 4000자)"
										style="margin-top: 10px; margin-bottom: 20px; padding: 15px; border: 1px solid #D8D8D8" required></textarea></td>
							</tr>

							<!-- 상품번호 & 상품명 -->
							<tr>
								<td><span id="event_textbox">상품명</span></td>
								<td align=left>
									<input type="text" size="10"
									class="event_inputbox" maxlength="20"
									name="product_id" />
									<input type="text" size="10"
									class="event_inputbox" maxlength="20"
									name="product_name" required />
								</td>
							</tr>

							<!-- 이미지 첨부 -->
							<tr>
								<td><span id="event_textbox">사진</span></td>
								<td width="300px"><img id="preview"
									src="${contextPath}/resources/image/jss.png" /></td>
								<td align=left style="padding-left: 20px;" colspan="2"><input
									type="file" name="event_image" onchange="readURL(this);"></td>
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
</body>
</html>

