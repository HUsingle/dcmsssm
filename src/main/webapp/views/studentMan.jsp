<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>学生管理</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/resources/css/bootstrap-table.min.css">
    <link rel="stylesheet" href="/resources/css/messenger.css">
    <link rel="stylesheet" href="/resources/css/messenger-theme-future.css">
    <link rel="stylesheet" href="/resources/css/myCss.css">
</head>
<body>
<div id="myDiv">
    <form class="form-horizontal" style="margin-left: -14px;margin-bottom: 15px;">
        <div class="col-sm-3">
            <div class="from-group">
                <input type="text" class="form-control" placeholder="学号/姓名/班级">
            </div>
        </div>
        <a class="btn bg-purple bt-flat " type="submit"><i class="fa fa-search"></i> 查询</a>
        <a class="btn bg-purple bt-flat " id="addCourse"><i class="fa fa-plus"></i> 添加</a>
        <a class="btn bg-purple bt-flat " id="updateCourse" data-toggle="modal" data-target="#myModal"><i class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="deleteCourse"><i class="fa fa-trash-o"></i> 删除</a>
        <a class="btn bg-purple bt-flat "><i class="fa fa-upload"></i> 导入表格</a>
        <a class="btn bg-purple bt-flat "><i class="fa fa-download"></i> 导出表格</a>
    </form>
    <table id="myTable">
    </table>
</div>
<%--<table id="listTable" data-click-to-select="true"
       data-toggle="table"
       data-side-pagination="server"
       data-pagination="true"
       data-page-list="[10]"
       data-pagination="true"
       data-page-size="10"
       data-pagination-first-text="首页"
       data-pagination-pre-text="上一页"
       data-pagination-next-text="下一页"
       data-pagination-last-text="末页"
       data-method="post"
       data-row-style="rowStyle"
       data-url="http://localhost:8080/student/getStudentList">
    <thead>
    <tr>
        <th class="text-center" data-field="checkbox" data-checkbox="true"></th>
        <th class="text-center" data-field="username">学号</th>
        <th class="text-center" data-field="name">名字</th>
        <th class="text-center" data-field="password">密码</th>
        <th class="text-center" data-field="college">学院</th>
        <th class="text-center" data-field="studentClass">班级</th>
        <th class="text-center" data-field="phone">手机号码</th>
        <th class="text-center" data-field="email">电子邮箱</th>
    </tr>
    </thead>
</table>--%>
<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle"></h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">
        <form class="form-horizontal" method="post">
            <div class="form-group">
                <div class="col-sm-1 control-label">学号</div>
                <div class="col-sm-3">
                    <input type="text" id="username" class="form-control" name="username" placeholder="学生编号"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">姓名</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="name" name="name" placeholder="姓名"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">密码</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="password" name="password" placeholder="密码"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">学院</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="college" name="college" placeholder="学院"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">手机号</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="手机号"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">专业班级</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="studentClass" name="studentClass" placeholder="专业班级"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">电子邮箱</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="email" name="email" placeholder="电子邮箱"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label"></div>
                &nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn bg-purple bt-flat">确定</button>
                &nbsp;&nbsp;<button type="button" class="btn btn bg-purple bt-flat" id="quit">返回</button>
            </div>
        </form>
    </div>
    <!-- /.box-body -->
</div>

<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/bootstrap-table.min.js"></script>
<script src="/resources/js/bootstrap-table-zh-CN.min.js"></script>
<script src="/resources/js/messenger.min.js"></script>

<script src="/resources/js/create-table.js"></script>
<script>
    $(function () {
        initTable('#myTable', "/student/getStudentList",
            ['username', 'name', 'password', 'studentClass', 'college', 'phone', 'email'],
            ['学号', '姓名', '密码', '班级', '学院', '手机号码', '电子邮箱'], true);
    });
    $("document").ready(
        function () {
            initUpdateInformation("添加学生","修改学生",['username','name','password','studentClass','college','phone','email'])
        }
    );
</script>


</body>
</html>

