<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>学科竞赛管理系统</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%
        pageContext.setAttribute("path", request.getContextPath());
    %>
    <link rel="stylesheet" href="${path}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="${path}/resources/css/AdminLTE.min.css">
    <link rel="stylesheet" href="${path}/resources/css/skin-purple.min.css">
    <link rel="stylesheet" href="${path}/resources/css/fileinput.min.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger-theme-future.css">
    <style>
        .bg-primary {
            background-color: #605ca8;
        }
    </style>
</head>
<body class="hold-transition skin-purple sidebar-mini">

<div class="wrapper">

    <!-- Main Header -->
    <header class="main-header">
        <!-- Logo -->
        <a href="#" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>学科</b></span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>学科竞赛管理系统</b></span>
        </a>

        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <div style="float:left;color:#fff;padding:15px 10px;">欢迎haha!</div>
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">

                    <li class="dropdown notifications-menu" >
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-bell-o"></i>
                            <span class="label label-warning">1</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">通知</li>
                            <li>
                                <ul class="menu">
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-users text-aqua"></i> 监考信息
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="footer"><a href="#">所有通知</a></li>
                        </ul>
                    </li>

                    <li><a href="#" data-toggle="modal" data-target="#updatePassword"><i class="fa fa-lock"></i> &nbsp;修改密码</a>
                    <li><a href="#"><i class="fa fa-power-off"></i> &nbsp;关闭系统</a>
                    </li>
                    <li><a href="#"><i class="fa fa-sign-out"></i> &nbsp;退出系统</a></li>

                </ul>
            </div>
        </nav>
    </header>

    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">

        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- Sidebar Menu -->
            <ul class="sidebar-menu" data-widget="tree">
                <li class="header">导航菜单</li>
                <!-- Optionally, you can add icons to the links -->
                <li><a href="${path}/views/studentMan.jsp" target="myFrame"><i class="fa fa-users"></i><span>学生管理</span></a>
                </li>
                <li><a href="${path}/views/teacherManage.jsp" target="myFrame"><i class="fa fa-user"></i><span>老师管理</span></a></li>
                <li><a href="#"><i class="fa fa-list"></i><span>报名管理</span></a></li>
                <li><a href="#"><i class="fa fa-list-alt"></i><span>竞赛管理</span></a></li>
                <li><a href="${path}/views/classroomManage.jsp" target="myFrame"><i class="fa fa-university"></i><span>考场管理</span></a></li>
                <li><a href="#"><i class="fa fa-building-o"></i><span>考场安排管理</span></a></li>
                <li><a href="#"><i class="fa fa-table"></i><span>成绩管理</span></a></li>
                <li><a href="#"><i class="fa fa-list-ul"></i><span>晋级名单管理</span></a></li>
                <li><a href="#"><i class="fa fa-arrow-up"></i><span>竞赛文件管理</span></a></li>
                <li><a href="#"><i class="fa fa-arrow-down"></i><span>学生答案管理</span></a></li>
                <li><a href="#"><i class="fa fa-bar-chart"></i><span>竞赛统计</span></a></li>
                <%--<li class="treeview">
                    <a href="#"><i class="fa fa-bar-chart"></i> <span>竞赛统计</span>
                        <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
                    </a>
                    <ul class="treeview-menu">
                        <li><a href="#">导出各类名单</a></li>
                        <li><a href="#">成绩统计</a></li>
                    </ul>
                </li>--%>
            </ul>
        </section>
    </aside>


    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="background-color: white;">
        <!-- Content Header (Page header) -->
        <section class="content-header" style="background-color: #ecf0f5;">
            <ol class="breadcrumb" style="position:static;float:none;margin-top: -15px;">
                <li><i class="fa fa-home" style="font-size: 20px;position:relative;left: -8px;top: 2px;"></i>&nbsp;首页
                </li>
                <li class="active" id="activeLink">控制台</li>
            </ol>
        </section>

        <!-- Main content -->


        <section class="content">
            <iframe scrolling="yes" frameborder="0" style="width:100%;height:550px; overflow:visible;"
                    src="${path}/views/main.html"
                    name="myFrame" id="myFrame"></iframe>
        </section>


        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <footer class="main-footer" style="padding: 6px;">
        <!-- Default to the left -->
        <strong>Copyright &copy; 2018 ZHAOXU WANGHU.</strong> All rights reserved.
    </footer>

    <!-- /.control-sidebar -->
    <!-- Add the sidebar's background. This div must be placed
    immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>

    <!-- 导入表格-->
    <div class="modal fade" id="excelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLab" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLab"></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <input id="excelFile" type="file" name="excelFile">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="updatePassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">修改密码</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <div class="form-group">
                                <div class="col-sm-2 control-label">账号</div>
                                <span class="label label-success" style="vertical-align: bottom;"></span>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-2 control-label">原密码</div>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" placeholder="原密码"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-2 control-label">新密码</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" placeholder="新密码"/>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn bg-purple bt-flat">提交更改</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</div>


<script src="${path}/resources/js/jquery.min.js"></script>
<script src="${path}/resources/js/bootstrap.min.js"></script>
<script src="${path}/resources/js/adminlte.min.js"></script>
<script src="${path}/resources/js/fileinput.min.js"></script>
<script src="${path}/resources/js/zh.js"></script>
<script src="${path}/resources/js/messenger.min.js"></script>
<script>
    $(document).ready(function () {
        $(".sidebar-menu a").click(function () {
            $("#activeLink").text(($(this).text()));
        });
    });
    function initImportExcel(url) {
        var excelFile=$("#excelFile");
        excelFile.fileinput({
            uploadUrl: url,//上传的地址
            uploadAsync: true,              //异步上传
            language: "zh",                 //设置语言
            showCaption: true,              //是否显示标题
            showUpload: true,               //是否显示上传按钮
            showRemove: true,               //是否显示移除按钮
            showPreview: true,             //是否显示预览按钮
            browseClass: "btn bg-purple", //按钮样式
            dropZoneEnabled: false,         //是否显示拖拽区域
            allowedFileExtensions: ["xls", "xlsx"], //接收的文件后缀
            maxFileCount: 1,                        //最大上传文件数限制
            enctype: 'multipart/form-data',
            previewFileIcon: '<i class="fa fa-file"></i>',
            initialPreviewAsData: true, // defaults markup
            preferIconicPreview: false // 是否优先显示图标  false 即优先显示图片
        });

        excelFile.on("fileuploaded", function (event, data, previewId, index) {
            var result = data.response.result;
            $('#excelModal').modal('hide');
            $(this).fileinput('destroy');
            if (result === "导入成功!") {
                $('#myFrame')[0].contentWindow.refreshTable();
                $('#myFrame')[0].contentWindow.refreshTable();
                initMessage(result, "success");
            } else {
                initMessage(result, "error");
            }
        });
        excelFile.on('fileerror', function(event, data, msg) {
            initMessage(msg, "error");
        });

    }
    function initMessage(message, state) {
        $.globalMessenger().post({
            message: message,//提示信息
            type: state,//消息类型。error、info、success
            hideAfter: 4,//多长时间消失
            id: 1, //：唯一的ID。 如果提供，则一次只显示一个带有该ID的消息。
            showCloseButton: true//是否显示关闭按钮
        });
    }
    function openModel(importUrl, modeTitle) {
        initImportExcel(importUrl);
        $("#myModalLab").text(modeTitle);
        $("#excelModal").modal();
    }

</script>
</body>
</html>