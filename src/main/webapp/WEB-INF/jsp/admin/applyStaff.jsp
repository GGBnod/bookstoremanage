<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../include/admin/adminHeader.jsp" %>
<%@include file="../include/admin/adminNavigator.jsp" %>


<title>采购申请</title>


<!-- // alert(index); -->
<script>
    $(function () {

        <%--var value= ${cs.get(0).id};--%>
        var index = 5;
        $.each($("#Tbl tr"), function (i) {
            if (i > 5)
                this.style.display = 'none';
        })

        $("button.btn-info").click(function () {
            index += 5;
            $.each($("#Tbl tr"), function (i) {
                if (i <= index && i > index - 5) {
                    $("#tr_" + i).show();
                }
            })
        });

        $("a").click(function () {
            var deleteLink = $(this).attr("deleteLink");
            console.log(deleteLink);
            if ("false" == deleteLink) {
                var confirmDelete = confirm("确认要删除");
                if (confirmDelete) {
                    var tr = $(this).parents("tr").addClass("hidden");
                    var input = tr.find("td").eq(2).find("input")[0];
                    input.value = null;
                    return true;
                }
                return false;

            }
        });

        $("select").click(function () {
            var value = $(this).val();
            var select = $(this).parents("tr").find("td").eq(1).find("select");
            var length = select.find("option").length;
            var cid = $(this).attr("cid");
            if ("true" == cid) {
                for (var i = 0; i < length; i++) {
                    select.find("option").eq(i).removeClass("hidden");
                    var option = select.find("option").eq(i).attr("id");
                    if (value != option)
                        select.find("option").eq(i).addClass("hidden");
                }
            }
        });

        $("#number").keyup(function () {
            var page = "admin_staff_check";
            var value = $(this).val();

            $.post(page, {
                "number": value
            }, function (result) {
                $("#checkNumber").html(result);
            });
        });
        $("#name").keyup(function () {
            var page = "admin_staff_check";
            var value = $(this).val();

            $.post(page, {
                "name": value
            }, function (result) {
                $("#checkName").html(result);
            });
        });

        $("input").keyup(function () {
            var value = $(this).val();

            if (0 == value.trim().length)
                $(this).val(0);

        });

        $("#addForm").submit(function () {
            var bool = true;
            for (var i = 0; i < 100; i++) {
                var value = $("#" + i + "_name").val();
                if (null != value && 0 != value.length) {
                    if (!checkEmpty(i + "_author", "作者"))
                        return false;
                    if (!checkEmpty(i + "_publis", "出版社"))
                        return false;
                    if (!checkInt(i + "_stock", "采购数量"))
                        return false;
                    if (!checkEmpty(i + "_introduce", "简介"))
                        return false;
                    bool = false;
                }
            }

            if (bool) {
                alert("采购的书籍至少为一本！");
                return false;
            }
            if (!checkEmpty("number", "清单编号"))
                return false;
            if (!checkEmpty("name", "申请人"))
                return false;
            var checkName = $("font#checkName").attr("color");
            var checkNumber = $("font#checkNumber").attr("color");
            if (!("green" == checkName && "green" == checkNumber)) {
                alert("清单编号或申请人姓名不正确！");
                return false;
            }

            return true;
        });

    });

    function fillout() {

        for (var i = 0; i < 100; i++) {
            var buyingPrice = $("#" + i + "_buyingPrice");
            var buyingPriceValue = buyingPrice.val();

            var price = $("#" + i + "_price");
            var priceValue = price.val();
            if (null == buyingPriceValue || 0 == buyingPriceValue.length) {
                $("#" + i + "_buyingPrice").attr({"value": "0"});
            }
            if (null == priceValue || 0 == priceValue.length) {
                $("#" + i + "_price").attr({"value": "0"});
            }
        }

    }
</script>

<div class="workingArea">
    <form method="post" id="addForm" action="admin_purchase_add"
          enctype="multipart/form-data">
        <div style="position: relative;">
            <div class="pull-right">
                <div id="checkNumber"
                     style="position: absolute; top: -20px; right: 150px"></div>
            </div>
            <ol class="breadcrumb" style="height: 50px">
                <li class="active" style="line-height: 34px">采购申请 &nbsp;&nbsp;</li>
                <div class="pull-right">
                    <div
                            style="width: 6%; display: inline-block; margin: 0px 10px 0px 800px;">清单编号
                    </div>
                    <input id="number" name="number"
                           style="width: 17%; display: inline-block;" type="text"
                           class="form-control" placeholder="A-101">
                </div>
            </ol>
        </div>

        <div class="listDataTableDiv">
            <table id="Tbl"
                   class="col-md-1 table table-striped table-bordered table-hover  table-condensed">
                <thead>
                <tr class="success something">
                    <th class="col-md-1">书籍分类</th>
                    <th class="col-md-1">细分</th>
                    <th class="col-md-1">书籍封面</th>
                    <th class="col-md-1">书名</th>
                    <th class="col-md-1">作者</th>
                    <th class="col-md-1">进货价</th>
                    <th class="col-md-1">零售价</th>
                    <th class="col-md-1">出版社</th>
                    <th class="col-md-1">采购数量</th>
                    <th class="col-md-2">简介</th>
                    <th class="col-md-1">删除</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${bs}" var="b" varStatus="bt">

                    <c:if test="${bt.index<5}">
                        <tr id="${bt.index}" name="${bt.index}">
                            <td><select cid="true" id="${bt.index}_cid"
                                        name="${bt.index}_cid" class="form-control">
                                <c:forEach items="${cs}" var="c">
                                    <option value="${c.id}">${c.name}</option>
                                </c:forEach>
                            </select></td>
                            <td><select id="${bt.index}_mid" name="bs[${bt.index}].mid"
                                        class="form-control">
                                <c:forEach items="${ms}" var="m">
                                    <option id="${m.category.id }" value="${m.id}">${m.name}</option>
                                </c:forEach>
                            </select></td>
                            <td><input style="width: 100px" id="${bt.index}_Pic"
                                       accept="image/*" type="file" name="bms[${bt.index}]"/></td>
                            <td><input id="${bt.index}_name" name="bs[${bt.index}].name"
                                       type="text" class="form-control"></td>
                            <td><input id="${bt.index}_author"
                                       name="bs[${bt.index}].author" type="text" class="form-control"></td>
                            <td><input id="${bt.index}_buyingPrice"
                                       onkeyup="value=(parseInt((value=value.replace(/\D/g,''))==''||parseInt((value=value.replace(/\D/g,''))==0)?'0':value,10))"
                                       name="bs[${bt.index}].buyingPrice" type="text" class="form-control"></td>
                            <td><input id="${bt.index}_price" name="bs[${bt.index}].price"
                                       onkeyup="value=(parseInt((value=value.replace(/\D/g,''))==''||parseInt((value=value.replace(/\D/g,''))==0)?'0':value,10))"
                                       type="text" class="form-control"></td>
                            <td><input id="${bt.index}_publis"
                                       name="bs[${bt.index}].publis" type="text" class="form-control"></td>
                            <td><input id="${bt.index}_stock" name="bs[${bt.index}].stock"
                                       onkeyup="value=(parseInt((value=value.replace(/\D/g,''))==''||parseInt((value=value.replace(/\D/g,''))==0)?'0':value,10))"
                                       type="text" class="form-control"></td>
                            <td><input id="${bt.index}_introduce"
                                       name="bs[${bt.index}].introduce" type="text" class="form-control"></td>
                            <td><a deleteLink="false" href=" javascript:; "><span
                                    class=" glyphicon glyphicon-trash"></span></a></td>

                        </tr>
                    </c:if>
                    <c:if test="${bt.index>=5}">
                        <tr id="tr_${bt.index}" name="${bt.index}">
                            <td><select cid="true" id="${bt.index}_cid"
                                        name="${bt.index}_cid" class="form-control">
                                <c:forEach items="${cs}" var="c">
                                    <option value="${c.id}">${c.name}</option>
                                </c:forEach>
                            </select></td>
                            <td><select id="${bt.index}_mid" name="bs[${bt.index}].mid"
                                        class="form-control">
                                <c:forEach items="${ms}" var="m">
                                    <option id="${m.category.id }" value="${m.id}">${m.name}</option>
                                </c:forEach>
                            </select></td>
                            <td><input style="width: 100px" id="${bt.index}_Pic"
                                       accept="image/*" type="file" name="bms[${bt.index}]"/></td>
                            <td><input id="${bt.index}_name" name="bs[${bt.index}].name"
                                       type="text" class="form-control"></td>
                            <td><input id="${bt.index}_author"
                                       name="bs[${bt.index}].author" type="text" class="form-control"></td>
                            <td><input id="${bt.index}_buyingPrice"
                                       onkeyup="value=(parseInt((value=value.replace(/\D/g,''))==''||parseInt((value=value.replace(/\D/g,''))==0)?'0':value,10))"
                                       name="bs[${bt.index}].buyingPrice" type="text" class="form-control"></td>
                            <td><input id="${bt.index}_price" name="bs[${bt.index}].price"
                                       onkeyup="value=(parseInt((value=value.replace(/\D/g,''))==''||parseInt((value=value.replace(/\D/g,''))==0)?'0':value,10))"
                                       type="text" class="form-control"></td>
                            <td><input id="${bt.index}_publis"
                                       name="bs[${bt.index}].publis" type="text" class="form-control"></td>
                            <td><input id="${bt.index}_stock" name="bs[${bt.index}].stock"
                                       onkeyup="value=(parseInt((value=value.replace(/\D/g,''))==''||parseInt((value=value.replace(/\D/g,''))==0)?'0':value,10))"
                                       type="text" class="form-control"></td>
                            <td><input id="${bt.index}_introduce"
                                       name="bs[${bt.index}].introduce" type="text" class="form-control"></td>
                            <td><a deleteLink="false" href=" javascript:; "><span
                                    class=" glyphicon glyphicon-trash"></span></a></td>

                        </tr>
                    </c:if>
                </c:forEach>

                </tbody>
            </table>
            <ol style="height: 160px; text-align: center;" class="breadcrumb">
				<textarea id="reason" name="reason"
                          style="width: 100%; height: 100px;" type="text"
                          class="form-control" placeholder="申请理由   选填"></textarea>
                <div style="margin: 10px">
                    <button id="addBook" type="button" class="pull-right btn btn-info">增加书籍数量</button>

                    <div style="text-align: center; width: 9%; display: inline-block;">申请人</div>
                    <div style="display: inline-block;height: 55px">
                        <input id="name" name="name"
                               style="width: 100%; display: inline-block; position: relative;"
                               type="text" class="form-control" placeholder="姓名">
                        <div id="checkName" style="position: absolute; width: 100px"></div>
                    </div>

                    <table class="addTable">
                        <tr class="submitTR">
                            <td colspan="2" align="center"><input id="cid" type="hidden"
                                                                  name="cid" value="${c.id}">
                                <button style="height: 80px; width: 200px; font-size: 40px"
                                        type="submit" class="btn btn-success" onclick="fillout();">提 交
                                </button>
                            </td>
                        </tr>
                    </table>

                </div>

            </ol>
        </div>


    </form>

</div>