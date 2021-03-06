<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>教室管理</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%
        pageContext.setAttribute("path", request.getContextPath());
    %>
    <link rel="stylesheet" href="${path}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="${path}/resources/css/AdminLTE.min.css">
    <link rel="stylesheet" href="${path}/resources/css/bootstrap-table.min.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger-theme-future.css">
    <link rel="stylesheet" href="${path}/resources/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="${path}/resources/css/myCss.css">
</head>
<body>
<div id="myDiv">
    <form class="form-horizontal" style="margin-left: -3px;margin-bottom: 15px;">
        <input id="search" style="display: none;">
        <a class="btn bg-orange bt-flat " id="searchApply"><i class="fa fa-search"></i>查询报名统计</a>
        <a class="btn bg-purple bt-flat " id="add"><i class="fa fa-plus"></i> 添加</a>
        <a class="btn bg-purple bt-flat " id="update"><i class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
        <a class="btn bg-purple bt-flat " id="importExcel"><i class="fa fa-upload"></i> 导入表格</a>
        <a class="btn bg-purple bt-flat " href="${path}/classroom/exportClassroomExcelModel"><i
                class="fa fa-file-excel-o"></i> 下载导入表格模板</a>
    </form>

        <table id="myTable">
        </table>

</div>

<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle"></h3>
    </div>

    <div class="box-body">
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false">
            <div class="form-group">
                <div class="col-sm-1 control-label">考场</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="site" name="site" placeholder="考场地点"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">人数</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="number" name="number" placeholder="安排人数"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label"></div>
                &nbsp;&nbsp;&nbsp;&nbsp;<button type="button" id="submitButton" class="btn btn bg-purple bt-flat">确定
            </button>
                &nbsp;&nbsp;<button type="button" class="btn btn bg-purple bt-flat" id="quit">返回</button>
            </div>
        </form>
    </div>
</div>
<div class="box box-default" id="myStat" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myStatBoxTitle">报名统计</h3>
    </div>
    <div class="box-body">
        <div class="row" style="margin-bottom: 10px;margin-top: 11px;">
            <div class="col-sm-4">
                <select class="selectpicker form-control" id="competition" name="competition">
                    <c:forEach items="${competitionList}" var="competition">
                        <option value="${competition.cid}">${competition.name}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="button" class="btn btn bg-purple bt-flat" id="quitHome">返回</button>
        </div>
    </div>
    <div class="row" style="margin-left: -6px;">
        <div class="col-sm-10" style="margin-bottom: 20px;">
            <table id="statTable">
            </table>
        </div>
    </div>


</div>



<script src="${path}/resources/js/jquery.min.js"></script>
<script src="${path}/resources/js/bootstrap.min.js"></script>
<script src="${path}/resources/js/bootstrap-table.min.js"></script>
<script src="${path}/resources/js/bootstrap-table-zh-CN.min.js"></script>
<script src="${path}/resources/js/messenger.min.js"></script>
<script src="${path}/resources/js/bootstrap-select.min.js"></script>
<script src="${path}/resources/js/defaults-zh_CN.min.js"></script>
<script src="${path}/resources/js/actionBar.js"></script>
<script>
    function initStatTable(params, titles) {
        $("#statTable").bootstrapTable({
            url: "${path}/apply/getGroupNumber",
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            dataType: "json",
            striped: true,
            cache: false,
            pagination: false,
            // pagination: true,
            sortable: true,
            sidePagination: "server",//设置分页方式
            minimumCountColumns: 2,
            queryParams: function (params) { //传递参数
                var temp = {
                    limit: params.limit,
                    offset: (params.offset / params.limit) + 1,
                    id: $("#competition").val()
                };
                return temp;
            },
            columns: createCols(params, titles),
            onLoadSuccess: function (data) {

                if (data["rows"] !== null && data["rows"].length > 0) {//返回数据有老师这个变
                    var dataJson = data["rows"];
                    var sum = 0;
                    for (var i = 0; i < dataJson.length; i++) {
                        sum = sum + dataJson[i].number;
                    }
                    var object = {};
                    object.groupName = "总数";
                    object.number = sum;
                    dataJson.push(object);
                    $("#statTable").bootstrapTable("load", data);
                }
                return true;//返回值很重要
            }

        });
        //创建表头
        function createCols(params, titles) {
            if (params.length !== titles.length)
                return null;
            var arr = [];
            for (var i = 0; i < params.length; i++) {
                var obje = {};
                obje.field = params[i];
                obje.title = titles[i];
                obje.align = 'center';
                arr.push(obje);
            }
            return arr;
        }
    }
    function initMyAdd(titleOne) {
        $("#add").click(function () {
            $("#myBoxTitle").text(titleOne);
            $('#site' ).attr("disabled", false);
            $("#site").val("");
            $("#number").val("");
            $("#myDiv").hide();
            $("#myBox").show();
        });
    }
    function initMyUpdate(titleTwo) {
        $("#update").click(function () {
            var jsonArray = $("#myTable").bootstrapTable('getSelections');
            if (jsonArray.length < 1) {
                initMessage("请选择一条数据!", 'error');
            } else if (jsonArray.length > 1) {
                initMessage("请选择一条数据,不要多选!", 'error');
            } else {
                $("#site").val(jsonArray[0].site);
                $("#number").val(jsonArray[0].number);
                $('#site' ).attr("disabled", true);
                $("#myDiv").hide();
                $("#myBox").show();
            }
        });
    }
    function initMyAddAndUpdate(addUrl, updateUrl, addTitle) {
        $("#submitButton").click(function () {
            var site = $("#site").val();
            var num = $("#number").val();
            if (site === "" || num === "") {
                initMessage("考场地点和人数不能为空！", "error");
                return;
            }
            if(isNaN(num)||parseInt(num)<=0){
                initMessage("考场人数不合法！", "error");
                return;
            }
            if ($("#myBoxTitle").text() === addTitle) {
                $.ajax({
                    type: "POST",
                    url: addUrl,
                    dataType: "json",
                    data: $("#myFrom").serialize(),
                    //data:fromData,
                    success: function (data) {
                        var result=data['result'];
                        if (!isNaN(result)) {
                            if(parseInt(result)>0){
                            initMessage("添加成功！", 'success');
                            $("#myTable").bootstrapTable('refresh');
                            $("#myBox").hide();
                            $("#myDiv").show();
                            }else{
                                initMessage("添加失败，网络或者服务器异常！", 'error');
                            }
                        } else {
                            initMessage(result, 'error');
                        }
                    }
                });
            } else {
                var jsonArray = $("#myTable").bootstrapTable('getSelections');
                var paramData={};
                paramData.id=jsonArray[0].id;
                paramData.site=site;
                paramData.number=num;
                $.ajax({
                    type: "POST",
                    url: updateUrl,
                    dataType: "json",
                    data: paramData,
                    success: function (data) {
                        if (data['result'] > 0) {
                            initMessage("修改成功！", 'success');
                            $("#myTable").bootstrapTable('refresh');
                            $("#myBox").hide();
                            $("#myDiv").show();
                        } else {
                            initMessage("修改失败,修改的数据存在错误或者服务器异常！", 'error');
                        }
                    }
                });
            }
        });
    }
    $(function () {
        initTable('#myTable', "${path}/classroom/getClassroomList",
            ['id', 'site', 'number'], ['考场编号', '考场位置', '安排人数'], true, 0);
        $("#myTable").bootstrapTable('hideColumn', 'id');
        initStatTable(['groupName', 'number'], ['报名组别', '报名人数']);
        initMyAdd("添加考场");
        initMyUpdate("修改考场");
        initDelete( "${path}/classroom/deleteClassroom", "id");
        initReturn();
        initMyAddAndUpdate("${path}/classroom/addClassroom", "${path}/classroom/updateClassroom","添加考场");
        $("#importExcel").click(function () {
            var extraData={};
            window.parent.openModel("${path}/classroom/importClassroomExcel", "导入表格",extraData);
        });
        $("#searchApply").click(function () {
            $("#myDiv").hide();
            $("#myStat").show();
        });
        $("#quitHome").click(function () {
            $("#myDiv").show();
            $("#myStat").hide();
        });
        $("#competition").change(function () {
            $("#statTable").bootstrapTable("destroy");
            initStatTable(['groupName', 'number'], ['报名组别', '报名人数']);
        });
    });
</script>
</body>
</html>
