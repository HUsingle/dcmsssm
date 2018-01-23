<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>学科竞赛管理系统</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/resources/css/skin-purple.min.css">
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
                    <li><a href="#"><i class="fa fa-lock"></i> &nbsp;修改密码</a></li>
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
                <li><a href="/views/studentMan.jsp" target="myFrame"><i class="fa fa-users"></i><span>学生管理</span></a></li>
                <li><a href="#"><i class="fa fa-user"></i><span>老师管理</span></a></li>
                <li><a href="#"><i class="fa fa-list"></i><span>报名管理</span></a></li>
                <li><a href="#"><i class="fa fa-list-alt"></i><span>竞赛管理</span></a></li>
                <li><a href="#"><i class="fa fa-university"></i><span>考场管理</span></a></li>
                <li><a href="#"><i class="fa fa-table"></i><span>成绩管理</span></a></li>
                <li><a href="#"><i class="fa fa-list-ul"></i><span>晋级名单管理</span></a></li>
                <li><a href="#"><i class="fa fa-arrow-up"></i><span>上传文件</span></a></li>
                <li><a href="#"><i class="fa fa-arrow-down"></i><span>下载学生答案</span></a></li>
                <li class="treeview">
                    <a href="#"><i class="fa fa-bar-chart"></i> <span>竞赛统计</span>
                        <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
                    </a>
                    <ul class="treeview-menu">
                        <li><a href="#">导出各类名单</a></li>
                        <li><a href="#">成绩统计</a></li>
                    </ul>
                </li>
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
            <iframe scrolling="yes" frameborder="0" style="width:100%;height:540px; overflow:visible;" src="/views/main.html"
                    name="myFrame"></iframe>
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

</div>


<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/adminlte.min.js"></script>
<script>
    $(document).ready(function () {
        $(".sidebar-menu a").click(function () {
            $("#activeLink").text(($(this).text()));
        });
    });
</script>
</body>
</html>