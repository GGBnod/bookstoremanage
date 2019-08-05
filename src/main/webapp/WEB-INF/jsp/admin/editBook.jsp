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
		<li><a href="admin_category_list">所有书籍</a></li>
		<li class="active">编辑书籍</li>
	</ol>

	<div class="panel panel-warning editDiv">
		<div class="panel-heading">编辑书籍</div>
		<div class="panel-body">
			<form method="post" id="editForm" action="admin_book_update"
				enctype="multipart/form-data">
				<table class="editTable">
					<tr>
						<td>书籍封面</td>
						<td><input id="bookPic" accept="image/*" type="file"
							name="image" /></td>
					</tr>
					<tr>
						<td>编号</td>
						<td><input id="booknumber" name="booknumber" value="${b.booknumber}"
							type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>书籍名称</td>
						<td><input id="name" name="name"
							value="${b.name}" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>作者</td>
						<td><input id="author" name="author"
							value="${b.author}" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>进货价</td>
						<td><input id="buyingPrice" name="buyingPrice"
							value="${b.buyingPrice}" type="text" class="form-control"></td>
					</tr>
					
					<tr>
						<td>零售价</td>
						<td><input id="price" name="price" value="${b.price}"
							type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>出版社</td>
						<td><input id="publis" name="publis" value="${b.publis}" type="text"
							class="form-control"></td>
					</tr>
					<tr>
						<td>库存</td>
						<td><input id="stock" name="stock"
							value="${b.stock}" type="text" class="form-control"></td>
					</tr>
					<tr>
						<td>简介</td>
						<td><input id="introduce" name="introduce" value="${b.introduce}"
							type="text" class="form-control"></td>
					</tr>
					
					<tr class="submitTR">
						<td colspan="2" align="center"><input type="hidden" name="id"
							value="${b.id}"><input type="hidden" id="mid" name="mid"value="${b.mid}">
							<button type="submit" class="btn btn-success">提 交</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>