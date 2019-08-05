<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<script>
	$(function() {
		$("div.homepageCategoryProducts").load("foreload",function() {
		});
		$("div.homepageCategoryProducts").load("foreload",function() {
		});
		
		
		$("div.productsAsideCategorys div.row a").each(function() {
			var v = Math.round(Math.random() * 6);
			if (v == 1)
				$(this).css("color", "#87CEFA");
		});
	});
</script>
<c:forEach items="${cs}" var="c" varStatus="stc">
	<div cid="${c.id}" class="productsAsideCategorys">
		<c:if test="${stc.count>=1}">
			<div class="row">
				<c:forEach items="${c.ms}" var="m" varStatus="stm">
					<c:if test="${!empty m}">
						<a href="foremince?mid=${m.id}"> ${m.name} </a>
					</c:if>
					<c:if test="${stm.count%5==0}">
				<div class="seperator"></div>
					</c:if>
				</c:forEach>
			</div>
		</c:if>
	</div>
</c:forEach>

