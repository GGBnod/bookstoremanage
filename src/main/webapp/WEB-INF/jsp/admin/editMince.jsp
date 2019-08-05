<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>



<title>编辑分类</title>


<script>
	$(function() {

		$("#editForm").submit(function() {
			if (!checkEmpty("name", "分类名称"))
				return false;

			return true;
		});
	});
</script>

<div class="workingArea">

	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li><a href="admin_mince_list?cid=${m.category.id }">${m.category.name }下的细分种类</a></li>
		<li class="active">编辑细分</li>
	</ol>

	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑细分</div>
		<div class="panel-body">
			<form method="post" id="editForm" action="admin_mince_update">
				<table class="editTable">
					<tr>
						<td>细分所在的分类</td>
						<td><select id="cid" name="cid" class="form-control">
								<option value="${m.category.id}">${m.category.name}</option>
								<c:forEach items="${cs}" var="c">
									<c:if test="${m.category.name != c.name}">
										<option value="${c.id}">${c.name}</option>
									</c:if>
								</c:forEach>
						</select>
					</tr>
					<tr>
						<td>细分的名称</td>
						<td><input id="name" name="name" value="${m.name}"
							type="text" class="form-control"></td>
					</tr>
					<tr class="submitTR">
						<td colspan="2" align="center"><input type="hidden" name="id"
							value="${m.id}">
							<button type="submit" class="btn btn-success">提 交</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>