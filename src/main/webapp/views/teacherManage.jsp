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
</head>
<body>
<div id="myDiv">
    <form class="form-horizontal" style="margin-left: -3px;margin-bottom: 15px;">
        <a class="btn bg-purple bt-flat " id="add"><i class="fa fa-plus"></i> 添加</a>
        <a class="btn bg-purple bt-flat " id="updateTeacher"><i class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
        <a class="btn bg-purple bt-flat " id="importExcel"><i class="fa fa-upload"></i> 导入表格</a>
        <a class="btn bg-purple bt-flat " href="${path}/teacher/exportTeacherExcelModel"><i
                class="fa fa-file-excel-o"></i> 下载导入表格模板</a>
    </form>
    <table id="myTable">
    </table>
</div>

<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle"></h3>
    </div>

    <div class="box-body">
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false">
            <div class="form-group" style="display:none;">
                <div class="col-sm-1 control-label">id</div>
                <div class="col-sm-3">
                    <input type="text" id="id" class="form-control" name="id" placeholder="id"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">姓名</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="name" name="name" placeholder="姓名"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">性别</div>
                <div class="col-sm-3">
                    <select class="selectpicker form-control" id="sex" name="sex">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">密码</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="password" name="password" placeholder="密码"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">学院</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="college" name="college" placeholder="学院"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">手机号</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="手机号"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label">电子邮箱</div>
                <div class="col-sm-3">
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

<script src="${path}/resources/js/jquery.min.js"></script>
<script src="${path}/resources/js/bootstrap.min.js"></script>
<script src="${path}/resources/js/bootstrap-table.min.js"></script>
<script src="${path}/resources/js/bootstrap-table-zh-CN.min.js"></script>
<script src="${path}/resources/js/messenger.min.js"></script>
<script src="${path}/resources/js/bootstrap-select.min.js"></script>
<script src="${path}/resources/js/defaults-zh_CN.min.js"></script>
<script src="${path}/resources/js/create-table.js"></script>
<script>
    function initMyTable(table, url, params, titles, hasCheckbox, sortNum) {
        $(table).bootstrapTable({
            url: url,//请求后台的url
            method: 'post',
            contentType: "application/x-www-form-urlencoded",//发送到服务器的数据编码类型
            dataType: "json", //服务器返回的数据类型
            striped: true,  //是否显示行间隔色
            cache: false,//是否使用缓存，默认为true
            pagination: true,//是否显示分页
            sortable: true,//是否启用排序
            sortOrder: "asc",//排序方式
            //  sortClass:"username",
            //sortName:"username",
            // toolbar: toolbar,//一个jQuery 选择器，指明自定义的toolbar
            queryParams: function (params) { //传递参数
                //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                var temp = {
                    limit: params.limit,                         //页面大小
                    offset: (params.offset / params.limit) + 1, //页码
                    sort: params.order,
                    id: ${sessionScope.account.id}
                };
                return temp;
            },
            sidePagination: "server",//设置分页方式
            pageNumber: 1,//初始化加载第一页，默认第一页
            pageSize: 10,  //每页显示记录数
            pageList: [5, 10, 15],//可选择每页显示记录数
            search: false, //是否显示表格搜索，为客户端搜索
            strictSearch: false,//设置是否精确查询
            searchOnEnterKey: false,//设置是否回车响应搜索
            clickToSelect: true,//是否启用点击选中行
            minimumCountColumns: 2,//最少允许的列数
            //uniqueId: "username",//每一行的唯一标识，一般为主键列
            showToggle: false,//是否显示详细视图和列表视图的切换按钮
            //showRefresh: true,//是否显示刷新按钮
            cardView: false,//是否显示详细视图
            detailView: false,//是否显示父子表
            columns: createCols(params, titles, hasCheckbox),//列配置项
            onLoadSuccess: function (data) { //加载成功时执行
                if (data.total && !data.rows.length) {
                    $(table).bootstrapTable('prevPage').bootstrapTable('refresh');
                }
                //竞赛管理相关操作
                return true;//返回值很重要
            }

        });
        //创建表头
        function createCols(params, titles, hasCheckbox) {
            if (params.length !== titles.length)
                return null;
            var arr = [];
            if (hasCheckbox) {
                var obj = {};
                obj.checkbox = true;
                arr.push(obj);
            }
            for (var i = 0; i < params.length; i++) {
                var obje = {};
                obje.field = params[i];
                obje.title = titles[i];
                if (i === sortNum) {
                    obje.sortable = true;
                }
                obje.align = 'center';
                arr.push(obje);
            }
            return arr;
        }
    }
    function initInformation(inputFields) {
        $("#add").click(function () {
            $("#myBoxTitle").text("添加老师");
            for (var i = 0; i < inputFields.length; i++)
                $('#' + inputFields[i]).val("");
            $('#' + inputFields[0]).attr("disabled", false);
            $("#myDiv").hide();
            $("#myBox").show();
        });
        $("#updateTeacher").click(function () {
            var jsonArray = $("#myTable").bootstrapTable('getSelections');
            if (jsonArray.length < 1) {
                initMessage("请选择一条数据!", 'error');
            } else if (jsonArray.length > 1) {
                initMessage("请选择一条数据,不要多选!", 'error');
            } else {
                $("#myBoxTitle").text("修改老师");
                for (var i = 0; i < inputFields.length; i++) {
                    $('#' + inputFields[i]).val(jsonArray[0][inputFields[i]]);
                }
                $('#' + inputFields[0]).attr("disabled", true);
                $("#sex").selectpicker('val',jsonArray[0].sex);
                $("#myDiv").hide();
                $("#myBox").show();
            }
        });

        $("#delete").click(function () {
            var jsonArray = $("#myTable").bootstrapTable('getSelections');
            if (jsonArray.length < 1) {
                initMessage("请至少选择一条记录!", 'error');
            } else {
                var ids = '';
                for (var i = 0; i < jsonArray.length; i++)
                    ids += jsonArray[i]["id"] + ',';
                $.ajax({
                    type: 'POST',
                    url: "${path}/teacher/deleteTeacher",
                    data: {
                        'id': ids
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data['result'] > 0) {
                            initMessage("删除成功！", 'success');
                            $("#myTable").bootstrapTable('refresh');

                        } else {
                            initMessage("删除失败！", 'error');
                        }
                    }
                });
            }
        });

    }
    function initAddOrUpdate() {
        $("#quit").click(function () {//点击返回按钮，显示表格，隐藏添加或者修改信息
            $("#myBox").hide();
            $("#myDiv").show();
        });
        $("#submitButton").click(function () {
            var phone=$("#phone").val();
            var password=$("#password").val();
            if(phone===""||password===""){
                initMessage("密码或者手机号码不可以为空!","error");
                return;
            }
            var id = $("#id").val();
                if ($("#myBoxTitle").text() === "添加老师") {
                    $.ajax({
                        type: "POST",
                        url: "${path}/teacher/addTeacher",
                        dataType: "json",
                        data: $("#myFrom").serialize(),
                        success: function (data) {
                            if (data['result'] > 0) {
                                if (data['result'] === 1) {
                                    initMessage("添加成功！", 'success');
                                } else {
                                    initMessage("该数据已经存在，更新成功！", 'success');
                                }
                                $("#myTable").bootstrapTable('refresh');
                                $("#myBox").hide();
                                $("#myDiv").show();
                            } else {
                                initMessage("手机号码必须为数字！", 'error');
                            }
                        }
                    });
                } else {
                    $.ajax({
                        type: "POST",
                        url: "${path}/teacher/updateTeacher",
                        dataType: "json",
                        data: "id=" + id + "&" + $("#myFrom").serialize(),
                        success: function (data) {
                            if (data['result'] > 0) {
                                initMessage("修改成功！", 'success');
                                $("#myTable").bootstrapTable('refresh');
                                $("#myBox").hide();
                                $("#myDiv").show();
                            } else {
                                initMessage("手机号码必须为数字！", 'error');
                            }
                        }
                    });
                }

        });
    }
    $(function () {
        initMyTable('#myTable', "${path}/teacher/getTeacherList",
            ['id', 'name', 'sex', 'password', 'college', 'phone', 'email'],
            ['编号', '姓名', '性别', '密码', '学院', '手机号码', '电子邮箱'], true, -1);
        $("#myTable").bootstrapTable('hideColumn', 'id');
        initInformation(["id", 'name', 'password', 'college', 'phone', 'email']);
        $("#importExcel").click(function () {
            var extraData = {};
            window.parent.openModel("${path}/teacher/importTeacherExcel", "导入表格", extraData);
        });
        initAddOrUpdate();
    });
</script>
</body>
</html>
