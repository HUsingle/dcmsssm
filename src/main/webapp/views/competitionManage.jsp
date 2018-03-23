<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <%--<meta charset="utf-8">--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>竞赛管理</title>
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
        <a class="btn bg-purple bt-flat " id="add"><i class="fa fa-plus"></i> 添加</a>
        <a class="btn bg-purple bt-flat " id="update" data-toggle="modal" data-target="#myModal"><i
                class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
    </form>
    <table id="myTable">
    </table>
</div>

<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle"></h3>
    </div>

    <div class="box-body" >
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false">
            <div class="form-group" style="display:none;">
                <div class="col-sm-1 control-label">id</div>
                <div class="col-sm-4">
                    <input type="text" id="id" class="form-control" name="id" placeholder="id"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">竞赛名称</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="name" name="name" placeholder="竞赛名称"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">竞赛类型</div>
                <div class="col-sm-4">
                    <label class="radio-inline">
                        <input type="radio" name="optionsRadiosinline" id="optionsRadios3" value="option1" checked> 选项 1
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="optionsRadiosinline" id="optionsRadios4"  value="option2"> 选项 2
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">举办单位</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="host" name="host" placeholder="举办单位"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">比赛地点</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="place" name="place" placeholder="比赛地点"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label">比赛时间</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="competitionTime" name="competitionTime" placeholder="比赛时间"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">开始报名</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="applyStart" name="applyStart" placeholder="报名开始时间"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">截止报名</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="applyEnd" name="applyEnd" placeholder="报名截止时间"/>
                </div>
            </div>
            <div class="form-group">
            <div class="col-sm-1 control-label">负责人</div>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="leader" name="leader" placeholder="竞赛负责人"/>
            </div>
    </div>
                <div class="form-group">
                    <div class="col-sm-1 control-label">竞赛附件</div>
                        <div class="col-sm-4">
                            <input type="file" id="upLoadFile"/>
                        </div>
                    </div>

            <div class="form-group">
                <div class="col-sm-1 control-label"></div>
                &nbsp;&nbsp;&nbsp;&nbsp;<button type="button" id="addGroup" class="btn btn bg-orange bt-flat">设置组别
            </button> &nbsp;&nbsp;<button type="button" id="submitButton" class="btn btn bg-purple bt-flat">确定
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
<script src="${path}/resources/js/fileinput.min.js"></script>
<script src="${path}/resources/js/zh.js"></script>

<script>
  /*  $(function () {
        initTable('#myTable', "/teacher/getTeacherList",
            ['id', 'name', 'password', 'college', 'phone', 'email'],
            ['编号', '姓名', '密码', '学院', '手机号码', '电子邮箱'], true, 0);
    });*/
    $("document").ready(
        function () {
            initUpdateInformation("添加竞赛", "修改竞赛", ["id", 'name', 'password', 'college', 'phone', 'email'],
                "${path}/teacher/deleteTeacher", "id");
            initAddAndUpdate("${path}/teacher/addTeacher", "${path}/teacher/updateTeacher", "id=",
                "", $("#id"), "添加竞赛", true);
            $("#upLoadFile").fileinput({
                uploadUrl:"",//上传的地址
                uploadAsync: true,              //异步上传
                language: "zh",                 //设置语言
                showCaption: true,              //是否显示标题
                showUpload: false,               //是否显示上传按钮
                showRemove: true,               //是否显示移除按钮
                showPreview: false,             //是否显示预览按钮
                browseClass: "btn bg-purple", //按钮样式
                dropZoneEnabled: false,         //是否显示拖拽区域
                maxFileCount: 1,                        //最大上传文件数限制
                enctype: 'multipart/form-data',
                initialPreviewAsData: true, // defaults markup
                preferIconicPreview: false // 是否优先显示图标  false 即优先显示图片
            });


        }

    );
</script>
</body>
</html>