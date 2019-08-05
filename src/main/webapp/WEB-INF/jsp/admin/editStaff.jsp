<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>



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
		<li><a href="admin_category_list">所有分类</a></li>
		<li class="active">编辑分类</li>
	</ol>

	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑分类</div>
		<div class="panel-body">
			<form method="post" id="editForm" action="admin_staff_update"
				enctype="multipart/form-data">
				<table class="editTable">
					<tr>
						<td>部门</td>
						<td><select id="department" name="department"
							class="form-control">
								<c:forEach items="${departments}" var="department">
									<option value="${department}">${department}</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td>编号</td>
						<td><input id="identifier" name="identifier"
							value="${s.identifier}" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>密码</td>
						<td><input id="password" name="password"
							value="${s.password}" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>个人圖片</td>
						<td><input id="staffPic" accept="image/*" type="file"
							name="image" /></td>
					</tr>
					<tr>
						<td>姓名</td>
						<td><input id="name" name="name" value="${s.name}"
							type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>性别</td>
						<td><input id="sex" name="sex" value="${s.sex}" type="text"
							class="form-control"></td>
					</tr>
					<tr>
						<td>出生年月日</td>
						<td><input id="datebirth" name="datebirth"
							value="${s.datebirth}" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>家庭住址</td>
						<td><input id="address" name="address" value="${s.address}"
							type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>手机号</td>
						<td><input id="mobile" name="mobile" value="${s.mobile}"
							type="text" class="form-control"></td>
					</tr>
					<tr class="submitTR">
						<td colspan="2" align="center"><input type="hidden" name="id"
							value="${s.id}">
							<button type="submit" class="btn btn-success">提 交</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>