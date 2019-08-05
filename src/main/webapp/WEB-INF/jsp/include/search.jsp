<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<div class="container">
	<div class="row">

		<div class="col-xs-2 " align="center">
			<img style="position: absolute; top: 0px;" id="logo"
				src="img/site/logo2.png" width="380px" height="150px"
				class="logo img-rounded">

		</div>
		<div class="col-xs-8 " align="center"></div>
		<div class="col-xs-2 " align="center">
			<img id="logo" src="img/site/logo1.gif" width="200px" height="100px"
				class="logo img-rounded">

		</div>
	</div>
</div>




<form action="foresearch" method="post">
	<div class="searchDiv" style="background-color: #FF2832">
		<input name="keyword" type="text" style="padding: 10px"
			value="${param.keyword}" placeholder="金梅瓶  三国演义">
		<button type="submit" class="searchButton"
			style="background-color: #FF2832">搜索</button>
		<div class="searchBelow">
			<c:forEach items="${cs}" var="c" varStatus="st">
				<c:if test="${st.count>=5 and st.count<=8}">
					<span> <a href="forecategory?cid=${c.id}"> ${c.name} </a> <c:if
							test="${st.count!=8}">
							<span>|</span>
						</c:if>
					</span>
				</c:if>
			</c:forEach>
		</div>
	</div>
</form>
