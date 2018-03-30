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
    <link rel="stylesheet" type="text/css" href="../resources/css/login.css" />
    <link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.min.css" />
    <script src="../resources/js/jquery.min.js"></script>
    <script src="../resources/js/bootstrap.min.js"></script>
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
        })

        $("button").click(function () {
            var account = $(".acc").val();
            var pwd = $(".password").val()
           // alert(account);
            $.ajax({
                url: "${pageContext.request.contextPath}/login/stuLogin",
                data:{account: account, pwd: pwd},
                success: function(msg){
                    if(msg=="ok"){
                        $.post("${pageContext.request.contextPath}/login/saveToSession",
                            { id: account } );
                        window.location.href="apply_index.jsp"
                    }else {
                        alert("账号或密码不对！");
                    }
                }
            });
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
            <img src="../resources/images/account.png" width="27px" height="27px"/>
            <input class="acc" type="text"  name="account" placeholder="请输入账号"/>
        </div>

        <div class="account">
            <img src="../resources/images/pwd.png" width="27px" height="27px"/>
            <input class="password" type="password" name="pwd"  placeholder="请输入密码"/>
        </div>
        <div class="form-group">
            <div class="col-sm-10">
                <button type="button" class="btn btn-danger col-sm-10"
                        style="width: 300px;height: 50px;margin-top: 10px;">登录</button>
            </div>
        </div>
    </form>
</div>

</body>

</html>
