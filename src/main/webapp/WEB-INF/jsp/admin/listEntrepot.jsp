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
	<c:if test="${fn:containsIgnoreCase(staff.department,'库存部')}">
		<a href="admin_entrepot_add"><h1 class="label label-info">添加库存清单</h1></a>
	</c:if>
	<br> <br>

	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="20%">编号</th>
					<th width="20%">日期</th>
					<th width="20%">入库数量</th>
					<th width="20%">出库数量</th>
					<th width="20%">仓库人员</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${es}" var="e">

					<tr>
						<td><c:if test="${! empty e.complete}">
								<a href="admin_entrepot_see?eid=${e.id}">${e.num}</a>
							</c:if> <c:if test="${empty e.complete}">
								<a href="admin_entrepot_add?id=${e.id}" style="color: red">${e.num}</a>
							</c:if></td>
						<td><c:if test="${! empty e.complete}">
								<fmt:formatDate value="${e.complete}" pattern="yyyy-MM-dd" />
							</c:if>
							<c:if test="${empty e.complete && fn:containsIgnoreCase(staff.department,'库存部')}">
								<a href="admin_entrepot_add?id=${e.id}" style="color: red">未提交</a>
							</c:if>
							<c:if test="${empty e.complete && ! fn:containsIgnoreCase(staff.department,'库存部')}">
								<span style="color: red">未提交</span>
							</c:if></td>
						<td>${e.enterNumber}</td>
						<td>${e.outNumber}</td>
						<td>${e.staff.name}</td>

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