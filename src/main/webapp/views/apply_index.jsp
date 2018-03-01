<%--
  Created by IntelliJ IDEA.
  User: ZX
  Date: 2018/1/21
  Time: 13:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Basic Page Needs
    ================================================== -->
    <meta charset="utf-8">
    <!--[if IE]><meta http-equiv="x-ua-compatible" content="IE=9" /><![endif]-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>主页</title>
    <meta name="description" content="Your Description Here">
    <meta name="keywords" content="bootstrap themes, portfolio, responsive theme">
    <meta name="author" content="ThemeForces.Com">

    <!-- Favicons
    ================================================== -->
    <!--    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="img/apple-touch-icon.png">
        <link rel="apple-touch-icon" sizes="72x72" href="img/apple-touch-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="114x114" href="img/apple-touch-icon-114x114.png">-->

    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css"  href="../resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../resources/fonts/font-awesome/css/font-awesome.css">

    <!-- Stylesheet
    ================================================== -->
    <link rel="stylesheet" type="text/css"  href="../resources/css/style.css">
    <link rel="stylesheet" type="text/css" href="../resources/css/responsive.css">


    <link href='http://fonts.googleapis.com/css?family=Raleway:500,600,700,100,800,900,400,200,300' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Playball' rel='stylesheet' type='text/css'>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div id="tf-home">
    <div class="overlay">
        <div id="sticky-anchor"></div>
        <nav id="tf-menu" class="navbar navbar-default">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand logo" href="index.html">Competition</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#tf-home">主页</a></li>
                        <li><a href="#tf-service">查询</a></li>
                        <li><a href="#tf-portfolio">下载中心</a></li>
                        <li><a href="#tf-about">联系我们</a></li>
                        <li><a href="#tf-contact">个人信息</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>

        <div class="container">
            <div class="content">
                <h1>学科竞赛报名管理系统</h1>
                <h3>软件与信息安全学院</h3>
                <br>
                <a href="#news" class="btn btn-primary my-btn2" style="font-size: 15px;">
                    Start
                </a>
                <!--<a href="#tf-portfolio" class="btn btn-primary my-btn2">Portfolio</a>-->
            </div>
        </div>
    </div>
</div>

<div id="encourage" >
    <br />
    <h1>民大学子的展示平台</h1>
    <p>今朝，软件萌芽。明日，硕果累累。</p>
    <p>程序员们知道有些事情没有用，但是无论如何他们还是会去试一试。</p>

</div>

<div class=".container-fluid" id="message">
    <div class="news_title">
        <h5 class="page-header">
            <span id="span_ icon" >&nbsp;	</span>
            <span id="span_icon _context" >公告	</span>
            <a href="#" class="text-muted" style="">更多</a>
        </h5>


        <div class="news_body">
            <div class="jumbotron">
                <div class="container">
                    <h1 class="">Sorry！</h1>
                    <p>暂时未发布任何资讯，请继续关注。</p>

                </div>
            </div>
        </div>
    </div>
</div>

<div class=".container-fluid" id="news">
    <div class="news_title">
        <h5 class="page-header">
            <span id="span_icon" >&nbsp;	</span>
            <span id="span_icon_context" >最新竞赛	</span>
            <a href="#" class="text-muted" style="margin-left: 76%;">更多</a>
        </h5>

        <div class="news_body" style="width: 850px;">
            <div  style="float: left;width: 400px;height: auto;padding: 10px;">
                <img src="../resources/images/acm.jpg" width="90%" height="90%"/>
            </div>
            <table id="newGame" class="table" style="width: 450px;float: right;">
                <thead>
                <tr>
                    <th>标题</th>
                    <th style="background-color: #ffffff;">首届程序设计竞赛</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th>状态</td>
                    <td>报名进行中</td>
                </tr>
                <tr>
                    <th>竞赛地点</td>
                    <td>文综楼2006</td>
                </tr>
                <tr>
                    <th>参赛对象</td>
                    <td>广西民族大学学生</td>
                </tr>
                <tr>
                    <th>报名时间</td>
                    <td>2017年12月18日 09:00 ~ 2018年02月21日 18:00 </td>
                </tr>
                <tr>
                    <th>竞赛时间</td>
                    <td>2018年03月10日 10:00 ~ 12:30 </td>
                </tr>
                <tr>
                    <th>附件</td>
                    <td>...</td>
                </tr>
                <tr>
                    <td></td>
                    <td><button class="btn btn-success">立即报名</button></td>
                </tr>
                </tbody>
            </table>

        </div>

    </div>

</div>



<!--<h2 class="page-header">
	<div id="">
		<p>asda</p>
	</div>
</h2>-->
<!--最新资讯      标题    作者   时间       内容。。-->
<!--竞赛。-->
<!--瞎扯淡-->

<nav id="tf-footer">
    <div class="container">
        <div class="pull-left">
            <p>2018 © 王胡 &nbsp; &nbsp;赵旭  &nbsp; &nbsp;版权所有</p>
        </div>
        <div class="pull-right">
            <ul class="social-media list-inline">
                <li><a href="#"><span class="fa fa-facebook"></span></a></li>
                <li><a href="#"><span class="fa fa-twitter"></span></a></li>
                <li><a href="#"><span class="fa fa-pinterest"></span></a></li>
                <li><a href="#"><span class="fa fa-google-plus"></span></a></li>
                <li><a href="#"><span class="fa fa-dribbble"></span></a></li>
                <li><a href="#"><span class="fa fa-behance"></span></a></li>
            </ul>
        </div>
    </div>
</nav>


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="../resources/js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script type="text/javascript" src="../resources/js/bootstrap.min.js"></script>

<!-- Javascripts
==================================================  -->
<script type="text/javascript" src="../resources/js/main.js"></script>

</body>
</html>
