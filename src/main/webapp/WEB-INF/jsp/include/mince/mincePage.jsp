<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<title>${m.name}</title>	
<div id="category">
	<div class="categoryPageDiv">
		<img src="img/mince/${m.id}.jpg">
		<%@include file="sortBar.jsp"%>
		<%@include file="booksBymince.jsp"%>
	</div>

</div>