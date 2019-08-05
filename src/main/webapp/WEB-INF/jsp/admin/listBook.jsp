<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	$(function() {

		$("#addForm").submit(function() {
			<c:if test="${empty  bs}">
			if (!checkEmpty("bookNumber", "书籍编号"))
				return false;
			</c:if>
			
			if (!checkEmpty("bookPic", "书籍封面"))
				return false;
			if (!checkEmpty("name", "书籍名称"))
				return false;
			if (!checkEmpty("author", "作者"))
				return false;
			if (!checkNumber("buyingPrice", "进货价"))
				return false;
			if (!checkNumber("price", "零售价"))
				return false;
			if (!checkEmpty("publis", "出版社"))
				return false;
			if (!checkInt("stock", "库存"))
				return false;
			if (!checkEmpty("introduce", "简介"))
				return false;
			return true;
		});
	});
</script>

<title>书籍管理</title>


<div class="workingArea">

	<ol class="breadcrumb">
		<li><a href="admin_category_list">所有分类</a></li>
		<li><a href="admin_mince_list?cid=${m.category.id}">${m.name}</a></li>
		<li class="active">书籍管理</li>
		<c:if test="${fn:containsIgnoreCase(staff.department,'采购部')}">
			<li><a href="admin_staff_purchase">采购申请</a></li>
		</c:if>
		
	</ol>

	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="8%">书籍编号</th>
					<th width="8%">图片</th>
					<th width="8%">书名</th>
					<th width="8%">作者</th>
					<th width="8%">进货价</th>
					<th width="8%">零售价</th>
					<th width="8%">出版社</th>
					<th width="8%">库存</th>
					<th width="20%">简介</th>
					<th width="8%">编辑</th>
					<th width="8%">删除</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bs}" var="b">
					<tr>
						<td>${b.booknumber}</td>
						<td><a href="img/book/${b.id}.jpg" target="_blank"><img
								width="50px" height="50px" src="img/book/${b.id}.jpg"></a></td>
						<td>${b.name}</td>
						<td>${b.author}</td>
						<td>${b.buyingPrice}</td>
						<td>${b.price}</td>
						<td>${b.publis}</td>
						<td>${b.stock}</td>
						<td>${fn:substring(b.introduce, 0, 32)}...</td>

						<c:if test="${fn:containsIgnoreCase(staff.department,'库存部')}">
							<td><a href="admin_book_edit?id=${b.id}"><span
									class="glyphicon glyphicon-edit"></span></a></td>
							<td><a deleteLink="true" href="admin_book_delete?id=${b.id}"><span
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

			<c:if test="${! empty bs}">
				<div class="panel-heading">新增书籍</div>
			</c:if>
			<c:if test="${empty bs}">
				<div class="panel-heading">新增细分下的第一本书需要写书籍编号</div>
			</c:if>
			<div class="panel-body">
				<form method="post" id="addForm" action="admin_book_add"
					enctype="multipart/form-data">
					<table class="addTable">
						<c:if test="${empty  bs}">
							<tr>
								<td>书籍编号</td>
								<td><input id="bookNumber" name="bookNumber" type="text"
									class="form-control"></td>
							</tr>
						</c:if>

						<tr>
							<td>书籍封面</td>
							<td><input id="bookPic" accept="image/*" type="file"
								name="image" /></td>
						</tr>
						<tr>
							<td>书籍名称</td>
							<td><input id="name" name="name" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td>作者</td>
							<td><input id="author" name="author" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td>进货价</td>
							<td><input id="buyingPrice" name="buyingPrice" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td>零售价</td>
							<td><input id="price" name="price" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td>出版社</td>
							<td><input id="publis" name="publis" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td>库存</td>
							<td><input id="stock" value="99" name="stock" type="text"
								class="form-control"></td>
						</tr>
						<tr>
							<td>简介</td>
							<td><input id="introduce" name="introduce" type="text"
								class="form-control"></td>
						</tr>
						<tr class="submitTR">
							<td colspan="2" align="center"><input id="mid" type="hidden"
								name="mid" value="${m.id}">
								<button type="submit" class="btn btn-success">提 交</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</c:if>



</div>

<%@include file="../include/admin/adminFooter.jsp"%>
