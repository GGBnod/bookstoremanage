<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<div style="max-width: 1013px;
	margin: 10px auto;position: relative;">
	<div style="position: relative;top: -43px"><a href="${contextPath}">
		<img id="simpleLogo" width="200px" height="60px" class="simpleLogo" src="img/site/simpleLogo.png">	
	</a></div>

	<form action="foresearch" method="post" >	
	<div class="simpleSearchDiv pull-right">
		<input type="text" placeholder="Java21天从精通到入门" style="padding-left: 10px"  value="${param.keyword}" name="keyword">
		<button class="searchButton" type="submit">搜索</button>
		<div class="searchBelow">
			<c:forEach items="${cs}" var="c" varStatus="st">
				<c:if test="${st.count>=8 and st.count<=11}">
					<span>
						<a href="forecategory?cid=${c.id}">
							${c.name}
						</a>
						<c:if test="${st.count!=11}">				
							<span>|</span>				
						</c:if>
					</span>			
				</c:if>
			</c:forEach>			
		</div>
	</div>
	</form>
	<div style="clear:both"></div>
</div>