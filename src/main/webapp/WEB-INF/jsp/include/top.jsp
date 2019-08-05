<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<nav class="top ">
		<a href="forehome">
			<span style="color:#3B3B71;margin:0px" class=" glyphicon glyphicon-home redColor"></span>
			首页
		</a>	
		
		<span>欢迎进入书城</span>
		
		<c:if test="${!empty user}">
			<a href="#nowhere">${user.name}</a>
			<a href="forelogout">退出</a>		
		</c:if>
		
		<c:if test="${empty user}">
			<a href="JumpLogin">请登录</a>
			<a href="JumpRegister">免费注册</a>
		</c:if>


		<span class="pull-right">
			<a href="forebought">我的订单</a>
			<a href="forecart">
			<span style="color:#3B3B71;margin:0px" class=" glyphicon glyphicon-book redColor"></span>
			书架<strong id="bookNumber">${cartTotalItemNumber}</strong>本</a>		
		</span>
		
		
</nav>



