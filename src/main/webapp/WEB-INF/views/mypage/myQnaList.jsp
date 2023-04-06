<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:set var="questionList"  value="${questionList }"  />
<c:set var="answerList"  value="${answerList }"  />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/mypage.css" rel="stylesheet" />

</head>
<body>
<div class="con-min-width">
	<div class="con">
		<div id="contain">
			<!-- 마이페이지 사이드 메뉴 -->
			<jsp:include page="/WEB-INF/views/mypage/myPageSide.jsp" />
			<div id="contain_right">
			<p id="mypage_Qna_title">Q&A 관리</p>

			<div style="font-size: 20px; margin-right:50px; margin-bottom:15px; text-align:right;">
				작성한 게시글 : <span id="navy_color">${fn:length(questionList)}개</span>
			</div>

      <table class="qna_list">
          <tbody>      
			 <c:choose>
			   <c:when test="${ empty questionList  }" >
				   <tr>
						<td>등록된 Q&A가 없습니다.</td>
			 		</tr>
			   </c:when>
			   <c:otherwise>
		
		            <tr>
		              <th>번호</th>
		              <th>답변상태</th>
		              <th>제목</th>
		              <th>작성일</th>              
		              <th>선택</th>
		            </tr>
		
		  		 <c:set  var="qna_count" value="0" />   
		            <c:forEach var="question" items="${questionList }" > 
					<c:set  var="qna_count" value="${qna_count+1 }" /> 
			          <tr class="qna_item">
			            <td>
			            ${qna_count }
			            </td>	   
			            <td>
			              ${question.qna_answer_state }
			            </td>
							<c:choose>
								<c:when test="${question.qna_secret==1}"> <!-- 비밀글인 경우 -->
						            <td class="toggle_show" style="cursor:pointer;">
						            	<img style="width:24px;height:24px;display:inline;text-align: center"src="https://iconmonstr.com/wp-content/g/gd/makefg.php?i=../releases/preview/2012/png/iconmonstr-lock-4.png&r=0&g=0&b=0" alt="비밀글">
						            	${question.qna_title}                           
						            </td>
								 </c:when>
								<c:otherwise> <!-- 공개글인 경우 -->
						            <td class="toggle_show" style="cursor:pointer;">
						            	${question.qna_title}                           
						            </td>
								</c:otherwise>
						   </c:choose>
			            <td class="qna_writeDate">
			              ${question.qna_write_date}
			            </td>
			            <td class="qna_writer">
			              수정/삭제
			            </td>
			          </tr>
		         
			          <tr class="toggle_hidden">
						    <!-- QnA 질문 내용, 답변 제목, 내용 -->     
						   	<c:choose>
								<c:when test="${question.qna_secret==1}"> <!-- 비밀글인 경우 -->
						            <td class="qna_contents" colspan="5">
						            	<p><span class="Q_mark">Q</span> ${question.qna_contents} </p>  <!-- 질문 내용 -->
						            <c:forEach var="answer" items="${answerList }" >             	
						            	<c:choose>
							            	<c:when test="${question.qna_no == answer.qna_parent_no }"> 
								            	<p><span class="A_mark">A</span> ${answer.qna_title} <p> <!-- 답글 제목 -->
								            	<p style="padding-left:40px;">${answer.qna_contents} <p> <!-- 답글 내용 -->
						            		</c:when>
						            	</c:choose>
					            	</c:forEach>                   
						            </td>
						        </c:when>
						        
						        <c:otherwise> <!-- 공개글인 경우 -->
						            <td colspan="5" class="qna_contents"  >
						            	<p><span class="Q_mark">Q</span> ${question.qna_contents}</p>  <!-- 질문 내용 -->
						            <c:forEach var="answer" items="${answerList }" > 
						            	<c:choose>
							            	<c:when test="${question.qna_no == answer.qna_parent_no }"> 
								            	<p><span class="A_mark">A</span> ${answer.qna_title} </p> <!-- 답글 제목 -->
								            	<p style="padding-left:40px;">${answer.qna_contents} <p> <!-- 답글 내용 -->
						            		</c:when>
						            	</c:choose>
						            	</c:forEach>                     
						            </td>
						        </c:otherwise>
							  </c:choose>
			    	      </tr>
		              </c:forEach>
			     </c:otherwise>
			</c:choose>
        </tbody>
      </table>
			
			</div>
		</div>
	</div>
</div>
</body>
</html>