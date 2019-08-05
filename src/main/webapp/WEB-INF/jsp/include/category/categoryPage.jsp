<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<title>${c.name}</title>
<div id="category">
	<div class="categoryPageDiv">

		<div
			style="margin: 90px 0px 50px 0px; background-color: #F2F2F2; height: 150px; border: 1px solid #CB9034;">
			<div
				style="color: #734800; padding: 5px; font-weight: bold; font-size: 24px">${c.name }</div>
			<c:forEach items="${c.ms}" var="m" varStatus="stm">
				<span style="padding: 3px; border-right: 2px solid #000;"
					class="categoryTitle"><a href="foremince?mid=${m.id}">${m.name}</a></span>

			</c:forEach>
		</div>

		<%@include file="productsByCategory.jsp"%>
	</div>

</div>