<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<c:if test="${empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="100" />
</c:if>

<c:if test="${!empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="${param.categorycount}" />
</c:if>


<div class="homepageCategoryProducts">
	<c:forEach items="${cs}" var="c" varStatus="stc">
		<c:if test="${stc.count<=20}">
			<c:forEach items="${c.ms}" var="m" varStatus="stm">
				<div class="eachHomepageCategoryProducts">
					<c:if test="${stm.count<=1 && fn:length(m.bs)>=5}">
						<div class="left-mark"></div>
						<span class="categoryTitle">${m.name}</span>
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
									</a> <span class="productPrice"
										style="position: relative; top: 15px"><span
										style="color: #000;">价格：</span> <fmt:formatNumber
											type="number" value="${b.price}" minFractionDigits="2" /> ￥</span>
								</div>
							</c:if>
						</c:forEach>
					</c:if>
					<div style="clear: both"></div>
				</div>
			</c:forEach>
		</c:if>
	</c:forEach>

	<script>
		$(function() {
			$("[data-toggle='tooltip']").tooltip();
		});
	</script>


	<img id="endpng" class="endpng" src="img/site/end.png">

</div>