<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<title>${b.name}</title>
<div class="categoryPictureInProductPageDiv">
	<img class="categoryPictureInProductPage" src="img/mince/${b.mince.id}.jpg">
</div>

<div class="productPageDiv">

	<%@include file="imgAndInfo.jsp" %>
	
	<%@include file="bookReview.jsp" %>

	<%@include file="bookDetail.jsp" %>
</div>