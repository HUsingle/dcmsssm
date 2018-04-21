<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>竞赛文件管理</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%
        pageContext.setAttribute("path", request.getContextPath());
    %>
    <link rel="stylesheet" href="${path}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="${path}/resources/css/AdminLTE.min.css">
    <link rel="stylesheet" href="${path}/resources/css/fileinput.min.css">
    <link rel="stylesheet" href="${path}/resources/css/bootstrap-table.min.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger-theme-future.css">
    <link rel="stylesheet" href="${path}/resources/css/myCss.css">
</head>
<body>
<div id="myDiv">
    <form class="form-horizontal" style="margin-left: -3px;margin-bottom: 15px;">
        <input id="search" style="display: none;">
        <a class="btn bg-purple bt-flat " id="add"><i class="fa fa-plus"></i> 上传文件</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
        <a class="btn bg-purple bt-flat " id="download" href="javascript:download()"><i class="fa fa-download"></i>
            下载</a>
    </form>
    <table id="myTable">
    </table>
</div>

<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle">上传文件</h3>
    </div>
    <div class="box-body">
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false"
              style="margin-left: 2px;">
            <div class="form-group" style="padding-top: 10px;padding-bottom: 4px;">
                <div class="col-sm-5">
                    <input type="file" id="compFile" name="compFile"/>
                </div>
            </div>
            <div class="form-group" style="margin-left: 0px;">
                <button type="button" class="btn btn bg-purple bt-flat" id="quit">返回</button>
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
<script src="${path}/resources/js/fileinput.min.js"></script>
<script src="${path}/resources/js/zh.js"></script>
<script>
    function intFileInput() {
        var myFile = $("#compFile");
        myFile.fileinput({
            uploadUrl: "${path}/competitionFile/addCompetitionFile",//上传的地址
            uploadAsync: true,              //异步上传
            language: "zh",                 //设置语言
            showCaption: true,              //是否显示标题
            showUpload: true,               //是否显示上传按钮
            showRemove: true,               //是否显示移除按钮
            showPreview: true,             //是否显示预览按钮
            browseClass: "btn bg-purple", //按钮样式
            dropZoneEnabled: false,         //是否显示拖拽区域
            maxFileCount: 1,                        //最大上传文件数限制
            enctype: 'multipart/form-data',
            initialPreviewAsData: true, // defaults markup
            preferIconicPreview: false // 是否优先显示图标  false 即优先显示图片
        });
        myFile.on("fileuploaded", function (event, data, previewId, index) {
            var result = data.response.result;
            //$(this).fileinput('destroy');
            if (result > 0) {
                initMessage("添加成功！", 'success');
                $("#myTable").bootstrapTable('refresh');
                $("#myBox").hide();
                $("#myDiv").show();
              //  myFile.fileinput('clear');//清空所有文件
            } else {
                initMessage("添加失败,添加的数据存在错误或者服务器异常！", 'error');
            }
        });

    }
    function download() {
        var jsonArray = $("#myTable").bootstrapTable('getSelections');
        if (jsonArray.length < 1) {
            initMessage("请选择一条数据!", 'error');
        } else if (jsonArray.length > 1) {
            initMessage("请选择一条数据,不要多选!", 'error');
        }
        else {
            var ids = jsonArray[0]["id"];
            var url = "${path}/competitionFile/downloadCompetitionFile?id=" + ids;
            window.location.href = url;
        }
    }
    $(function () {
        initTable('#myTable', "${path}/competitionFile/getCompetitionFileList", ['id', 'fileName', 'uploadTime'],
            ['文件编号', '文件名称', '上传时间'], true, 0);
        intFileInput();
        $("#quit").click(function () {
            $("#myBox").hide();
            $("#myDiv").show();
        });
        $("#add").click(function () {
            $("#myDiv").hide();
            $("#myBox").show();
        });
        $("#delete").click(function () {
            var jsonArray = $("#myTable").bootstrapTable('getSelections');
            if (jsonArray.length < 1) {
                initMessage("请至少选择一条记录!", 'error');
            } else {
                var ids = '';
                for (var i = 0; i < jsonArray.length; i++)
                    ids += jsonArray[i]["id"] + ',';
                $.ajax({
                    type: 'POST',
                    url: "${path}/competitionFile/deleteCompetitionFile",
                    data: {
                        'id': ids
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data['result'] > 0) {
                            initMessage("删除成功！", 'success');
                            $("#myTable").bootstrapTable('refresh');
                        } else {
                            initMessage("删除失败！", 'error');
                        }
                    }
                });
            }
        });
    });
</script>
</body>
</html>
