<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	// 	$(function() {
	// 		$("#addForm").submit(function() {
	// 			if (!checkEmpty("name", "产品名称"))
	// 				return false;
	// 			// 			if (!checkEmpty("subTitle", "小标题"))
	// 			// 				return false;
	// 			if (!checkNumber("orignalPrice", "原价格"))
	// 				return false;
	// 			if (!checkNumber("promotePrice", "优惠价格"))
	// 				return false;
	// 			if (!checkInt("stock", "库存"))
	// 				return false;
	// 			return true;
	// 		});
	// 	});
</script>

<title>产品管理</title>


<div class="workingArea">

	<ol class="breadcrumb">
		<div align="center"
			style="font-size: 20px; font-weight: bold; color: #BC8303"
			class="center-block">采购清单</div>
	</ol>

	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="10%">书名</th>
					<th width="10%">图片</th>
					<th width="10%">作者</th>
					<th width="10%">进货价</th>
					<th width="10%">零售价</th>
					<th width="10%">出版社</th>
					<th width="10%">采购数量</th>
					<th width="30%">简介</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${p.bs}" var="b">
					<tr>
						<td>${b.name}</td>
						<td><a href="img/book/${b.id}.jpg" target="_blank"><img
								width="50px" height="50px" src="img/book/${b.id}.jpg"></a></td>
						<td>${b.author}</td>
						<td>${b.buyingPrice}</td>
						<td>${b.price}</td>
						<td>${b.publis}</td>
						<td>${b.stock}</td>
						<td>${fn:substring(b.introduce, 0, 32)}...</td>

					</tr>
				</c:forEach>

			</tbody>
		</table>
	</div>




	<c:if test="${fn:containsIgnoreCase(staff.department,'管理员') && fn:containsIgnoreCase(p.opinion,'待定')}">
		<form method="post" id="editForm" action="admin_purchase_update">
			<table class="addTable">
				<tr>
					<td colspan="3"><textarea id="proposal" name="proposal"
							style="width: 100%; height: 100px;" type="text"
							class="form-control" placeholder="建议或者意见   选填"></textarea></td>
				</tr>
				<tr>
					<td align="right">是否同意</td>
					<td><select style="width: 30%" id="opinion" name="opinion"
						class="form-control">
							<option value="待定">待定</option>
							<option value="同意">同意</option>
							<option value="不同意">不同意</option>
					</select></td>

					<td><input id="pid" type="hidden" name="id" value="${p.id}">
						<button type="submit" class="btn btn-success">确定</button></td>
				</tr>
			</table>
		</form>
	</c:if>
	<c:if test="${! fn:containsIgnoreCase(p.opinion,'待定')}">
			<table class="addTable">
				<tr>
					<td colspan="3"><textarea id="proposal" name="proposal"
							style="width: 100%; height: 100px;" type="text"
							class="form-control" placeholder="建议或者意见   选填" readonly="readonly" value="${p.proposal }"></textarea></td>
				</tr>
				<tr>
					<td align="right">是否同意</td>
					<td><select style="width: 30%" id="opinion" name="opinion"
						class="form-control">
							<option value="${p.opinion }">${p.opinion }</option>
					</select></td>

					
				</tr>
			</table>
		
	</c:if>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>
