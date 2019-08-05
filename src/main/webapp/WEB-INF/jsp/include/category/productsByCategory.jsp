<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>


<c:if test="${empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="100" />
</c:if>

<c:if test="${!empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="${param.categorycount}" />
</c:if>

<div class="categoryProducts">
	<c:forEach items="${c.ms}" var="m" varStatus="stm">
		<div class="eachHomepageCategoryProducts">
			<div class="left-mark"></div>
			<span class="categoryTitle"><a href="foremince?mid=${m.id}">${m.name}</a></span>
			<br>

			<c:forEach items="${m.bs}" var="b" varStatus="stb">
				<c:if test="${stb.count<=5}">
					<div class="productItem" align="center">
						<a href="forebook?bid=${b.id}"><img width="100px"
							src="img/book/${b.id}.jpg" class="img-thumbnail"></a> <a
							class="productItemDescLink" href="forebook?bid=${b.id}"> <span
							class="productItemDesc" data-toggle="tooltip"
							data-placement="top" title="${b.name}">[热销]<c:if
									test="${fn:length(b.name)>9}">
											${fn:substring(b.name,0,9)}...</c:if> <c:if
									test="${fn:length(b.name)<=9}">
											${b.name}</c:if></span><span>作者：<c:if
									test="${fn:length(b.author)>9}">
											${fn:substring(b.author,0,9)}</c:if> <c:if
									test="${fn:length(b.author)<=9}">
											${b.author}</c:if>
						</span>
						</a> <span class="productPrice" style="position: relative; top: 15px"><span
							style="color: #000;">价格：</span> <fmt:formatNumber type="number"
								value="${b.price}" minFractionDigits="2" /> ￥</span>
					</div>
				</c:if>
			</c:forEach>

			<div style="clear: both"></div>
		</div>
	</c:forEach>
	<div style="clear: both"></div>
</div>
<script>
	$(function() {
		$("[data-toggle='tooltip']").tooltip();
	});
</script>