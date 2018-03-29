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

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="../resources/js/jquery.min.js"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<script>

    $(document).ready(function () {
        var compId;
        var fileName;
        //获取最新竞赛
        $.ajax({
            url: "${pageContext.request.contextPath}/comp/getLatestComp",
            dataType: "json",
            success: function(msg){
                compId = msg[0].cid;
                filePath = "${pageContext.request.contextPath}/fileOperate/download?filename="+msg[0].file;  //文件路径
                $(".comp_name").text(msg[0].name);
                $(".comp_place").text(msg[0].place);
                $(".comp_end_time").text(msg[0].compeEndTime);
                $(".comp_start_time").text(msg[0].compeStartTime);
                $(".apply_time").text(msg[0].applyStart+"~"+msg[0].applyEnd);
                var start = new Date(msg[0].applyStart).getTime();
                var end = new Date(msg[0].applyEnd).getTime();
                var now = new Date().getTime();
                var str='';    //报名状态
                var color='';  //报名状态字体颜色
                if(now>end){
                    str = '报名已结束';
                    color = 'red';
                }else if(now >start){
                    str = '报名进行中';
                    color = 'green';
                }else {
                    str = '报名未开始';
                    color = 'red';
                }
                $(".comp_state").text(str);
                $(".comp_state").css({ "color": color });   //设置报名状态颜色
                $(".down_file").attr("href",filePath);   //设置下载链接
                $(".file_name").text(msg[0].file)
                $(".down_file:link").css("color","#00ff7f");
                $(".down_file:hover").css({"background-color":"red","color":"yellow"});

            }
        });



        //报名
        $(".apply_at_once").click(function () {
           // var id = 1231;
            //alert(compid)

            $.ajax({
                url: "${pageContext.request.contextPath}/comp/isTeamComp",
                data:{id:compId},
                success: function(msg){
                    var isTeam =${isTeam};
                    alert(isTeam)
                }
            });
        })


    })
</script>
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
            <span class="span_icon icon" >&nbsp;	</span>
            <span class="span_icon_context" >公告	</span>
            <a href="#" class="text-muted" style="float: right">更多</a>
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
            <span class="span_icon" >&nbsp;	</span>
            <span class="span_icon_context" >最新竞赛	</span>
            <a href="#" class="text-muted" style="float: right;">更多</a>
        </h5>

        <div class="news_body" style="width: 850px;">
            <%--<div  style="float: left;width: 400px;height: auto;padding: 10px;">
                <img src="../resources/images/acm.jpg" width="90%" height="90%"/>
            </div>--%>
            <table id="newGame" class="table" style="width: 850px;float: right;">
                <thead>
                <tr>
                    <th>标题</th>
                    <th class="comp_name" style="background-color: #ffffff;" ></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th>状态</td>
                    <td class="comp_state">报名进行中</td>
                </tr>
                <tr>
                    <th>竞赛地点</td>
                    <td class="comp_place"></td>
                </tr>
                <tr>
                    <th>竞赛开始时间</td>
                    <td class="comp_start_time"></td>
                </tr>
                <tr>
                    <th>竞赛结束时间</td>
                    <td class="comp_end_time"></td>
                </tr>
                <tr>
                    <th>报名时间</td>
                    <td class="apply_time"></td>
                </tr>

                <tr>
                    <th>附件</td>
                    <td>

                        <a  class="down_file" >
                            <span class="glyphicon glyphicon-circle-arrow-down" ></span>
                            <span class="file_name" ></span>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><button class="btn btn-success apply_at_once">立即报名</button></td>
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


<!-- Include all compiled plugins (below), or include individual files as needed -->
<script type="text/javascript" src="../resources/js/bootstrap.min.js"></script>

<!-- Javascripts
==================================================  -->
<script type="text/javascript" src="../resources/js/main.js"></script>

</body>
</html>
