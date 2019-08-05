<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
$(function(){
	
	$("#addForm").submit(function(){
		if(!checkEmpty("name","分类名称"))
			return false;
		return true;
	});
});

</script>

<title>采购清单阅览</title>


<div class="workingArea">
	<a href="admin_staff_purchase"><h1
			class="label label-info">采购申请</h1></a>
	<br>
	<br>
	
	<div class="listDataTableDiv">
		<table class="table table-striped table-bordered table-hover  table-condensed">
			<thead>
				<tr class="success">
					<th width="20%">ID</th>
					<th width="20%">清单编号</th>
					<th width="20%">申请人</th>
					<th width="20%">书籍数量</th>
					<th width="20%">详情</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${theps}" var="p">
				
				<tr>
					<td>${p.id}</td>
					<td><a href="admin_book_list?pid=${p.id}">${p.number}</a></td>	
					<td>${p.staff.name}</td>
					<td>${p.total}</td>
						<td><a href="admin_category_edit?id=${p.id}"><span class="glyphicon glyphicon-edit"></span></a></td>				 
	
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="pageDiv">
		<%@include file="../include/admin/adminPage.jsp" %>
	</div>
	
	<div class="panel panel-warning addDiv">
	  <div class="panel-heading">新增书籍分类</div>
	  <div class="panel-body">
	    	<form method="post" id="addForm" action="admin_category_add" enctype="multipart/form-data">
	    		<table class="addTable">
	    			<tr>
	    				<td>分类名称</td>
	    				<td><input  id="name" name="name" type="text" class="form-control"></td>
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
	
</div>

<%@include file="../include/admin/adminFooter.jsp"%>