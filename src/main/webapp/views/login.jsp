<%--
  Created by IntelliJ IDEA.
  User: zx
  Date: 2018/3/29
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/c.png" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sweet-alert.css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sweet-alert.min.js"></script>
</head>

<body>
<script>

    $(document).ready(function () {

        $(".select_it").css("color","white","background-color","#ee6666");
        $("ul").on("click","a",function () {
            $("a").css({"color":"floralwhite","background-color":"#AAAAAA"});
            $("a").removeClass("selected");
            $(this).addClass("selected");
            $(this).css({"color":"white","background-color":"#ee6666"});
        });

        $("#commit").click(function () {
            var account = $(".acc").val();
            var pwd = $(".password").val();
            if(account===""||pwd===""){
                swal({
                    title: "提示",
                    text: "账号或密码不能为空!"
                });
                return;
            }
            var  type=$('ul').children().find(".selected").text();
            if(type==="学生"){
                $.ajax({
                    url: "${pageContext.request.contextPath}/stuLogin",
                    type:"post",
                    data:{account: account, pwd: pwd},
                    success: function(msg){
                        if(msg=="ok"){
                            $.post("${pageContext.request.contextPath}/saveToSession",
                                { id: account },function (mag) {
                                    if(msg=="ok"){
                                        window.location.href="${pageContext.request.contextPath}/views/apply_index.jsp";
                                    }
                                } );

                        }else {
                            swal({
                                title: "提示",
                                text: "账号或密码不正确!"
                            });
                        }
                    }
                });
            }else{
                $.ajax({
                    url: "${pageContext.request.contextPath}/teaLogin",
                    type:"post",
                    data:{account: account, pwd: pwd},
                    success: function(msg){
                        if(msg=="ok"){
                            $.post("${pageContext.request.contextPath}/saveTeacherToSession",
                                { phone: account },function (mag) {
                                    if(msg=="ok"){
                                        window.location.href="${pageContext.request.contextPath}/views/manageIndex.jsp";
                                    }
                                } );

                        }else {
                            swal({
                                title: "提示",
                                text: "账号或密码不正确!"
                            });
                        }
                    }
                });
            }

           })
    })
</script>
<div class="title">
    学科竞赛报名系统
</div>
<div class="login">
    <ul class="nav nav-tabs identity" >
        <li ><a href="#" class="selected" style="color: white;background-color: #ee6666;">学生</a></li>
        <li ><a href="#"  style="color: floralwhite;background-color: #AAAAAA;">老师</a></li>

    </ul>
    <form class="form-horizontal" role="form" >
        <div class="account">
            <img src="${pageContext.request.contextPath}/resources/images/account.png" width="27px" height="27px"/>
            <input class="acc" type="text"  name="account" placeholder="请输入账号"/>
        </div>

        <div class="account">
            <img src="${pageContext.request.contextPath}/resources/images/pwd.png" width="27px" height="27px"/>
            <input class="password" type="password" name="pwd"  placeholder="请输入密码"/>
        </div>
        <div class="form-group">
            <div class="col-sm-10">
                <button type="button" class="btn btn-danger col-sm-10"
                        style="width: 300px;height: 50px;margin-top: 10px;" id="commit">登录</button>
            </div>
        </div>
    </form>
</div>

</body>

</html>
