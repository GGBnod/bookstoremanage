<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	$(function() {
		$("select").click(function() {
			var page = "admin_user_update";
			var id = $(this).attr("id");
			var vip = $(this).val();
//            var u = {"id":id,"vip":vip};
			$.post(page, {
				"id" : id,
				"vip" : vip
			});

		});
	});
	function out() {

	}
</script>

<title>用户管理</title>


<div class="workingArea">
	<h1 class="label label-info">用户管理</h1>

	<br> <br>

	<div class="listDataTableDiv">
		<table
			class="table table-striped table-bordered table-hover  table-condensed" >
			<thead>
				<tr class="success">
					<th width="25%">ID</th>
					<th width="25%">用户名称</th>
					<th width="25%">用户等级</th>
					<th width="25%">积分(积分>=500，自动升级VIP)</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${us}" var="u">
					<tr>
						<td>${u.id}</td>
						<td>${u.name}</td>
						<td><c:if test="${fn:containsIgnoreCase(u.vip,'vip')}">
								<select id="${u.id}" class="form-control">
									<option>VIP</option>
									<option>普通会员</option>
								</select>
							</c:if> <c:if test="${!fn:containsIgnoreCase(u.vip,'vip')}">
								<select id="${u.id}" class="form-control">
									<option>普通会员</option>
									<option>VIP</option>
								</select>
							</c:if></td>
						<td>${u.integral}</td>
					</tr>
				</c:forEach>
				<c:if test="${5 > us.size() }">
				<c:forEach var="i" begin="1" end="${5-us.size()}">
					<tr style="visibility: hidden">
						<td>i</td>
						<td>i</td>
						<td>
							<select class="form-control">
								<option>普通会员</option>
								<option>VIP</option>
							</select>
						</td>
						<td>i</td>
					</tr>

				</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>

	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp"%>
	</div>


</div>

<%@include file="../include/admin/adminFooter.jsp"%>
