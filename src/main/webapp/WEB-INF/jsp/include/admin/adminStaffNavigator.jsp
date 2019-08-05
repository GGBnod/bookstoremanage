<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<div class="navitagorDiv">
	<c:if test="${fn:containsIgnoreCase(staff.department,'管理员')}">
    <nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
		<img style="margin-left:10px;margin-right:0px" class="pull-left" src="img/site/onePiece.png" height="45px">
		<a class="navbar-brand" href="#nowhere">管理员后台</a>
		
		<a class="navbar-brand" href="admin_staff_list">员工管理</a>
		<a class="navbar-brand" href="admin_purchase_list">采购申请审批</a>
		<a class="navbar-brand" href="admin_entrepot_list">仓库管理明细</a>
	</nav>
</c:if>
	
	<c:if test="${fn:containsIgnoreCase(staff.department,'采购部')}">
    <nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
		<img style="margin-left:10px;margin-right:0px" class="pull-left" src="img/site/onePiece.png" height="45px">
		<a class="navbar-brand" href="#nowhere">采购部后台</a>
		<a class="navbar-brand" href="admin_category_list">查看书籍</a>
		<a class="navbar-brand" href="admin_purchase_list">采购申请管理</a>
	</nav>
</c:if>

<c:if test="${fn:containsIgnoreCase(staff.department,'库存部')}">
    <nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
		<img style="margin-left:10px;margin-right:0px" class="pull-left" src="img/site/onePiece.png" height="45px">
		<a class="navbar-brand" href="#nowhere">库存部后台</a>
		
		<a class="navbar-brand" href="admin_entrepot_list">仓库管理</a>
		<a class="navbar-brand" href="admin_category_list">书籍库存管理</a>
	</nav>
</c:if>

	<c:if test="${fn:containsIgnoreCase(staff.department,'前台销售部')}">
    <nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
		<img style="margin-left:10px;margin-right:0px" class="pull-left" src="img/site/onePiece.png" height="45px">
		<a class="navbar-brand" href="#nowhere">前台销售部后台</a>
		
		<a class="navbar-brand" href="admin_user_list">用户管理</a>
		<a class="navbar-brand" href="admin_order_list">订单管理</a>
	</nav>
</c:if>
	
</div>