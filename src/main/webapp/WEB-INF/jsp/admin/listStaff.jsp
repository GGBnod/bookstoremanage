<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>

	$(function() {

		$("#addForm").submit(function() {
			if (!checkEmpty("department", "部门"))
				return false;
			if (!checkEmpty("identifier", "编号"))
				return false;
			if (!checkEmpty("password", "密码"))
				return false;
			if (!checkEmpty("staffPic", "个人图片"))
				return false;
			if (!checkEmpty("name", "姓名"))
				return false;
			if (!checkEmpty("datebirth", "出生年月日"))
				return false;
			if (!checkEmpty("address", "家庭住址"))
				return false;
			if (!checkEmpty("mobile", "手机号码"))
				return false;

			return true;
		});
	});
</script>

<title>分类管理</title>


<div class="workingArea">
	<a href="admin_staff_list?department=all"><h1
			class="label label-info">所有职员</h1></a> <a
		href="admin_staff_list?department=purchase"><h1
			class="label label-info">采购部</h1></a> <a
		href="admin_staff_list?department=stock"><h1
			class="label label-info">库存管理部</h1></a> <a
		href="admin_staff_list?department=reception"><h1
			class="label label-info">前台销售部</h1></a> <br> <br>

	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="10%">编号</th>
					<th width="8%">图片</th>
					<th width="8%">姓名</th>
					<th width="8%">性别</th>
					<th width="15%">出生年月日</th>
					<th width="20%">家庭住址</th>
					<th width="15%">手机号码</th>
					<th width="8%">编辑</th>
					<th width="8%">删除</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ss}" var="s">

					<tr>
						<td>${s.identifier}</td>
						<td><a href="img/staff/${s.id}.jpg" target="_blank"><img
								width="50px" height="50px" src="img/staff/${s.id}.jpg"></a></td>
						<td>${s.name}</td>
						<td>${s.sex}</td>
						<td>${s.datebirth}</td>
						<td>${s.address}</td>
						<td>${s.mobile}</td>

						<td><a href="admin_staff_edit?id=${s.id}"><span
								class="glyphicon glyphicon-edit"></span></a></td>
						<td><a deleteLink="true" href="admin_staff_delete?id=${s.id}"><span
								class=" 	glyphicon glyphicon-trash"></span></a></td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="pageDiv" style="height: ">
		<%@include file="../include/admin/adminPage.jsp"%>
	</div>

	<div class="panel panel-warning addDiv">
		<c:if test="${! empty department}">
			<div class="panel-heading">${department}</div>
			<div class="panel-body">
				<form method="post" id="addForm" action="admin_staff_add"
					enctype="multipart/form-data">
					<table class="addTable">
						<tr>
							<td>编号</td>
							<td><input id="identifier" name="identifier" type="text"
								class="form-control" value="${identifier}" readonly="readonly"></td>
						</tr>
						<tr>
							<td>密码</td>
							<td><input id="password" name="password" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td>个人圖片</td>
							<td><input id="staffPic" accept="image/*" type="file"
								name="image" /></td>
						</tr>
						<tr>
							<td>姓名</td>
							<td><input id="name" name="name" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td>性别</td>
							<td><div style="padding-left: 15px;display: inline" >男&nbsp;<input id="man" name="sex" type="radio" value="男" checked="cheche"></div>
								<div style="padding-left: 15px;display: inline"">女&nbsp;<input id="woman" name="sex" type="radio" value="女"></div></td>
						</tr>
						<tr>
							<td>出生年月日</td>
							<td><input id="datebirth" style="background-color: #fff" name="datebirth" type="text"
								class="form-control"  readonly="readonly" placeholder="列：1970-1-1"></td>
						</tr>
						<tr>
							<td>家庭住址</td>
							<td><input id="address" name="address" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td>手机号</td>
							<td><input id="mobile" name="mobile" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td><input id="department" name="department" type="hidden"
								class="form-control" value="${department}"></td>
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
<script src="js/layDate-v5.0.9/laydate/laydate.js"></script>
<script>
lay('#version').html('-v' + laydate.v);

//执行一个laydate实例
laydate.render({
	elem : '#datebirth' //指定元素
});
</script>

<%@include file="../include/admin/adminFooter.jsp"%>