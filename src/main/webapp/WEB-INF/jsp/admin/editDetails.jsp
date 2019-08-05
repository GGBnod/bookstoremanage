<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<title>编辑分类</title>


<script>
	$(function() {

		$("#editForm").submit(function() {
			if (!checkEmpty("department", "部门"))
				return false;
			if (!checkEmpty("identifier", "编号"))
				return false;
			if (!checkEmpty("password", "密码"))
				return false;
			if (!checkEmpty("name", "姓名"))
				return false;
			if (!checkEmpty("sex", "性别"))
				return false;
			if (!checkEmpty("datebirth", "出生年月日"))
				return false;
			if (!checkEmpty("address", "家庭住址"))
				return false;
			if (!checkEmpty("moblie", "手机号码"))
				return false;
			if (!checkEmpty("categoryPic", "分类图片"))
				return false;
			return true;
		});
	});
</script>

<div class="workingArea">

	<ol class="breadcrumb">
		<li class="active">编辑书籍</li>
	</ol>

	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑书籍</div>
		<div class="panel-body">
			<form method="post" id="editForm"
				action="admin_entrepot_detailsUpdate">
				<table class="editTable">
					<tr>
						<td>出入库</td>
						<td><select id="inAndOut" name="inAndOut"
							class="form-control">
								
								<c:if test="${fn:containsIgnoreCase(d.inAndOut,'出库')}">
									<option value="出库">出库</option>
									<option value="入库">入库</option>
								</c:if>
								<c:if test="${fn:containsIgnoreCase(d.inAndOut,'入库')}">
									<option value="入库">入库</option>
									<option value="出库">出库</option>
								</c:if>

						</select></td>
					</tr>
					<tr>
						<td>书籍名称</td>
						<td><input id="name" name="name" type="text"
							class="form-control" value="${d.name}"></td>
					</tr>
					<tr>
						<td>作者</td>
						<td><input id="author" name="author" type="text"
							class="form-control" value="${d.author}"></td>
					</tr>
					<tr>
						<td>出版社</td>
						<td><input id="publis" name="publis" type="text"
							class="form-control" value="${d.publis}"></td>
					</tr>
					<tr>
						<td>数量</td>
						<td><input id="number" name="number" type="text"
							class="form-control" value="${d.number}"></td>
					</tr>
					<tr class="submitTR">
						<td colspan="2" align="center"><input type="hidden" name="id"
							value="${d.id}"><input type="hidden" name="eid"
												   value="${d.eid}">
							<button type="submit" class="btn btn-success">提 交</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>