<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
	$(function() {

		$("#addForm").submit(function() {
			if (!checkEmpty("name", "分类名称"))
				return false;
			return true;
		});
	});
</script>

<title>书籍分类</title>


<div class="workingArea">
	<h1 class="label label-info">书籍分类</h1>
	<c:if test="${fn:containsIgnoreCase(staff.department,'采购部')}">
		<a href="admin_staff_purchase"><h1 class="label label-info">采购申请</h1></a>
	</c:if>
	
	<br> <br>

	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="20%">ID</th>
					<th width="20%">分类名称</th>
					<th width="20%">二级分类数量</th>
					<th width="20%">编辑</th>
					<th width="20%">删除</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${cs}" var="c">

					<tr>
						<td>${c.id}</td>
						<td><a href="admin_mince_list?cid=${c.id}">${c.name}</a></td>
						<td>${c.number}</td>
						<c:if test="${fn:containsIgnoreCase(staff.department,'库存部')}">
							<td><a href="admin_category_edit?id=${c.id}"><span
									class="glyphicon glyphicon-edit"></span></a></td>
							<td><a deleteLink="true"
								href="admin_category_delete?id=${c.id}"><span
									class=" 	glyphicon glyphicon-trash"></span></a></td>
						</c:if>
						<c:if test="${! fn:containsIgnoreCase(staff.department,'库存部')}">
							<td><span class="glyphicon glyphicon-edit"></span></td>
							<td><span class=" 	glyphicon glyphicon-trash"></span></td>
						</c:if>


					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp"%>
	</div>

	<c:if test="${fn:containsIgnoreCase(staff.department,'库存部')}">
		<div class="panel panel-warning addDiv">
			<div class="panel-heading">新增书籍分类</div>
			<div class="panel-body">
				<form method="post" id="addForm" action="admin_category_add"
					enctype="multipart/form-data">
					<table class="addTable">
						<tr>
							<td>分类名称</td>
							<td><input id="name" name="name" type="text"
								class="form-control"></td>
						</tr>
						<tr class="submitTR">
							<td colspan="2" align="center">
								<button type="submit" class="btn btn-success">提 交</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</c:if>

</div>

<%@include file="../include/admin/adminFooter.jsp"%>