<%--
  Created by IntelliJ IDEA.
  User: zx
  Date: 2018/4/7
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>团队报名</title>
    <link href="../resources/css/apply_team.css" rel="stylesheet">
    <script src="../resources/js/jquery.min.js"></script>
</head>
<body style="background-color: #ffffff">

<%@ include file="apply_header.jsp" %>
<script>
    //获取地址栏参数
    function getQueryVariable(variable)
    {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i=0;i<vars.length;i++) {
            var pair = vars[i].split("=");
            if(pair[0] == variable){return pair[1];}
        }
        return(false);
    }
    $(document).ready(function () {
        var compId = getQueryVariable("compId");
        var groupName = getQueryVariable("groupName");
        if(groupName==false){
            groupName = "";
        }
        var sno;
        //获取session
        $.post("${pageContext.request.contextPath}/getSession",
            { sessionName: "account" },function (msg) {
                if(msg=="ng"){
                    alert("你还没有登陆，请先登录！")
                    window.location.href="login.jsp";
                }
                else{
                    //获取学生信息
                 sno =msg;
                    $.post("${pageContext.request.contextPath}/student/qryById",
                        { account: sno },function (data) {
                        $(".leader").children().find("h3").html(data[0].name+"<span class=\"snu\" style=\"display: none\">"+sno+"</span>"+"<span style=\"float: right\">项目负责人</span>");
                        $(".leader").children().find("p").eq(0).text("班级："+data[0].studentClass);
                        $(".leader").children().find("p").eq(1).text("电话："+data[0].phone);
                        },"json");
                   if(isApplyed(sno,compId)){
                       alert("你已经报名过，请勿重复操作！");
                       window.location.href="apply_index.jsp";
                   }
                }

            });
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
        //判断学生是否添加过  添加过返回false
        function isStuAdded(id) {
            var flag = false;
            var sList= $(".stu_member_block").children().find(".snu");
            sList.each(function (i) {
                var s = $(this).text();  //取学号
                if(s==id){
                    flag=true;
                    return false; //——跳出所有循环；相当于 javascript 中的 break 效果。
                }
            })
            return flag;
        }
        //判断老师是否添加过  添加过返回false
        function isTeaAdded(id) {
            var flag = false;
            var sList= $(".tea_member_block").children().find("span");
            sList.each(function (i) {
                var s = $(this).text();  //取id
                if(s==id){
                    flag=true;
                    return false; //——跳出所有循环；相当于 javascript 中的 break 效果。
                }
            })
            return flag;
        }
        //判断是否重复报名
        function isApplyed(stuId,compId) {
            var flag;
            $.ajax({
                url: "${pageContext.request.contextPath}/apply/isExistSelfInfo",
                data:{stuNo:stuId,compId:compId},
                async:false,
                success:function (data) {
                    if (data=='y'){
                        flag =true
                    }else{
                        flag = false;
                    }
                }
            });

            return flag;
        }
        //学生模态框点击事件
        var countStu =1;
        $(".modal_submit").click(function () {
            var sno1 = $(".sno").val();
            if(sno1==''){
                alert("学号不能为空！")
            }else {
                $.post("${pageContext.request.contextPath}/student/qryById",
                    { account: sno1 },function (data) {
                        if(data=="ng"||data==null){
                           alert("不存在该学生。");
                        }else{
                            if(isStuAdded(sno1)){    //判断是否添加
                                alert("请不要重复添加！");
                            }else if (isApplyed(sno1,compId)){   //判断是否已经报名
                                alert("该同学已经报名，不可添加！")
                            }else {
                                countStu++;
                                if(count>4){
                                    alert("最多只能添加4位成员！")
                                }else {
                                    //查询学生信息，添加到页面
                                    // $.post("${pageContext.request.contextPath}/student/qryById",
                                    //    { account: sno1 },function (data) {

                                    var $member = $("<div class=\"member\">");
                                    var $panel = $("<div class=\"panel panel-default\">");
                                    var $panHead = $("<div class=\"panel-heading\">");
                                    var $panBody = $("<div class=\"panel-body\">");
                                    $panHead.append("<h3 class=\"panel-title\">"+data[0].name
                                        +"<span class=\"snu\" style=\"display: none\">"
                                        +sno1+"</span><span style=\"float: right\">" +
                                        "团队成员</span></h3>");
                                    $panBody.append("<p>班级："+data[0].studentClass+"</p>");
                                    $panBody.append("<p>电话："+data[0].phone+"</p>");
                                    $panel.append($panHead);
                                    $panel.append($panBody);
                                    $member.append($panel);
                                    $(".stu_member_block").append($member);
                                    $("#myModal").modal('hide');
                                }

                                 //   },"json");
                            }
                        }
                    },"json");
            }
        });
        //教师模态框点击事件
        var count =0;
        $(".teaModal_submit").click(function () {
            var tid = $(".tid").val();
            if(tid==''){
                alert("教师编号不能为空！")
            }else {
                $.post("${pageContext.request.contextPath}/teacher/getTeacherById",
                    { id: tid },function (data) {
                    console.log(data)
                        if(data=="ng"||data==null){
                            alert("不存在该老师。");
                        }else{
                            if(isTeaAdded(tid)){    //判断是否添加
                                alert("请不要重复添加！");
                            }else {
                                count++;
                                if(count>1){
                                    alert("指导老师最多只能有一位");
                                    $("#teaModal").modal('hide');
                                }else{
                                    var $member = $("<div class=\"member\">");
                                    var $panel = $("<div class=\"panel panel-default\">");
                                    var $panHead = $("<div class=\"panel-heading\">");
                                    var $panBody = $("<div class=\"panel-body\">");
                                    $panHead.append("<h3 class=\"panel-title\">"+data[0].name
                                        +"<span class=\"snu\" style=\"display: none\">"
                                        +tid+"</span></h3>");
                                    $panBody.append("<p>学院："+data[0].college+"</p>");
                                    $panBody.append("<p>电话："+data[0].phone+"</p>");
                                    $panel.append($panHead);
                                    $panel.append($panBody);
                                    $member.append($panel);
                                    $(".tea_member_block").append($member);
                                    $("#teaModal").modal('hide');
                                }
                            }
                        }

                    },"json");
            }
        });

        $(".formSubmit").click(function () {
            var tName = $("#firstname").val();
            if (tName.length<6||tName.length>20){
                alert("请输入6-20长度的团队名称")
            }else if(count==0){
                alert("不添加一位指导老师？");
            }else if(countStu==1){
                alert("团队人数不能少于2人！");
            }else {
                //判断是否团队名称已存在
                $.post("${pageContext.request.contextPath}/apply/isExistGroup",{tName:tName},function (data) {
                    if (data=='yes'){
                        alert("此团队名称已被使用，请重新输入！")
                        $("#firstname").val("");
                    }else{
                        var tId = $(".tea_member_block").children().find("span").text();
                        var stus ="";
                        var apply;
                        var $stuList = $(".stu_member_block").children().find("h3")
                        $.each($stuList,function (i) {
                            stus +=$(this).children().eq(0).text()+",";

                        })
                        var str  = stus.substring(0,stus.length-1);
                        if (isApplyEnd()){   //判断报名是否结束
                            alert("抱歉，报名已结束。");
                            window.location.href="apply_index.jsp";
                        }else{
                            $.post("${pageContext.request.contextPath}/apply/teamApply",{list:str,tid:tId,compId:compId,groupName:groupName,tName:tName},function (data) {

                            })
                            alert("报名成功！");
                            window.location.href="apply_index.jsp";
                        }


                    }
                });
            }

        })
    });
</script>
<div id="team_body">
    <ol class="breadcrumb" style="font-size: 15px">
        <li><a href="apply_index.jsp">主页</a></li>
        <li class="active">团队报名</li>
    </ol>
            <h5 class="page-header" style="border-bottom: 2px solid #91361a">
                <span class="span_icon icon" >&nbsp;	</span>
                <span class="span_icon_context" >&nbsp;团队基本信息	</span>
            </h5>
    <div id="context">

        <form class="form-horizontal" role="form">
            <div class="form-group">
                <label for="firstname" class="col-sm-2 control-label">团队名称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="firstname" placeholder="请输入团队名称">
                </div>
            </div>
            <div class="warning" style="margin-left: 7.3%; width: 84%;display: none">
                <div class="alert alert-warning ">警告！团队名称已存在。</div>
            </div>
            <HR WIDTH="90%" COLOR="RED">
            <div class="team_member">
                <div class="team_name_block">
                    <div class="tea_pad" ></div>
                    <div class="team_name">团队成员</div>
                    <div class="tea_pad" ></div>
                </div>
                <div class="add_btn" data-toggle="modal" data-target="#myModal" >+</div>
            </div>

            <div class="stu_member_block">
               <div class="member leader">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <h3 class="panel-title"></h3>
                        </div>
                        <div class="panel-body">
                            <p ></p>
                            <p ></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="team_member">
                <div class="team_name_block">
                    <div class="tea_pad" ></div>
                    <div class="team_name">指导老师</div>
                    <div class="tea_pad" ></div>
                </div>
                <div class="add_btn" data-toggle="modal" data-target="#teaModal">+</div>
            </div>

            <div class="tea_member_block">
                <%--指导老师--%>
            </div>
            <input type="button" value="报名" class="btn btn-lg btn-danger formSubmit" style="float: right;margin-right: 10%">
        </form>

    </div>
</div>
<%@ include file="apply_footer.jsp" %>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    添加成员
                </h4>
            </div>
            <div class="modal_body">
               <input  type="text" class="form-control sno"  placeholder="请输入学号（账号）"
                       onkeyup="this.value=this.value.replace(/\D/g,'')"
                       onafterpaste="this.value=this.value.replace(/\D/g,'')">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary modal_submit">
                    提交
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="teaModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="teaModalLabel">
                    添加指导老师
                </h4>
            </div>
            <div class="modal_body">
                <input  type="text" class="form-control tid"  placeholder="请输入教师编号（账号）"
                        onkeyup="this.value=this.value.replace(/\D/g,'')"
                        onafterpaste="this.value=this.value.replace(/\D/g,'')">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary  teaModal_submit">
                    提交
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>
