<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 목록 조회</title>

</head>
<body>


<div id="ProductByAddress">

    <ul>
                  <li><a href="${contextPath}/product/productByAddress.do?address=대전">전체보기</a></li>
                  <li><a href="${contextPath}/product/productByAddress.do?address=유성구">유성구</a></li>
                  <li><a href="${contextPath}/product/productByAddress.do?address=대덕구">대덕구</a></li>
                  <li><a href="${contextPath}/product/productByAddress.do?address=서구">서구</a></li>
                  <li><a href="${contextPath}/product/productByAddress.do?address=중구">중구</a></li>
                  <li><a href="${contextPath}/product/productByAddress.do?address=동구">동구</a></li>
     </ul>
</div>
<jsp:include page="/WEB-INF/views/product/productList.jsp"/>
</body>
</html>