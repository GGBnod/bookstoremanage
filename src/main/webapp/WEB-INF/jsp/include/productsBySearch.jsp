<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<div class="searchProducts">

	<c:forEach items="${bs}" var="b">
		<div class="productUnit" price="${b.price}">
			<a href="forebook?bid=${b.id}"><img src="img/book/${b.id}.jpg"
				class="productImage"></a>
			<div style="font-size: 14px; height: 25%" align="center"
				class="productItemDesc">
				<a href="forebook?bid=${b.id}" style="">${b.name}</a>
				<div style="font-size: 12px;" align="center" class="productItemDesc">作者：${b.author}</div>
				<div style="font-size: 12px;" align="center" class="productItemDesc">出版社：${b.publis}</div>
			</div>

			<span class="productPrice "><span style="color: #000;">价格：</span>
				<fmt:formatNumber type="number" value="${b.price}"
					minFractionDigits="2" /> ￥</span>

			<div class="show1 productInfo">
				<span class="monthDeal ">月成交 <span class="productDealNumber">${b.saleCount}笔</span></span>
				<span class="productReview">评价<span
					class="productReviewNumber">${b.reviewCount}</span></span>

			</div>

		</div>
	</c:forEach>
	<c:if test="${empty bs}">
		<div class="noMatch">
			没有满足条件的产品
			<div>
	</c:if>

	<div style="clear: both"></div>
</div>