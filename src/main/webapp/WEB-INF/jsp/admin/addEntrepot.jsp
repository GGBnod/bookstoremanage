<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	$(function() {
		$("#g_name").keyup(function() {
			var page = "admin_staff_check";
			var value = $(this).val();

			$.post(page, {
				"name" : value
			}, function(result) {
				$("#checkName").html(result);
			});
		});

		$("#g_num").keyup(function() {
			var page = "admin_staff_check";
			var value = $(this).val();

			$.post(page, {
				"g_num" : value
			}, function(result) {
				$("#checkNum").html(result);
			});
		});

		$("button").click(function() {
			var num = $("#g_num").val();
			var name = $("#g_name").val();
			$("input#num")[0].value = num;
			$("input#num")[1].value = num;
			$("input#num")[2].value = num;
			$("input#staffName")[0].value = name;
			$("input#staffName")[1].value = name;
			$("input#staffName")[2].value = name;
		});

		$("#updateForm")
				.submit(
						function() {
							if (!checkEmpty("g_name", "姓名"))
								return false;
							if (!checkEmpty("g_num", "编号"))
								return false;
							var checkName = $("font#checkName").attr("color");
							var checkNum = $("font#checkNum").attr("color");

							if (!("green" == checkName && "green" == checkNum)) {
								if (!(null == checkName && null == checkNum)) {
									if (!("green" == checkName && null == checkNum)
											&& !(null == checkName && "green" == checkNum)) {
										alert("清单编号或申请人姓名不正确！");
										return false;
									}

								}
							}
							<c:if test="${empty e.ds}">
							alert("库存管理的记录不能零！");
							return false;
							</c:if>
							var confirmDelete = confirm("是否提交！ 提交后将无法修改");
							if (confirmDelete)
								return true;
							return false;
						});

		$("#inForm").submit(function() {
			if (!checkEmpty("in_name", "书籍名称"))
				return false;
			if (!checkEmpty("in_author", "作者"))
				return false;
			if (!checkEmpty("in_publis", "出版社"))
				return false;
			if (!checkInt("in_number", "数量"))
				return false;
			return true;
		});
		$("#outForm").submit(function() {
			if (!checkEmpty("out_name", "书籍名称"))
				return false;
			if (!checkEmpty("out_author", "作者"))
				return false;
			if (!checkEmpty("out_publis", "出版社"))
				return false;
			if (!checkInt("out_number", "数量"))
				return false;

			return true;
		});
	});
</script>

<title>产品管理</title>


<div class="workingArea">

	<ol class="breadcrumb" style="height: 120px; background-color: #DFF0D8">
		<div align="center"
			style="font-size: 20px; font-weight: bold; color: #BC8303"
			class="center-block">库存管理</div>
		<p></p>
		<div class="container">
			<div class="row">
				<div class="col-xs-2 ">
					<div id="checkName" style="margin-left: 18px"></div>
				</div>
				<div class="col-xs-8 " style="color: #DFF0D8" align="center">彩蛋</div>
				<div class="col-xs-1 ">
					<div id="checkNum" align="left"></div>
				</div>
				<div class="col-xs-1 "></div>
			</div>
		</div>

		<div class="pull-left">
			管理人 <input id="g_name" name="g_name"
				style="width: 58%; display: inline-block; margin: 0px 20px"
				type="text" class="form-control" placeholder="姓名"
				value="${e.staff.name}">
		</div>
		<div class="pull-right">
			编号 <input id="g_num" name="g_num"
				style="width: 58%; display: inline-block; margin: 0px 20px"
				type="text" class="form-control" placeholder="列： CK-101"
				value="${e.num}">
		</div>
	</ol>

	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="10%">出入库</th>
					<th width="10%">书籍</th>
					<th width="10%">作者</th>
					<th width="10%">出版社</th>
					<th width="10%">数量</th>
					<th width="30%">时间</th>
					<th width="10%">编辑</th>
					<th width="10%">删除</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${e.ds}" var="d">
					<tr>
						<td>${d.inAndOut}</td>
						<td>${d.name}</td>
						<td>${d.author}</td>
						<td>${d.publis}</td>
						<td>${d.number}</td>
						<td><fmt:formatDate value="${d.outdate}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td><a href="admin_entrepot_detailsEdit?id=${d.id}"><span
								class="glyphicon glyphicon-edit"></span></a></td>
						<td><a deleteLink="true"
							href="admin_entrepot_detailsDelete?id=${d.id}"><span
								class=" 	glyphicon glyphicon-trash"></span></a></td>

					</tr>
				</c:forEach>

			</tbody>
		</table>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-xs-1 "></div>
			<div class="col-xs-4 ">
				<div style="" class="panel panel-info ">
					<div class="panel-heading" align="center">入库书籍</div>
					<div class="panel-body">
						<form method="post" id="inForm"
							action="admin_entrepot_detailsInAndOut">
							<table class="addTable">
								<tr>
									<td>书籍名称</td>
									<td><input id="in_name" name="name" type="text"
										class="form-control"></td>
								</tr>
								<tr>
									<td>作者</td>
									<td><input id="in_author" name="author" type="text"
										class="form-control"></td>
								</tr>
								<tr>
									<td>出版社</td>
									<td><input id="in_publis" name="publis" type="text"
										class="form-control"></td>
								</tr>
								<tr>
									<td>数量</td>
									<td><input id="in_number" name="number" type="text"
										class="form-control"></td>
								</tr>
								<tr>
									<td><input type="hidden" id="staffName" name="staffName"
										value="${e.staff.name}"></td>
									<td><input type="hidden" id="num" name="num"
										value="${e.num}"></td>
								</tr>
								<tr class="submitTR">
									<td colspan="2" align="center"><input type="hidden"
										name="eid" value="${e.id}"><input type="hidden"
										name="inAndOut" value="入库">
										<button type="submit" class="btn btn-success">确定</button></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
			<div class="col-xs-2 "></div>
			<div class="col-xs-4 ">
				<div class="panel panel-danger">
					<div class="panel-heading" align="center">出库书籍</div>
					<div class="panel-body">
						<form method="post" id="outForm"
							action="admin_entrepot_detailsInAndOut">
							<table class="addTable">
								<tr>
									<td>书籍名称</td>
									<td><input id="out_name" name="name" type="text"
										class="form-control"></td>
								</tr>
								<tr>
									<td>作者</td>
									<td><input id="out_author" name="author" type="text"
										class="form-control"></td>
								</tr>
								<tr>
									<td>出版社</td>
									<td><input id="out_publis" name="publis" type="text"
										class="form-control"></td>
								</tr>
								<tr>
									<td>数量</td>
									<td><input id="out_number" name="number" type="text"
										class="form-control"></td>
								</tr>
								<tr>
									<td><input type="hidden" id="staffName" name="staffName"
										value="${e.staff.name}"></td>
									<td><input type="hidden" id="num" name="num"
										value="${e.num}"></td>
								</tr>
								<tr class="submitTR">
									<td colspan="2" align="center"><input type="hidden"
										name="eid" value="${e.id}"><input type="hidden"
										name="inAndOut" value="出库">
										<button type="submit" class="btn btn-success">确定</button></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
			<div class="col-xs-1 "></div>
		</div>
	</div>


	<form method="post" id="updateForm" action="admin_entrepot_update">
		<input type="hidden" id="staffName" name="staffName" value="${e.staff.name}">
		<input type="hidden" id="num" name="num" value="${e.num}"> <input
			type="hidden" name="id" value="${e.id}">
		<div align="center">
			<button id="list" style="height: 80px; width: 200px; font-size: 40px"
				type="submit" class="btn btn-success">提 交</button>
		</div>

	</form>


</div>

<%@include file="../include/admin/adminFooter.jsp"%>
