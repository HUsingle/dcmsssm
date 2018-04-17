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
        <a class="btn bg-purple bt-flat " id="add"><i class="fa fa-plus"></i> 添加</a>
        <a class="btn bg-purple bt-flat " id="update"><i class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
       <%-- <a class="btn bg-purple bt-flat "><i class="fa fa-file-excel-o"></i> 下载导入表格模板</a>
        <a class="btn bg-purple bt-flat " id="importExcel"><i class="fa fa-upload"></i> 导入表格</a>--%>
        <%--<a class="btn bg-purple bt-flat " href=""><i class="fa fa-download"></i> 导出信息</a>--%>

    </form>
    <div class="form-group" style="margin-left: -15px;">
        <div class="col-sm-4" style="margin-bottom: 15px;">
            <select class="selectpicker form-control" id="competition" name="competition">
                <c:forEach items="${competitionList}" var="competition">
                    <option value="${competition.cid}">${competition.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-sm-4" style="margin-bottom: 15px;">
            <select class="selectpicker form-control" id="competitionGroup" name="competitionGroup">
                <option value="">所有竞赛组别</option>
                <c:forEach items="${competitionList.get(0).group.split(',')}" var="group">
                    <option value="${group}">${group}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <table id="myTable">
    </table>
</div>

<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle"></h3>
    </div>

    <div class="box-body">
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false">
            <div class="form-group">
                <div class="col-sm-1 control-label">报名竞赛</div>
                <div class="col-sm-5">
                    <select class="selectpicker form-control" id="competition1" name="competition1">
                        <c:forEach items="${competitionList}" var="competition">
                            <option value="${competition.cid}">${competition.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">报名学号</div>
                <div class="col-sm-5">
                    <select class="selectpicker form-control" id="username" name="username" data-live-search="true">
                        <c:forEach items="${studentList}" var="student">
                            <option value="${student.username}">${student.username}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">报名组别</div>
                <div class="col-sm-5">
                    <select class="selectpicker form-control" id="competitionGroup1" name="competitionGroup1">
                        <c:forEach items="${competitionList.get(0).group.split(',')}" var="group">
                            <option value="${group}">${group}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div id="teamApply">
                <div class="form-group">
                    <div class="col-sm-1 control-label">团队名称</div>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="teamName" name="teamName" placeholder="团队名称"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-1 control-label">报名组员</div>
                    <div class="col-sm-5">
                        <select class="selectpicker form-control" id="grouper" name="grouper" multiple
                                data-live-search="true" data-max-options="3" title="选择1项到3项">
                            <c:forEach items="${studentList}" var="student">
                                <option value="${student.username}">${student.username}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-1 control-label">指导老师</div>
                    <div class="col-sm-5">
                        <select class="selectpicker form-control" id="teacher" name="teacher" data-live-search="true">
                            <c:forEach items="${teacherList}" var="teacher">
                                <option value="${teacher.id}">${teacher.name}</option>
                            </c:forEach>
                        </select>
                    </div>
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
<script>
    function getSelectValue(id) {////根据select的id获取选中的值
        var selectValue = "";
        var obj = document.getElementById(id);
        for (var i = 0; i < obj.options.length; i++) {
            if (obj.options[i].selected) {
                selectValue = obj.options[i].value;//获取选中的值
                break;
            }
        }
        return selectValue;
    }
    function getCompetitionObject() {//将competitionList转成数组,获取竞赛id,组别和竞赛类型
        var competitionArray = [];
        <c:forEach items="${competitionList}" var="competition">
        var competitionObject = {};
        competitionObject.id = '${competition.cid}';
        competitionObject.name = '${competition.name}';
        competitionObject.group = '${competition.group}';
        competitionObject.isTeam = '${competition.isTeam}';
        competitionObject.tid = '${competition.tid}';
        competitionArray.push(competitionObject);
        </c:forEach>
        return competitionArray;
    }
    function mergeTable(field, mytable, data) {//一列中如果连续相邻相同则合并
        //alert(data[0].teacherId);
        var temp = data[0][field];
        var ind = 0;
        var count = 1;
        for (var i = 1; i < data.length; i++) {
            if (data[i][field] === temp) {
                count++;
                if (i === data.length - 1 && count > 1) {
                    mytable.bootstrapTable('mergeCells', {index: ind, field: field, colspan: 1, rowspan: count});
                }
            } else {
                //alert(count);
                mytable.bootstrapTable('mergeCells', {index: ind, field: field, colspan: 1, rowspan: count});
                ind = ind + count;
                temp = data[i][field];
                count = 1;
            }
        }

    }

    function initMyTable(params, titles, sortNum, sortName, pagerNumber, pagerSize) {
        var myTable = $("#myTable");
        myTable.bootstrapTable({
            url: "${path}/apply/getApplyList",//请求后台的url
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
                    sort: sortName + params.order,
                    id: getSelectValue("competition"),
                    groupName: getSelectValue("competitionGroup")
                };
                return temp;
            },
            sidePagination: "server",//设置分页方式
            pageNumber: 1,
            pageSize: pagerSize,
            pageList: pagerNumber,
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
                if (data["rows"] !== null && data["rows"].length > 0 && ("student" in data["rows"][0])) {
                    var result = data["rows"];
                    $.each(result, function (index, content) {//对数组进行循环
                        content["competitionId"] = content["competition"].name;
                        content["name"] = content["student"].name;
                        content["class"] = content["student"].studentClass;
                        content["phone"] = content["student"].phone;
                        if (content["teacherId"] !== null && content["teacherId"] > 0) {
                            content["teacherId"] = content["teacher"].name;
                            if (content["isGroupLeader"] > 0) {
                                content["isGroupLeader"] = "组长";
                            } else {
                                content["isGroupLeader"] = "组员";
                            }
                        }
                    });

                    myTable.bootstrapTable("load", data);
                    // var data = myTable.bootstrapTable('getData', true);//获取当前页面所有数据
                    //合并单元格
                    if ("teacherId" in data["rows"][0] && data["rows"][0].teacherId !== null && data["rows"][0].teacherId.length > 0) {
                        mergeTable("groupName", myTable, data["rows"]);
                        // mergeTable("teacherId", myTable, data["rows"]);
                        //  mergeTable("competitionGroup", myTable, data["rows"]);
                        // mergeTable("applyTime", myTable, data["rows"]);
                    }


                }
                return true;//返回值很重要
            }

        });
        //创建表头
        function createCols(params, titles) {
            if (params.length !== titles.length)
                return null;
            var arr = [];
            var obj = {};
            obj.checkbox = true;
            arr.push(obj);
            for (var i = 0; i < params.length; i++) {
                var obje = {};
                obje.field = params[i];
                obje.title = titles[i];
                if (i === sortNum) {
                    obje.sortable = true;
                }
                obje.align = 'center';
                obje.valign = "middle";
                arr.push(obje);
            }
            return arr;
        }
    }
    function freshTable() {
        var arrays = getCompetitionObject();
        $.each(arrays, function (index, content) {//对数组进行循环
            if (content.id === getSelectValue("competition")) {//
                // alert(content.isTeam);
                if (content.isTeam > 0) {//团队赛
                    // $("#myTable").bootstrapTable("destroy");
                    initMyTable(['id', 'groupName', 'isGroupLeader', 'username', 'name', 'class', 'phone', 'teacherId', 'competitionGroup', 'applyTime'],
                        ['id', '团队名称', '职称', '学号', '姓名', '班级', '电话号码', '指导老师', '报名组别', '报名时间'], -1, 'group_name ', [12, 24, 48], 12);
                    $("#myTable").bootstrapTable('hideColumn', 'id');

                } else {//个人赛
                    initMyTable(['id', 'username', 'name', 'class', 'phone', 'competitionId', 'competitionGroup', 'applyTime'],
                        ['id', '学号', '姓名', '班级', '电话号码', '报名竞赛', '报名组别', '报名时间'], 1, 's_number ', [5, 10, 15, 50], 10);
                    $("#myTable").bootstrapTable('hideColumn', 'id');
                }
                return false;//跳出循环
            }
        });
    }
    function initTeamApplyState() {//根据选中竞赛隐藏或者显示团队模块
        var competitionArray = getCompetitionObject();
        if (competitionArray[0].isTeam > 0) {
            $("#teamApply").show();
        } else {
            $("#teamApply").hide();
        }
    }
    //初始弹出信息
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
    //拼接成字符串，用,隔开
    function connectString(arrays) {
        var result="";
        for (var j = 0; j < arrays.length; j++) {
            if (j === arrays.length - 1) {
                result = result + arrays[j];
            } else {
                result = result + arrays[j] + ",";
            }
        }
        return result;
    }

    $(function () {
        freshTable();
        initTeamApplyState();
        $("#add").click(function () {
            $("#myBoxTitle").text("添加报名信息");
            $("#competition1").prop('disabled', false);
            $("#competition1").selectpicker('refresh');
            var arrays=getCompetitionObject();
            $("#competition1").selectpicker('val',arrays[0].id).trigger("change");
            $("#grouper").selectpicker('val', "");
            $("#teacher").selectpicker('val', arrays[0].tid);
            $("#teamName").val("");
            $("#myDiv").hide();
            $("#myBox").show();
        });
        $("#update").click(function () {
            $("#myBoxTitle").text("修改报名信息");
            var jsonArray = $("#myTable").bootstrapTable('getSelections');
            if (jsonArray.length < 1) {
                initMessage("请选择一条数据!", 'error');
            } else if (jsonArray.length > 1) {
                initMessage("请仅且一条数据!", 'error');
            } else {
                var compArrays = getCompetitionObject();
                var compId = "";
                var compType;
                for (var i = 0; i < compArrays.length; i++) {
                    if (compArrays[i].name === jsonArray[0].competitionId) {
                        compId = compArrays[i].id;
                        compType = compArrays[i].isTeam;
                        break;
                    }
                }
                if (compType > 0) {//如果是团队赛
                    var jsonData;
                    $.ajax({
                        type: "POST",
                        url: "${path}/apply/findApplyByTeamName",
                        data: {"groupName": jsonArray[0].groupName},
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            jsonData = data;
                        }
                    });
                    var grouper = [];
                    $("#competition1").selectpicker('val', jsonData[0].competitionId).trigger("change");
                    for (var t = 0; t < jsonData.length; t++) {
                        if (jsonData[t].isGroupLeader > 0) {
                            $("#username").selectpicker('val', jsonData[t].username);
                        } else {
                            grouper.push(jsonData[t].username)
                        }
                    }
                    $("#competitionGroup1").selectpicker('val', jsonArray[0].competitionGroup);
                    $("#grouper").selectpicker('val', grouper);
                    $("#teacher").selectpicker('val', jsonData[0].teacherId);
                    $("#teamName").val(jsonArray[0].groupName);
                    $("#competition1").prop('disabled', true);
                    $("#competition1").selectpicker('refresh');

                } else {

                    $("#competition1").selectpicker('val', compId).trigger("change");
                    $("#username").selectpicker('val', jsonArray[0].username);
                    $("#competitionGroup1").selectpicker('val', jsonArray[0].competitionGroup);
                    $("#competition1").prop('disabled', true);
                    $("#competition1").selectpicker('refresh');
                }
                $("#myDiv").hide();
                $("#myBox").show();
            }

        });
        $("#quit").click(function () {//点击返回按钮，显示表格，隐藏添加或者修改信息
            $("#myBox").hide();
            $("#myDiv").show();
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
                    url: '${path}/apply/deleteApply',
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
        $("#submitButton").click(function () {
            // var id = key.val();
            var isTeam;
            var compArray = getCompetitionObject();
            for (var i = 0; i < compArray.length; i++) {
                if (compArray[i].id === getSelectValue("competition1")) {
                    isTeam = compArray[i].isTeam;
                    break;
                }
            }
            if ($("#myBoxTitle").text() === "添加报名信息") {
                if (isTeam > 0) {//如果是团队赛
                    var gro = $("#grouper");
                    var teamName = $("#teamName").val();
                    var grouper = gro.val();
                    if (teamName === "") {
                        initMessage("报名的团队名称不能空!", 'error');
                        return;
                    }
                    if (grouper.length === 0) {
                        initMessage("报名的组员不能为空!", 'error');
                        return;
                    }
                    $.ajax({
                        type: "POST",
                        url: "${path}/apply/isExistGroup",
                        data: {"tName": teamName},
                        success: function (data) {
                            if (data === "yes") {//团队名称存在
                                initMessage("该团队名称已经存在！", 'error');
                            } else {//不存在
                                var isExistApply = false;
                                var postData = {};
                                var groupers = $("#username").val() + ",";
                                for (var j = 0; j < grouper.length; j++) {
                                    if (j === grouper.length - 1) {
                                        groupers = groupers + grouper[j];
                                    } else {
                                        groupers = groupers + grouper[j] + ",";
                                    }
                                }
                                var grouperUser = groupers.split(",");
                                var comp1 = $("#competition1");
                                var count = 1;
                                for (var b = 1; b < grouperUser.length; b++) {
                                    if (grouperUser[0] === grouperUser[b]) {
                                        initMessage("组员不可以重复！", 'error');
                                        return;
                                    }
                                }

                                for (var q = 0; q < grouperUser.length; q++) {
                                    $.ajax({
                                        type: "POST",
                                        url: "${path}/apply/isExistSelfInfo",
                                        async: false,//没有返回值之前，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
                                        data: {'compId': comp1.val(), 'stuNo': grouperUser[q]},
                                        success: function (data) {
                                            if (data === "y") {
                                                isExistApply = true;
                                            }
                                        }
                                    });
                                    if (isExistApply) {//判断是否重复报名
                                        initMessage("该团队中存在已经报名该竞赛的成员！", 'error');
                                        return;
                                    }
                                }
                                postData.compId = comp1.val();
                                postData.tid = $("#teacher").val();
                                postData.tName = teamName;
                                postData.groupName = $("#competitionGroup1").val();
                                postData.list = groupers;
                                $.ajax({
                                    type: "POST",
                                    url: "${path}/apply/teamApply",
                                    data: postData,
                                    success: function (data) {
                                        if (data === "ok") {
                                            initMessage("添加成功！", 'success');
                                            $("#myTable").bootstrapTable('refresh');
                                            $("#myBox").hide();
                                            $("#myDiv").show();
                                        } else {
                                            initMessage("添加失败，插入数据存在错误或者服务器异常！", 'error');
                                        }
                                    }
                                });
                            }
                        }
                    });

                } else {//个人赛
                    var postData = {};
                    var username = $("#username").val();
                    postData.compId = $("#competition1").val();
                    postData.stuNo = username;
                    $.ajax({
                        type: "POST",
                        url: "${path}/apply/isExistSelfInfo",
                        data: postData,
                        success: function (data) {
                            if (data === "y") {
                                initMessage("您已经报名该竞赛！", 'error');
                            } else {
                                postData.groupName = $("#competitionGroup1").val();
                                $.ajax({
                                    type: "POST",
                                    url: "${path}/apply/OneSelfApply",
                                    data: postData,
                                    success: function (data) {
                                        if (data === "ok") {
                                            initMessage("添加成功！", 'success');
                                            $("#myTable").bootstrapTable('refresh');
                                            $("#myBox").hide();
                                            $("#myDiv").show();
                                        } else {
                                            initMessage("添加失败，插入数据存在错误或者服务器异常！", 'error');
                                        }
                                    }
                                });
                            }
                        }
                    });
                }
            } else {//修改信息
                if (isTeam > 0) {//如果是团队赛
                    var gro1 = $("#grouper");
                    var teamName1 = $("#teamName").val();//团队名称
                    var grouper1 = gro1.val();//团队成员学号数组
                    if (teamName1 === "") {
                        initMessage("修改的报名团队名称不能空!", 'error');
                        return;
                    }
                    if (grouper1.length === 0) {
                        initMessage("修改的报名组员不能为空!", 'error');
                        return;
                    }
                    var isExistTeamName = false;
                    var jsonArray = $("#myTable").bootstrapTable('getSelections');//获取选中的数据对象
                    if (jsonArray[0].groupName !== teamName1) {//判断修改后的团队名称是否存在
                        $.ajax({
                            type: "POST",
                            url: "${path}/apply/isExistGroup",
                            async: false,
                            data: {"tName": teamName1},
                            success: function (data) {
                                if (data === 'yes') {
                                    isExistTeamName = true;
                                }
                            }
                        });
                    }
                    if (isExistTeamName) {//如果存在
                        initMessage("修改后的团队名称已经存在!", "error");
                        return;
                    }
                    var groupers = $("#username").val() + ",";
                    for (var j = 0; j < grouper1.length; j++) {//将团队成员拼接成字符串，用,隔开
                        if (j === grouper1.length - 1) {
                            groupers = groupers + grouper1[j];
                        } else {
                            groupers = groupers + grouper1[j] + ",";
                        }
                    }
                    //修改后的团队的学号数组
                    //alert(groupers);
                    var grouperUser = groupers.split(",");
                    var comp1 = $("#competition1");
                    //判断组长与组员是否相同
                    for (var b = 1; b < grouperUser.length; b++) {
                        if (grouperUser[0] === grouperUser[b]) {
                            initMessage("组员不可以重复！", 'error');
                            return;
                        }
                    }
                    var jsonData;
                    //获取选中团队相关信息
                    $.ajax({
                        type: "POST",
                        url: "${path}/apply/findApplyByTeamName",
                        data: {"groupName": jsonArray[0].groupName},
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            jsonData = data;
                        }
                    });
                    var userNameArrays = [];//修改前的团队的学号数组
                    var idArrays = "";//要修改信息的报名id字符串，用，隔开
                    for (var a = 0; a < jsonData.length; a++) {
                        userNameArrays.push(jsonData[a].username);
                        if (a === jsonData.length - 1) {
                            idArrays = idArrays + jsonData[a].id;
                        } else {
                            idArrays = idArrays + jsonData[a].id + ",";
                        }
                    }
                    var noEqual = [];//修改后不同的学号
                    var equals=[];//修改后相同的学号
                    var sign = 0;
                    //获取修改后的不同组员的学号
                    for (var v = 0; v < grouperUser.length; v++) {
                        for (var u = 0; u < userNameArrays.length; u++) {
                            if (grouperUser[v] == userNameArrays[u]) {
                                sign++;
                            }
                        }
                        if (sign === 1) {
                            sign = 0;
                            equals.push(grouperUser[v]);
                        } else {
                            noEqual.push(grouperUser[v]);
                        }
                    }
                    //alert(noEqual.toString()+"lasjf");
                    //判断修改后新增的学号是否已经报名该竞赛
                    var isExistApply = false;
                    for (var q = 0; q < noEqual.length; q++) {
                        $.ajax({
                            type: "POST",
                            url: "${path}/apply/isExistSelfInfo",
                            async: false,//没有返回值之前，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
                            data: {'compId': comp1.val(), 'stuNo': noEqual[q]},
                            success: function (data) {
                                if (data === "y") {
                                    isExistApply = true;
                                }
                            }
                        });
                        if (isExistApply) {//判断修改后的是否重复报名
                            initMessage("修改后的报名成员中已经报名，不可以重复报名！", 'error');
                            return;
                        }
                    }
                    for(var c=0;c<noEqual.length;c++){
                       equals.push(noEqual[c]);
                    }
                    var isLeader=[];
                    for (var w=0;w<equals.length;w++){
                        if(equals[w]==$("#username").val()){
                            isLeader.push(1);
                        }else{
                            isLeader.push(0);
                        }
                    }
                    var postData2 = {};
                    postData2.compId = comp1.val();
                    postData2.tid = $("#teacher").val();
                    postData2.tName = teamName1;
                    postData2.groupName = $("#competitionGroup1").val();
                    postData2.isGroupLeader = connectString(isLeader);
                    //var member = "";
                  /*  if (noEqual.length > 0) {//拼接新成员学号
                        member=connectString(noEqual);
                        postData2.list = member;
                        //增加新的成员
                        $.ajax({
                            type: "POST",
                            url: "${path}/apply/teamApply",
                            data: postData2,
                            success: function (data) {
                            }
                        });
                    }*/
                    postData2.list = connectString(equals);
                    postData2.id = idArrays;
                    //修改原来的成员信息
                    $.ajax({
                        type: "POST",
                        url: "${path}/apply/updateTeamApply",
                        data: postData2,
                        dataType:"json",
                        success: function (data) {
                            if (data["result"] > 0) {
                                initMessage("修改成功！", 'success');
                                $("#myTable").bootstrapTable('refresh');
                                $("#myBox").hide();
                                $("#myDiv").show();
                            } else {
                                initMessage("修改失败，修改数据存在错误或者服务器异常！", 'error');
                            }
                        }
                    });

                }
                else {//个人赛
                    var selectData = $("#myTable").bootstrapTable('getSelections');
                    var postData1 = {};
                    var username1 = $("#username").val();
                    var sign1 = false;
                    postData1.compId = $("#competition1").val();
                    postData1.stuNo = username1;
                    if (selectData[0].username != username1) {
                        $.ajax({
                            type: "POST",
                            url: "${path}/apply/isExistSelfInfo",
                            data: postData1,
                            async: false,
                            success: function (data) {
                                if (data === "y") {
                                    sign1 = true;
                                }

                            }
                        });
                    }

                    if (sign1) {
                        initMessage("修改的学生已经报名该竞赛！", 'error');
                    } else {
                        postData1.groupName = $("#competitionGroup1").val();
                        postData1.id = selectData[0].id;
                        $.ajax({
                            type: "POST",
                            url: "${path}/apply/updateOneSelfApply",
                            data: postData1,
                            success: function (data) {
                                if (data['result'] > 0) {
                                    initMessage("修改成功！", 'success');
                                    $("#myTable").bootstrapTable('refresh');
                                    $("#myBox").hide();
                                    $("#myDiv").show();
                                } else {
                                    initMessage("修改失败，插入数据存在错误或者服务器异常！", 'error');
                                }
                            }
                        });
                    }

                }
            }
        });
        $("#competition").change(function () {//竞赛名称改变监听
            var competitionGroup = $("#competitionGroup");
            var selectValue = getSelectValue("competition");
            var group = "";
            var competitionArray = getCompetitionObject();
            var compGroupStartValue = document.getElementById("competitionGroup");
            //var compGroupLength = compGroupStartValue.options.length;
            for (var j = 0; j < competitionArray.length; j++) {//根据选中的竞赛动态显示竞赛组别
                if (competitionArray[j].id === selectValue) {
                    group = competitionArray[j].group.split(",");
                    compGroupStartValue.options.length = 0;
                    competitionGroup.selectpicker('refresh');
                    competitionGroup.selectpicker('render');
                    competitionGroup.append("<option value=''>" + "所有竞赛组别" + "</option>");
                    for (var k = 0; k < group.length; k++) {
                        competitionGroup.append("<option value='" + group[k] + "'>" + group[k] + "</option>");
                    }
                    competitionGroup.selectpicker('refresh');
                    competitionGroup.selectpicker('render');
                    break;
                }
            }
            $("#myTable").bootstrapTable("destroy");
            freshTable();
        });
        $("#competition1").change(function () {//竞赛名称改变监听
            var competitionGroup = $("#competitionGroup1");
            var selectValue = getSelectValue("competition1");
            var group = "";
            var competitionArray = getCompetitionObject();//获取所有竞赛信息
            var compGroupStartValue = document.getElementById("competitionGroup1");
            // var compGroupLength = compGroupStartValue.options.length;
            for (var j = 0; j < competitionArray.length; j++) {//根据选中的竞赛动态显示竞赛组别
                //获取选中竞赛的组别
                if (competitionArray[j].id === selectValue) {
                    group = competitionArray[j].group.split(",");
                    compGroupStartValue.options.length = 0;
                    competitionGroup.selectpicker('refresh');
                    competitionGroup.selectpicker('render');
                    for (var k = 0; k < group.length; k++) {
                        competitionGroup.append("<option value='" + group[k] + "'>" + group[k] + "</option>");
                    }
                    competitionGroup.selectpicker('refresh');
                    competitionGroup.selectpicker('render');
                    if (competitionArray[j].isTeam > 0) {
                        $("#teamApply").show();
                    } else {
                        $("#teamApply").hide();
                    }
                    break;
                }
            }

        });
        $("#competitionGroup").change(function () {//竞赛组别改变监听
            $("#myTable").bootstrapTable("destroy");
            freshTable();
        });
    })
    ;


</script>


</body>
</html>

