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
    $(document).ready(function () {
        //获取session
        $.post("${pageContext.request.contextPath}/getSession",
            { sessionName: "account" },function (msg) {
                if(msg=="ng"){
                    alert("你还没有登陆，请先登录！")
                    window.location.href="login.jsp";
                }
                else{
                    //获取学生信息
                  var  sno =msg;
                    $.post("${pageContext.request.contextPath}/student/qryById",
                        { account: sno },function (data) {
                        $(".leader").children().find("h3").html(data[0].name+"<span style=\"float: right\">项目负责人</span>");
                        $(".leader").children().find("p").eq(0).text("班级："+data[0].studentClass);
                        $(".leader").children().find("p").eq(1).text("电话："+data[0].phone);
                        },"json");
                }

            });
        //模态框点击事件
        $(".modal_submit").click(function () {
            var sno = $(".sno").val();
            if(sno.trim()==''){
                alert("学号不能为空！")
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
<%--
                <div class="member ">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">赵旭<span style="float: right">团队成员</span></h3>
                        </div>
                        <div class="panel-body">
                            <p>学校：广西民族大学</p>
                            <p>电话：18068210206</p>
                        </div>
                    </div>
                </div>

                <div class="member ">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">赵旭<span style="float: right">团队成员</span></h3>
                        </div>
                        <div class="panel-body">
                            <p>学校：广西民族大学</p>
                            <p>电话：18068210206</p>
                        </div>
                    </div>
                </div>--%>


            </div>
            <div class="team_member">
                <div class="team_name_block">
                    <div class="tea_pad" ></div>
                    <div class="team_name">指导老师</div>
                    <div class="tea_pad" ></div>
                </div>
                <div class="add_btn">+</div>
            </div>

            <div class="tea_member_block">
                <div class="member ">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">赵旭<span style="float: right">教授</span></h3>
                        </div>
                        <div class="panel-body">
                            <p>学校：广西民族大学</p>
                            <p>电话：18068210206</p>
                        </div>
                    </div>
                </div>

            </div>
            <input type="button" value="提交" class="btn btn-lg btn-danger" style="float: right;margin-right: 10%">
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
</body>
</html>
