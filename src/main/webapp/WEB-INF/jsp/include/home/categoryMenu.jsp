<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<div class="categoryMenu">
	<div style="overflow: auto; width: 200px; height: 510px;" dir="rtl">
		<c:forEach items="${cs}" var="c">
			<div dir="ltr" cid="${c.id}" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span> <a
					href="forecategory?cid=${c.id}"> ${c.name} </a>
			</div>
		</c:forEach>
	</div>

</div>
