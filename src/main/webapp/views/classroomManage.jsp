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
    <link rel="stylesheet" href="${path}/resources/css/myCss.css">
</head>
<body>
<div id="myDiv">
    <form class="form-horizontal" style="margin-left: -3px;margin-bottom: 15px;">
        <input id="search" style="display: none;">
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
            <div class="form-group" style="display:none;">
                <div class="col-sm-1 control-label">id</div>
                <div class="col-sm-3">
                    <input type="text" id="id" class="form-control" name="id" placeholder="id"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">教室</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="site" name="site" placeholder="教室地点"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">人数</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="number" name="number" placeholder="人数"/>
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


<script src="${path}/resources/js/jquery.min.js"></script>
<script src="${path}/resources/js/bootstrap.min.js"></script>
<script src="${path}/resources/js/bootstrap-table.min.js"></script>
<script src="${path}/resources/js/bootstrap-table-zh-CN.min.js"></script>
<script src="${path}/resources/js/messenger.min.js"></script>
<script src="${path}/resources/js/create-table.js"></script>
<script>
    $(function () {
        initTable('#myTable', "${path}/classroom/getClassroomList",
            ['id', 'site', 'number'], ['id', '教室', '人数'], true, 0);
    });
    $("document").ready(
        function () {
            initUpdateInformation("添加教室", "修改教室", ['id', 'site', 'number'],
                "${path}/classroom/deleteClassroom", "id");
            $("#importExcel").click(function () {
                window.parent.openModel("${path}/classroom/importClassroomExcel", "导入表格");
            });
            initAddAndUpdate("${path}/classroom/addClassroom", "${path}/classroom/updateClassroom", "id=",
                "", $("#id"), "添加教室", true);
        }
    );
</script>
</body>
</html>
