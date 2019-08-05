<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	$(function() {

		$("#addForm").submit(function() {
			if (!checkEmpty("name", "分类名称"))
				return false;
			return true;
		});
	});
</script>

<title>采购清单阅览</title>


<div class="workingArea">
	<c:if test="${fn:containsIgnoreCase(staff.department,'采购部')}">
		<a href="admin_staff_purchase"><h1 class="label label-info">采购申请</h1></a>
	</c:if>
	<br> <br>

	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="20%">清单编号</th>
					<th width="20%">申请人</th>
					<th width="20%">采购总量</th>
					<th width="20%">采购理由</th>
					<th width="20%">审批</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ps}" var="p">

					<tr>
						<td><a href="admin_purchase_edit?id=${p.id}">${p.number}</a></td>
						<td>${p.staff.name}</td>
						<td>${p.total}</td>
						<td>${p.reason}</td>
						<td><c:if test="${ fn:containsIgnoreCase(p.opinion,'待定')}">
								<font color='red'>未审批</font>
							</c:if> <c:if test="${! fn:containsIgnoreCase(p.opinion,'待定')}">
								<font color='green'>已审批</font>
							</c:if></td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp"%>
	</div>

</div>

<%@include file="../include/admin/adminFooter.jsp"%>