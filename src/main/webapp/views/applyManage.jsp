<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>报名管理</title>
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
        <input id="search" style="display: none;">
        <a class="btn bg-purple bt-flat " id="add"><i class="fa fa-plus"></i> 添加</a>
        <a class="btn bg-purple bt-flat " id="update"><i class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
        <a class="btn bg-purple bt-flat " id="importExcel"><i class="fa fa-upload"></i> 导入表格</a>
        <a class="btn bg-purple bt-flat " href=""><i class="fa fa-download"></i> 导出信息</a>
        <a class="btn bg-purple bt-flat " href=""><i class="fa fa-file-excel-o"></i> 下载导入表格模板</a>

    </form>
    <div class="form-group" style="margin-left: -13px;">
        <div class="col-sm-4">
            <select class="selectpicker form-control" id="competition" name="competition">
                <c:forEach items="${competitionList}" var="competition">
                    <option value="${competition.cid}">${competition.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-sm-4">
            <select class="selectpicker form-control" id="competitionGroup" name="competitionGroup">
                <option>所有竞赛组别</option>
                <c:forEach items="${competitionList.get(0).group.split(',')}" var="group">
                    <option>${group}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <table id="myTable">
    </table>
</div>

<%--<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle"></h3>
    </div>

    <div class="box-body">
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false">

            <div class="form-group">
                <div class="col-sm-1 control-label">学号</div>
                <div class="col-sm-3">
                    <input type="text" id="username" class="form-control" name="username" placeholder="学生编号"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">姓名</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="name" name="name" placeholder="姓名"/>
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
                <div class="col-sm-1 control-label">专业班级</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="studentClass" name="studentClass" placeholder="专业班级"/>
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

</div>--%>


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
            contentType: "application/x-www-form-urlencoded",
            dataType: "json",
            striped: true,
            cache: false,
            pagination: true,
            sortable: true,
            sortOrder: "asc",
            queryParams: function (params) {
                var temp = {
                    limit: params.limit,
                    offset: (params.offset / params.limit) + 1,
                    sort: params.order,
                    search: $("#search").val()
                };
                return temp;
            },
            sidePagination: "server",//设置分页方式
            pageNumber: 1,
            pageSize: 10,
            pageList: [5, 10, 15],
            search: false,
            strictSearch: false,
            searchOnEnterKey: false,
            clickToSelect: true,
            minimumCountColumns: 2,
            showToggle: false,
            cardView: false,
            detailView: false,
            columns: createCols(params, titles, hasCheckbox),
            onLoadSuccess: function (data) {
                if (data.total && !data.rows.length) {
                    $(table).bootstrapTable('prevPage').bootstrapTable('refresh');
                }

                if (data["rows"]!==null&&data["rows"].length>0&&("teacher" in data["rows"][0])) {//返回数据有老师这个变量
                    var result = data["rows"];
                    $.each(result, function (index, content) {//对数组进行循环
                        if (content["isTeam"] === 1) {
                            content["isTeam"] = "团队赛";
                        } else {
                            content["isTeam"] = "个人赛";
                        }
                        content["tid"] = content["teacher"].name;
                        if (!("compeStartTime" in content))
                            content.compeStartTime = "";
                        if (!("compeEndTime" in content))
                            content.compeEndTime = "";
                        if (!("applyStart" in content))
                            content.applyStart = "";
                        if (!("applyEnd" in content))
                            content.applyEnd = "";
                        if (!("file" in content))
                            content.file = "";
                        //}
                    });
                    $(table).bootstrapTable("load", data);
                }
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
    $(function () {
        $("#competition").change(function () {
            var selectValue = "";
            var competitionGroup = $("#competitionGroup");
            var obj = document.getElementById("competition");
            for (var i = 0; i < obj.options.length; i++) {
                if (obj.options[i].selected) {
                    selectValue = obj.options[i].value;//获取选中的竞赛
                }
            }

            var group = "";
            var competitionArray=[];
            <c:forEach items="${competitionList}" var="competition">
              var competitionObject={};
              competitionObject.id='${competition.cid}';
              competitionObject.group='${competition.group}';
              competitionArray.push(competitionObject);
            </c:forEach>
            var compGroupStartValue = document.getElementById("competitionGroup");
            var compGroupLength=compGroupStartValue.options.length;
            for (var j = 0; j < competitionArray.length; j++) {//根据选中的竞赛动态显示竞赛组别
                if ( competitionArray[j].id=== selectValue) {
                    group = competitionArray[j].group.split(",");
                    compGroupStartValue.options.length=0;
                    competitionGroup.selectpicker('refresh');
                    competitionGroup.selectpicker('render');
                    competitionGroup.append("<option>" + "所有竞赛组别" + "</option>");
                    for (var k = 0; k < group.length; k++) {
                        competitionGroup.append("<option>" + group[k] + "</option>");
                    }
                    competitionGroup.selectpicker('refresh');
                    competitionGroup.selectpicker('render');
                    break;
                }
            }

        });
    });


</script>


</body>
</html>

