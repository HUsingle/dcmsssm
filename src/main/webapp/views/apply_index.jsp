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
    <meta charset="utf-8">
    <meta name="viewport"    content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author"      content="Sergey Pozhilov (GetTemplate.com)">
    <title>Home</title>
    <link rel="stylesheet" href="../resources/css/style.css">
    <link rel="stylesheet" href="../resources/css/sweet-alert.css">
    <script src="../resources/js/sweet-alert.min.js"></script>

</head>

<body class="home">
<%@ include file="apply_header.jsp" %>
<!-- Header -->
<header id="head">
    <div class="container">
        <div class="row">
            <h1 class="lead">学科竞赛报名系统</h1>
            <p class="tagline">软件与信息安全学院</p>
            <!--<p><a class="btn btn-default btn-lg" role="button">MORE INFO</a> <a class="btn btn-action btn-lg" role="button">DOWNLOAD NOW</a></p>-->
        </div>
    </div>
</header>
<!-- /Header -->
<div id="encourage" >
    <br />
    <h1>民大学子的展示平台</h1>
    <p>今朝，软件萌芽。明日，硕果累累。</p>
    <p>程序员们知道有些事情没有用，但是无论如何他们还是会去试一试。</p>

</div>

<div class=".container-fluid" id="message">
    <div class="news_title">
        <h5 class="page-header" style="border-bottom: 2px solid #91361a">
            <span class="span_icon icon" >&nbsp;	</span>
            <span class="span_icon_context" >&nbsp;公告	</span>
            <a href="#" class="text-muted" style="float: right;line-height: 42px;margin-right: 10px">更多</a>
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
        <h5 class="page-header" style="border-bottom: 2px solid #91361a">
            <span class="span_icon" >&nbsp;	</span>
            <span class="span_icon_context" >&nbsp;最新竞赛	</span>
            <a href="#" class="text-muted" style="float: right;line-height: 42px;margin-right: 10px">更多</a>
        </h5>

        <div class="news_body" style="width: 850px;">
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
                    <td class="comp_state"></td>
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
                    <td><button class="btn btn-success apply_at_once" >立即报名</button></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%--引入footer--%>
<%@ include file="apply_footer.jsp" %>

<script>
    var compId;     //竞赛ID
    //判断是否是团队赛
    function isTeamComp() {
        var  isTeam ;
        $.ajax({
            url: "${pageContext.request.contextPath}/comp/isTeamComp",
            data:{id:compId},
            async:false,
            success: function(msg){
                if (msg=="1"){
                    isTeam= true;
                }else {
                    isTeam = false;
                }
            }
        });
        return isTeam;
    }
    //判断报名结束没有，结束返回true   未结束返回false
    function isApplyEnd() {
        var flag;
        $.ajax({
            url: "${pageContext.request.contextPath}/comp/getLatestComp",
            async:false,
            dataType:"json",
            success: function(msg){
                var endTime = new Date(msg[0].applyEnd).getTime();
                var nowTime = new Date().getTime();
                if (endTime<nowTime){   //判断报名是否结束
                    flag= true;
                }else {
                    flag = false;
                }
            }
        });
        return flag;
    }
    $(document).ready(function () {
        //获取最新竞赛
        $.ajax({
            url: "${pageContext.request.contextPath}/comp/getLatestComp",
            dataType: "json",
            success: function(msg){
                compId = msg[0].cid;
                var filePath = "${pageContext.request.contextPath}/fileOperate/download?filename="+msg[0].file;  //文件路径
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
                    $('.apply_at_once').attr("disabled",true);
                }else if(now >start){
                    str = '报名进行中';
                    color = 'green';
                    $('.apply_at_once').attr("disabled",false);
                }else {
                    str = '报名未开始';
                    color = 'red';
                    $('.apply_at_once').attr("disabled",true);
                }
                $(".comp_state").text(str);
                $(".comp_state").css({ "color": color });   //设置报名状态颜色
                $(".down_file").attr("href",filePath);   //设置下载链接
                $(".file_name").text(msg[0].file)
                $(".down_file:link").css("color","#00ff7f");
            }
        });

        //报名
        $(".apply_at_once").click(function () {
            //获取并显示竞赛子类别/分组
            $.ajax({
                url: "${pageContext.request.contextPath}/comp/getCompGroup",
                data:{id:compId},
                success: function(msg){
                    if(msg=="ng"){  //没有子类别
                        //判断是否是团队赛
                        if(isTeamComp()){
                            window.location.href="apply_team.jsp?compId="+compId;
                        }else {
                            $.post("${pageContext.request.contextPath}/apply/isExistSelfInfo",
                                { stuNo: stuNumber,compId:compId},function (data) {
                                    if (data=='y'){
                                        swal({
                                            title: "提示",
                                            text: "请勿重复报名!",
                                        },function(){
                                            window.location.reload();
                                        });
                                    }else {
                                        if (isApplyEnd()){   //判断报名是否结束
                                            swal({
                                                title: "提示",
                                                text: "报名已结束!",
                                            },function(){
                                                window.location.reload();
                                            });
                                        }else {
                                            //插入报名信息
                                            $.post("${pageContext.request.contextPath}/apply/OneSelfApply",
                                                { stuNo: stuNumber,compId:compId,groupName:"" },function (data) {
                                                    swal("恭喜", "报名成功!", "success");
                                                });
                                        }
                                    }
                                });
                        }
                    }else {    //有子类别
                        var group = msg.split(",");    //分割组别
                        $(".modal_context").empty();   //清空模态框内容
                        //动态添加模态框选项
                        $.each(group,function (i) {
                            $(".modal_context").append("<a href=\"#\" class=\"list-group-item\">"+group[i]+"</a>");
                        });
                        $(".modal_submit").hide();      //隐藏模态框提交按钮
                        $("#myModal").modal('show');   //显示模态框
                        var groupStr;
                        //模态框选项单击事件
                        $("#myModal").on("click","a",function () {
                            $(".modal_submit").show();
                            groupStr  = $(this).text();
                        })
                        //模态框提交按钮
                        $(".modal_submit").click(function () {
                            //判断团队赛
                            if(isTeamComp()){
                                window.location.href="apply_team.jsp?compId="+compId+"&groupName="+groupStr;
                            }else{ //不是团队赛，进行单人报名
                                $.post("${pageContext.request.contextPath}/apply/isExistSelfInfo",
                                    { stuNo: stuNumber,compId:compId},function (data) {
                                        if (data=='y'){
                                            swal({
                                                title: "提示",
                                                text: "请勿重复报名!",
                                            },function(){
                                                window.location.reload();
                                            });
                                        }else {
                                            if (isApplyEnd()){   //判断报名是否结束
                                                swal({
                                                    title: "提示",
                                                    text: "报名已结束!",
                                                },function(){
                                                    window.location.reload();
                                                });
                                            }else {
                                                //插入报名信息
                                                $.post("${pageContext.request.contextPath}/apply/OneSelfApply",
                                                    { stuNo: stuNumber,compId:compId,groupName:groupStr },function (data) {
                                                        swal("恭喜", "报名成功!", "success");
                                                    });
                                            }
                                        }
                                    });
                            }


                        })
                    }
                }
            });
        })
    })
</script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script type="text/javascript" src="../resources/js/bootstrap.min.js"></script>
<script src="../resources/js/messenger.min.js"></script>
<!-- Javascripts
==================================================  -->
<script type="text/javascript" src="../resources/js/main.js"></script>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    请选择竞赛组别
                </h4>
            </div>
            <div class="modal_context">

            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-primary modal_submit" data-dismiss="modal" style="display: none">
                    提交
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="../resources/js/bootstrap.min.js"></script>

</body>
</html>
