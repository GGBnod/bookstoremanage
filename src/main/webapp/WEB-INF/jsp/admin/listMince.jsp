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

	<ol class="breadcrumb">
		<li><a href="admin_category_list">书籍分类</a></li>
		<li class="active">书籍管理</li>
		<div class="pull-right">
			<a href="admin_staff_purchase">采购申请</a>
		</div>
	</ol>



	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="20%">ID</th>
					<th width="20%">细分</th>
					<th width="20%">数量</th>
					<th width="20%">编辑</th>
					<th width="20%">删除</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ms}" var="m">

					<tr>
						<td>${m.id}</td>
						<td><a href="admin_book_list?mid=${m.id}">${m.name}</a></td>
						<td>${m.number}</td>
						<c:if test="${fn:containsIgnoreCase(staff.department,'库存部')}">
							<td><a href="admin_mince_edit?id=${m.id}"><span
									class="glyphicon glyphicon-edit"></span></a></td>
							<td><a deleteLink="true"
								href="admin_mince_delete?id=${m.id}"><span
									class="glyphicon glyphicon-trash"></span></a></td>
						</c:if>
						<c:if test="${! fn:containsIgnoreCase(staff.department,'库存部')}">
							<td><span class="glyphicon glyphicon-edit"></span></td>
							<td><span class="glyphicon glyphicon-trash"></span></td>
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
			<div class="panel-heading">新增的细分</div>
			<div class="panel-body">
				<form method="post" id="addForm" action="admin_mince_add">
					<table class="addTable">
						<tr>
							<td>细分的名称</td>
							<td><input id="name" name="name" type="text"
								class="form-control"></td>
						</tr>
						<tr class="submitTR">
							<td colspan="2" align="center"><input id="cid" name="cid"
								value="${c.id }" type="hidden">
								<button type="submit" class="btn btn-success">提 交</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</c:if>

</div>

<%@include file="../include/admin/adminFooter.jsp"%>