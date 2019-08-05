<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	$(function() {
		$("#g_name").keyup(function() {
			var value = $("#g_name").val();
			$("input#name")[0].value = value;
			$("input#name")[1].value = value;
		});
		$("#g_num").keyup(function() {
			var value = $("#g_num").val();
			$("input#num")[0].value = value;
			$("input#num")[1].value = value;
		});
		// 			$("#addForm").submit(function() {
		// 				if (!checkEmpty("name", "产品名称"))
		// 					return false;
		// 				// 			if (!checkEmpty("subTitle", "小标题"))
		// 				// 				return false;
		// 				if (!checkNumber("orignalPrice", "原价格"))
		// 					return false;
		// 				if (!checkNumber("promotePrice", "优惠价格"))
		// 					return false;
		// 				if (!checkInt("stock", "库存"))
		// 					return false;
		// 				return true;
		// 			});
	});
</script>

<title>产品管理</title>


<div class="workingArea">

	<ol class="breadcrumb" style="height: 120px; background-color: #DFF0D8">
		<div align="center"
			style="font-size: 20px; font-weight: bold; color: #BC8303"
			class="center-block">库存管理</div>
		<p></p>
		<br>
		<div class="pull-left">
			管理人 <input id="g_name" name="g_name"
				style="width: 58%; display: inline-block; margin: 0px 20px"
				type="text" class="form-control" readonly="readonly" value="${e.staff.name}">
		</div>
		<div class="pull-right">
			编号 <input id="g_num" name="g_num"
				style="width: 58%; display: inline-block; margin: 0px 20px"
				type="text" class="form-control" readonly="readonly" value="${e.num}">
		</div>
	</ol>

	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="15%">出入库</th>
					<th width="15%">书籍</th>
					<th width="15%">作者</th>
					<th width="15%">出版社</th>
					<th width="15%">数量</th>
					<th width="25%">时间</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ds}" var="d">
					<tr>
						<td>${d.inAndOut}</td>
						<td>${d.name}</td>
						<td>${d.author}</td>
						<td>${d.publis}</td>
						<td>${d.number}</td>
						<td><fmt:formatDate value="${d.outdate}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>

					</tr>
				</c:forEach>

			</tbody>
		</table>
	</div>

	






</div>

<%@include file="../include/admin/adminFooter.jsp"%>
