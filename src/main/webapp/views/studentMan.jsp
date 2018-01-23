<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>学生管理</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/resources/css/bootstrap-table.min.css">
    <style>
        a {
            margin-left: 4px;
            margin-right: 4px;
        }
    </style>
</head>
<body>
<div id="toolbar">
    <a class="btn bg-purple bt-flat " id="addCourse"><i class="fa fa-plus"></i> 添加</a>
    <a class="btn bg-purple bt-flat "><i class="fa fa-edit"></i> 修改</a>
    <a class="btn bg-purple bt-flat "><i class="fa fa-trash-o"></i> 删除</a>
</div>
<table   id="myTable"/>
<%--<table id="listTable" data-click-to-select="true"
       data-toggle="table"
       data-side-pagination="server"
       data-pagination="true"
       data-page-list="[10]"
       data-pagination="true"
       data-page-size="10"
       data-pagination-first-text="首页"
       data-pagination-pre-text="上一页"
       data-pagination-next-text="下一页"
       data-pagination-last-text="末页"
       data-method="post"
       data-row-style="rowStyle"
       data-url="http://localhost:8080/student/getStudentList">
    <thead>
    <tr>
        <th class="text-center" data-field="checkbox" data-checkbox="true"></th>
        <th class="text-center" data-field="username">学号</th>
        <th class="text-center" data-field="name">名字</th>
        <th class="text-center" data-field="password">密码</th>
        <th class="text-center" data-field="college">学院</th>
        <th class="text-center" data-field="studentClass">班级</th>
        <th class="text-center" data-field="phone">手机号码</th>
        <th class="text-center" data-field="email">电子邮箱</th>
    </tr>
    </thead>
</table>--%>
<%-- <table data-toggle="table" data-url="">
     <thead>
     <tr>
         <th class="text-center">学号</th>
         <th class="text-center">名字</th>
         <th class="text-center">密码</th>
         <th class="text-center">班级</th>
         <th class="text-center">学院</th>
         <th class="text-center">手机号码</th>
         <th class="text-center">电子邮箱</th>
     </tr>
     </thead>
 </table>--%>
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/bootstrap-table.min.js"></script>
<script src="/resources/js/bootstrap-table-zh-CN.min.js"></script>

<script>
    $(function () {
          /*  init('#myTable', "http://localhost:8080/student/getStudentList",
                ['username', 'name', 'password', 'studentClass', 'college', 'phone', 'email'],
                ['学号', '姓名', '密码', '班级', '学院', '手机号码', '电子邮箱'], true, '#toolbar');*/
          init();
        });
    function init() {
        $("#myTable").bootstrapTable({
            url: "/student/getStudentList",//请求后台的url
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            dataType: "json",
            striped: true,  //是否显示行间隔色
            cache: false,//是否使用缓存，默认为true
            pagination: true,//是否显示分页
            sortable: false,//是否启用排序
            sortOrder: "asc",//排序方式
//            height: 600,
            toolbar: "#toolbar",//一个jQuery 选择器，指明自定义的toolbar
            queryParams:  function (params) {
                //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                var temp = {
                    limit: params.limit,                         //页面大小
                    offset: (params.offset / params.limit) + 1   //页码
                };
                return temp;
            },//传递参数
            sidePagination: "server",//设置分页方式
            pageNumber: 1,//初始化加载第一页，默认第一页
            pageSize: 10,  //每页显示记录数
            pageList: [5, 10],//可选择每页显示记录数
            search: false, //是否显示表格搜索，为客户端搜索
            strictSearch: false,//设置是否精确查询
            searchOnEnterKey: true,//设置是否回车响应搜索
            clickToSelect: true,//是否启用点击选中行
            minimumCountColumns: 2,//最少允许的列数
             uniqueId: "username",//每一行的唯一标识，一般为主键列
            showToggle: false,//是否显示详细视图和列表视图的切换按钮
            cardView: false,//是否显示详细视图
            detailView: false,//是否显示父子表
            // colums: createCols(param, titles, hasCheckbox),//列配置项
            columns: [{
                checkbox: true,
                visible: true                  //是否显示复选框
            }, {
                field: 'username',
                title: '学号',
                align: "center"

            }, {
                field: 'name',
                title: '姓名',
                align: "center"
            }, {
                field: 'password',
                title: '密码',
                align: "center"

            }, {
                field: 'college',
                title: '学院',
                align: "center"

            }, {
                field: 'studentClass',
                title: '班级',
                align: "center"
            }, {
                field: 'phone',
                title: '手机号码',
                align: "center"
            }, {
                field: 'email',
                title: '电子邮箱',
                align: "center"
               // formatter: emailFormatter
            }]
        });
    }
//    function queryParam(params){
//        var param = {
//            limit : params.limit, // 页面大小
//            offset : params.offset, // 页码
//
//         /*   pageNumber : params.pageNumber,
//            pageSize : params.pageSize*/
//        };
//        return param;
//    }

</script>


</body>
</html>
