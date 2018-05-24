<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>老师管理</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%
        pageContext.setAttribute("path", request.getContextPath());
    %>
    <link rel="stylesheet" href="${path}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="${path}/resources/css/AdminLTE.min.css">
    <link rel="stylesheet" href="${path}/resources/css/bootstrap-table.min.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger-theme-future.css">
    <link rel="stylesheet" href="${path}/resources/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="${path}/resources/css/myCss.css">
    <style>
        .nav li {
            padding-bottom: 20px;
            padding-top: 20px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<div id="myDiv">
    <form class="form-horizontal" style="margin-left: -3px;margin-bottom: 15px;">
        <a class="btn bg-purple bt-flat " id="updateInformation"><i class="fa fa-edit"></i> 修改个人信息</a>
        <a class="btn bg-purple bt-flat " id="update"><i class="fa fa-trash-o"></i> 修改密码</a>
        <a class="btn bg-purple bt-flat " id="inv"><i class="fa fa-user"></i> 我的监考</a>
    </form>
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">个人信息</h3>
        </div>
        <!-- /.box-header -->
        <div class="box-body no-padding">
            <table class="table table-striped">
                <tbody>
                <tr>
                    <td>&nbsp;&nbsp;手机号码</td>
                    <td>${sessionScope.account.phone}</td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;姓名</td>
                    <td>${sessionScope.account.name}</td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;性别</td>
                    <td>${sessionScope.account.sex}</td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;学院</td>
                    <td>${sessionScope.account.college}</td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;电子邮箱</td>
                    <td>${sessionScope.account.email}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <!-- /.box-body -->
    </div>

</div>

<div class="box box-default" id="myTableBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myTableBoxTitle">我的监考</h3>
    </div>
    <button type="button" class="btn btn bg-orange bt-flat" id="returnButton"
            style="margin-left: 10px;margin-top: 10px;">返回
    </button>
    <div class="box-body">
        <table id="myTable">
        </table>
    </div>
</div>

<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle">修改个人信息</h3>
    </div>

    <div class="box-body">
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false">
            <div class="form-group">
                <div class="col-sm-1 control-label">姓名</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="name" name="name" placeholder="姓名" readonly/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">性别</div>
                <div class="col-sm-4">
                    <select class="selectpicker form-control" id="sex" name="sex">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">学院</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="college" name="college" placeholder="学院"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">手机号</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="手机号"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label">电子邮箱</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="email" name="email" placeholder="电子邮箱"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label"></div>
                &nbsp;&nbsp;&nbsp;&nbsp;<button type="button" id="submitButton" class="btn btn bg-purple bt-flat">确定
            </button>
                &nbsp;&nbsp;<button type="button" class="btn btn bg-purple bt-flat" id="quit">返回</button>
            </div>
        </form>
    </div>
</div>

<div class="box box-default" id="myPasswordBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxPasswordTitle">修改密码</h3>
    </div>

    <div class="box-body">
        <form id="myFrom1" class="form-horizontal" method="post" action="##" onsubmit="return false">
            <div class="form-group">
                <div class="col-sm-1 control-label">旧密码</div>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="oldPassword" name="oldPassword" placeholder="旧密码"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label">新密码</div>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="新密码"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">确认密码</div>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="newPassword1" name="newPassword1"
                           placeholder="再次输入新密码"/>
                </div>
            </div>


            <div class="form-group">
                <div class="col-sm-1 control-label"></div>
                &nbsp;&nbsp;&nbsp;&nbsp;<button type="button" id="commitButton" class="btn btn bg-purple bt-flat">确定
            </button>
                &nbsp;&nbsp;<button type="button" class="btn btn bg-purple bt-flat" id="return">返回</button>
            </div>
        </form>
    </div>
</div>
<script src="${path}/resources/js/jquery.min.js"></script>
<script src="${path}/resources/js/bootstrap.min.js"></script>
<script src="${path}/resources/js/bootstrap-table.min.js"></script>
<script src="${path}/resources/js/bootstrap-table-zh-CN.min.js"></script>
<script src="${path}/resources/js/messenger.min.js"></script>
<script src="${path}/resources/js/bootstrap-select.min.js"></script>
<script src="${path}/resources/js/defaults-zh_CN.min.js"></script>
<script>
    function initMessage(message, state) {
        $._messengerDefaults = {
            extraClasses: 'messenger-fixed messenger-theme-future messenger-on-top'
        };
        $.globalMessenger().post({
            message: message,//提示信息
            type: state,//消息类型。error、info、success
            hideAfter: 3,//多长时间消失
            id: 2,
            showCloseButton: true,//是否显示关闭按钮
            hideOnNavigate: true //是否隐藏导航
        });
    }
    function initMyTable(params, titles) {
        var myTable = $("#myTable");
        myTable.bootstrapTable({
            url: "${path}/invigilation/getInvigilationListByTeacherId",//请求后台的url
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            dataType: "json",
            striped: true,
            cache: false,
            pagination: true,
            sortable: true,
            queryParams: function (params) {
                var temp = {
                    limit: params.limit,
                    offset: (params.offset / params.limit) + 1,
                    id: ${sessionScope.account.id}
                };
                return temp;
            },
            sidePagination: "server",//设置分页方式
            pageNumber: 1,
            pageSize: 10,
            pageList: [10, 25, 50],
            search: false,
            strictSearch: false,
            searchOnEnterKey: false,
            clickToSelect: true,
            minimumCountColumns: 2,
            showToggle: false,
            cardView: false,
            detailView: false,
            columns: createCols(params, titles),
            onLoadSuccess: function (data) {
                if (data.total && !data.rows.length) {
                    myTable.bootstrapTable('prevPage').bootstrapTable('refresh');
                }
                if (data["rows"] !== null && data["rows"].length > 0) {
                    var result = data["rows"];
                    $.each(result, function (index, content) {//对数组进行循环
                        content["teacherId"] = content["teacher"].name;
                        content["phone"] = content["teacher"].phone;
                        content["competitionId"] = content["competition"].name;
                        content["time"] = content["competition"].compeStartTime + " ~ " + content["competition"].compeEndTime;
                        content["classroomId"] = content["classroom"].site;
                    });

                    myTable.bootstrapTable("load", data);
                }
                return true;//返回值很重要
            }

        });
        //创建表头
        function createCols(params, titles) {
            if (params.length !== titles.length)
                return null;
            var arr = [];
            for (var i = 0; i < params.length; i++) {
                var obje = {};
                obje.field = params[i];
                obje.title = titles[i];
                obje.align = 'center';
                arr.push(obje);
            }
            return arr;
        }
    }
    $(function () {
        $("#quit").click(function () {
            $("#myBox").hide();
            $("#myDiv").show();
        });
        $("#return").click(function () {
            $("#myPasswordBox").hide();
            $("#myDiv").show();
        });
        $("#returnButton").click(function () {
            $("#myTableBox").hide();
            $("#myDiv").show();
        });
        $("#updateInformation").click(function () {
            $("#myDiv").hide();
            $("#myBox").show();
            $("#name").val("${sessionScope.account.name}");
            $("#sex").selectpicker('val', "${sessionScope.account.sex}");
            $("#college").val("${sessionScope.account.college}");
            $("#phone").val("${sessionScope.account.phone}");
            $("#email").val("${sessionScope.account.email}");
        });
        $("#update").click(function () {
            $("#myDiv").hide();
            $("#myPasswordBox").show();
        });
        $("#submitButton").click(function () {
            var phone = $("#phone").val();
            if (phone === "") {
                initMessage("手机号码不可以为空!", "error");
                return;
            }
            if (isNaN(phone)) {
                initMessage("手机号码必须为数字!", "error");
                return;
            }
            if (phone.length !== 11 || parseInt(phone) <= 0) {
                initMessage("手机号码不正确!", "error");
                return;
            }
            var oldPhone =${sessionScope.account.phone};
            var isExist=false;
            if (oldPhone != phone) {
                $.ajax({
                    type: "POST",
                    url: "${path}/teacher/isExistPhone",
                    dataType: "json",
                    async: false,
                    data: {'phone': phone},
                    success: function (data) {
                        if (data['result'] > 0) {
                            isExist = true;
                        }
                    }
                });
                if (isExist) {
                    initMessage("该手机号码已经存在!", "error");
                    return;
                }
            }
            var paramData = {};
            paramData.id =${sessionScope.account.id};
            paramData.name = "${sessionScope.account.name}";
            paramData.password = "${sessionScope.account.password}";
            paramData.sex = $("#sex").val();
            paramData.phone = phone;
            paramData.email = $("#email").val();
            paramData.college = $("#college").val();
            $.ajax({
                type: "POST",
                url: "${path}/teacher/updateSelfTeacher",
                dataType: "json",
                data: paramData,
                success: function (data) {
                    if (data['result'] > 0) {
                        window.location.href = "${path}/views/teacherSelf.jsp";
                        initMessage("修改成功！", "success");
                    }
                }
            });
        });
        $("#commitButton").click(function () {
            var oldPassword = $("#oldPassword").val();
            var newPassword = $("#newPassword").val();
            var newPassword1 = $("#newPassword1").val();
            if (oldPassword === "" || newPassword === "" || newPassword1 === "") {
                initMessage("不可以有空项!", "error");
                return;
            }
            if (oldPassword != ${sessionScope.account.password}) {
                initMessage("旧密码不正确!", "error");
                return;
            }
            if (newPassword.length < 6 || newPassword.length > 20) {
                initMessage("密码的长度应该在6-20之间!", "error");
                return;
            }
            if (newPassword1 !== newPassword) {
                initMessage("两次新密码不正确!", "error");
                return;
            }
            $.ajax({
                type: "POST",
                url: "${path}/teacher/updateTeacherPassword",
                data: {
                    "id": ${sessionScope.account.id},
                    "password": newPassword
                },
                dataType: "json",
                success: function (data) {
                    if (data["result"] > 0) {
                        window.location.href = "${path}/views/teacherSelf.jsp";
                        initMessage("修改成功！", "success");
                        // $("#myPasswordBox").hide();
                        //  $("#myDiv").show();

                    }
                }
            });
        });
        $("#inv").click(function () {
            $("#myDiv").hide();
            $("#myTableBox").show();
            initMyTable(['id', 'classroomId', 'teacherId', 'phone', 'time', 'competitionId'],
                ['id', '监考考场', '监考老师', '电话号码', '监考时间', '监考竞赛']);
            $("#myTable").bootstrapTable('hideColumn', 'id');
        });
    });

</script>
</body>
</html>
