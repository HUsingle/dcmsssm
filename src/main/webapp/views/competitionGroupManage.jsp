<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>竞赛组别管理</title>
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
            <div class="form-group" >
                <div class="col-sm-1 control-label">组别编号</div>
                <div class="col-sm-3">
                    <input type="text" id="id" class="form-control" name="id" placeholder="竞赛组别编号"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">组别名称</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="name" name="name" placeholder="竞赛组别名称"/>
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
<script src="${path}/resources/js/actionBar.js"></script>
<script>
    function initMyAddAndUpdate(addUrl, updateUrl, addTitle) {
        $("#submitButton").click(function () {
            var id = $("#id").val();
            var group=$("#name").val();
            if (id === "" || group === "") {
                initMessage("竞赛组别编号和竞赛组别名称都不能为空！", "error");
                return;
            }
            if (isNaN(id)) {
                initMessage("竞赛组别编号必须为数字！", "error");
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
                        if (data['result'] > 0) {
                            if (data['result'] === 1) {
                                initMessage("添加成功！", 'success');
                            } else {
                                initMessage("该数据已经存在，更新成功！", 'success');
                            }
                            $("#myTable").bootstrapTable('refresh');
                            $("#myBox").hide();
                            $("#myDiv").show();
                        } else {
                            initMessage("添加失败，插入数据存在错误或者服务器异常！", 'error');
                        }
                    }
                });
            } else {
                $.ajax({
                    type: "POST",
                    url: updateUrl,
                    dataType: "json",
                    data: $("#myFrom").serialize(),
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
        initTable('#myTable', "${path}/competitionGroup/getCompetitionGroupList",
            ['id', 'name'], ['竞赛组别编号', '竞赛组别名称'], true, 0);
        initAdd("添加竞赛组别",['id', 'name']);
        initReturn();
        initDelete("${path}/competitionGroup/deleteCompetitionGroup", "id");
        initUpdate(['id', 'name'],"修改竞赛组别");
        initMyAddAndUpdate("${path}/competitionGroup/addCompetitionGroup", "${path}/competitionGroup/updateCompetitionGroup",
           "添加竞赛组别")

    });

</script>
</body>
</html>
