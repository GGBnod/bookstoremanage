<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>


<c:if test="${empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="100" />
</c:if>

<c:if test="${!empty param.categorycount}">
	<c:set var="categorycount" scope="page" value="${param.categorycount}" />
</c:if>

<div class="categoryProducts">
	<c:forEach items="${m.bs}" var="b" varStatus="stb">
			<div class="productItem" align="center">
				<a href="forebook?bid=${b.id}"><img width="100px"
					src="img/book/${b.id}.jpg" class="img-thumbnail"></a> <a
					class="productItemDescLink" href="forebook?bid=${b.id}"> <span
					class="productItemDesc">[热销] ${b.name}<br>
						作者：${b.author}
				</span>
				</a> <span class="productPrice"><span style="color: #000;">价格：</span>
					<fmt:formatNumber type="number" value="${b.price}"
						minFractionDigits="2" /> ￥</span>
			</div>
	</c:forEach>


	<div style="clear: both"></div>
</div>