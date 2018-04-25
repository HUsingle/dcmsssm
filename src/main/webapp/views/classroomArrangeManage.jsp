<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>考场安排管理</title>
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
        <a class="btn bg-purple bt-flat " id="update"><i class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
        <a class="btn bg-purple bt-flat " id="arrange"><i class="fa fa-pencil"></i> 安排考场</a>
        <a class="btn bg-purple bt-flat " id="search"><i class="fa fa-search"></i> 查看考场</a>
        <a class="btn bg-purple bt-flat " href="javascript:download()"><i class="fa fa-download"></i> 导出考场安排信息</a>

    </form>
    <div class="form-group" style="margin-left: -15px;">
        <div class="col-sm-4" style="margin-bottom: 15px;">
            <select class="selectpicker form-control" id="competition" name="competition">
                <c:forEach items="${competitionList}" var="competition">
                    <option value="${competition.cid}">${competition.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-sm-3" style="margin-bottom: 15px;">
            <select class="selectpicker form-control" id="competitionGroup" name="competitionGroup">
                <option value="">所有竞赛组别</option>
                <c:forEach items="${competitionList.get(0).group.split(',')}" var="group">
                    <option value="${group}">${group}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-sm-5" style="margin-bottom: 15px;">
            <select class="selectpicker form-control" id="classroom" name="classroom" multiple title="考场选择1项或多项">
                <option value="0">所有考场</option>
                <c:forEach items="${classroomList}" var="classroom">
                    <option value="${classroom.id}">${classroom.site}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <table id="myTable">
    </table>
</div>

<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle">修改考场安排信息</h3>
    </div>

    <div class="box-body">
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false">
            <div class="form-group">
                <div class="col-sm-1 control-label">座位号</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="seatNumber" name="seatNumber"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">学号</div>
                <div class="col-sm-3">
                    <input type="text" id="username" class="form-control" name="username" readonly/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">姓名</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="name" name="name" readonly/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">专业班级</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="studentClass" name="studentClass" readonly/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">手机号</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="phone" name="phone" readonly/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">所在考场</div>
                <div class="col-sm-3">
                    <select class="selectpicker form-control" id="classroom1" name="classroom1">
                    <c:forEach items="${classroomList}" var="classroom">
                        <option value="${classroom.id}">${classroom.site}</option>
                    </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">报名组别</div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="group" name="group" readonly/>
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
    function getClassroomObject() {//将competitionList转成数组,获取竞赛id,组别和竞赛类型
        var classroomArray = [];
        <c:forEach items="${classroomList}" var="classroom">
        var classroomObject = {};
        classroomObject.id = '${classroom.id}';
        classroomObject.number = '${classroom.number}';
        classroomObject.site = '${classroom.site}';
        classroomArray.push(classroomObject);
        </c:forEach>
        return classroomArray;
    }
    function getCompetitionObject() {//将competitionList转成数组,获取竞赛id,组别和竞赛类型
        var competitionArray = [];
        <c:forEach items="${competitionList}" var="competition">
        var competitionObject = {};
        competitionObject.id = '${competition.cid}';
        competitionObject.name = '${competition.name}';
        competitionObject.group = '${competition.group}';
        competitionArray.push(competitionObject);
        </c:forEach>
        return competitionArray;
    }
    function initMyTable(params, titles) {
        var myTable = $("#myTable");
        myTable.bootstrapTable({
            url: "${path}/classroomArrange/getClassroomArrangeList",//请求后台的url
            method: 'post',
            contentType: "application/x-www-form-urlencoded",
            dataType: "json",
            striped: true,
            cache: false,
            pagination: true,
            sortable: true,
            queryParams: function (params) {
                var isSelectAll=1;
                var arrays = $("#classroom").val();
                if(arrays[0]==="0"){
                    isSelectAll=0;
                }
                var temp = {
                    limit: params.limit,
                    offset: (params.offset / params.limit) + 1,
                    id: $("#competition").val(),
                    groupName: $("#competitionGroup").val(),
                    classroomId: connectString(arrays),
                    isSelectAll:isSelectAll
                };
                return temp;
            },
            sidePagination: "server",//设置分页方式
            pageNumber: 1,
            pageSize: 10,
            pageList: [10, 30, 60],
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
                    var classroomArrays = getClassroomObject();
                    $.each(result, function (index, content) {//对数组进行循环
                        content["name"] = content["apply"]["student"].name;
                        content["class"] = content["apply"]["student"].studentClass;
                        content["phone"] = content["apply"]["student"].phone;
                        content["username"] = content["apply"]["student"].username;
                        content["competitionGroup"] = content["apply"].competitionGroup;
                        content["competitionId"] = content["apply"].competitionId;
                        for (var i = 0; i < classroomArrays.length; i++) {
                            if (content["classroomId"] == classroomArrays[i].id) {
                                content["classroomId"] = classroomArrays[i].site;
                                break;
                            }
                        }
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
            var obj = {};
            obj.checkbox = true;
            arr.push(obj);
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
    function download() {
        var data = $("#myTable").bootstrapTable('getData', true);//获取当前页面所有数据
        if(data.length===0){
            initMessage("没有考场信息不可以导出！","error");
            return;
        }
        var url = "${path}/classroomArrange/exportClassroomArrangeExcel?competitionId=" + $("#competition").val();
        window.location.href = url;
    }
    //拼接成字符串，用,隔开
    function connectString(arrays) {
        var result = "";
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
        $("#classroom").selectpicker('val', "0");
        initMyTable(['id', 'seatNumber', 'username', 'name', 'class', 'phone', 'classroomId', 'competitionGroup'],
            ['id', '座位号', '学号', '姓名', '班级', '电话号码', '考场', '报名组别']);
        $("#myTable").bootstrapTable('hideColumn', 'id');
        $("#update").click(function () {
            var myTable = $("#myTable");
            var jsonArray = myTable.bootstrapTable('getSelections');
            if (jsonArray.length < 1) {
                initMessage("请选择一条记录!", 'error');
            } else if (jsonArray.length > 1) {
                initMessage("仅且能选择一条记录!", 'error');
            } else {
                var classroomObject = getClassroomObject();
                $("#seatNumber").val(jsonArray[0].seatNumber);
                $("#username").val(jsonArray[0].username);
                $("#name").val(jsonArray[0].name);
                $("#studentClass").val(jsonArray[0].class);
                $("#phone").val(jsonArray[0].phone);
                for (var i = 0; i < classroomObject.length; i++) {
                    if (jsonArray[0].classroomId === classroomObject[i].site) {
                        $("#classroom1").selectpicker('val', classroomObject[i].id);
                        break;
                    }
                }
                $("#group").val(jsonArray[0].competitionGroup);
                $("#myDiv").hide();
                $("#myBox").show();
            }

        });
        $("#quit").click(function () {//点击返回按钮，显示表格，隐藏添加或者修改信息
            $("#myBox").hide();
            $("#myDiv").show();
        });
        $("#search").click(function () {
            var arrays = $("#classroom").val();
            if (arrays.length === 0) {
                initMessage("查看考场时请选择相关考场!", 'error');
                return;
            }
            if (arrays[0]==="0"&&arrays.length>1) {
                initMessage("选择所有考场就不要选择其他考场!", 'error');
                return;
            }
            var myTable = $("#myTable");
            myTable.bootstrapTable("destroy");
            initMyTable(['id', 'seatNumber', 'username', 'name', 'class', 'phone', 'classroomId', 'competitionGroup'],
                ['id', '座位号', '学号', '姓名', '班级', '电话号码', '考场', '报名组别']);
            if (myTable.is(':hidden')) {
                myTable.show();
            }
            myTable.bootstrapTable('hideColumn', 'id');

        });
        $("#arrange").click(function () {
            if ($("#competitionGroup").val() === "") {
                initMessage("安排考场时只能一个一个组别安排!", 'error');
                return;
            }
            var arrays = $("#classroom").val();
            if (arrays.length === 0) {
                initMessage("请选择相关考场!", 'error');
                return;
            }
            if (arrays[0] === "0") {
                initMessage("安排考场时不可以选择所有考场!", 'error');
                return;
            }
            var arrayExamRoomNum = [];
            var classroomObject = getClassroomObject();
            for (var i = 0; i < arrays.length; i++) {
                for (var j = 0; j < classroomObject.length; j++) {
                    if (classroomObject[j].id === arrays[i]) {
                        arrayExamRoomNum.push(classroomObject[j].number);
                        break;
                    }
                }
            }
            var paramData = {};
            paramData.competitionId = $("#competition").val();
            paramData.competitionGroup = $("#competitionGroup").val();
            paramData.examRoom = connectString(arrays);
            paramData.peopleNum = connectString(arrayExamRoomNum);
            var myTable=$("#myTable");
            $.ajax({
                type: 'POST',
                url: '${path}/classroomArrange/arrangeExamRoom',
                data: paramData,
                dataType: "json",
                success: function (data) {
                    var result = data['result'];
                    if (!isNaN(result)) {
                        var resultNum = parseInt(result);
                        if (resultNum > 0) {
                            initMessage("安排成功！", 'success');
                            myTable.bootstrapTable("destroy");
                            initMyTable(['id', 'seatNumber', 'username', 'name', 'class', 'phone', 'classroomId', 'competitionGroup'],
                                ['id', '座位号', '学号', '姓名', '班级', '电话号码', '考场', '报名组别']);
                            myTable.bootstrapTable('hideColumn', 'id');
                        } else {
                            initMessage("安排失败！", 'error');
                        }
                        return
                    }
                    initMessage(result, 'error');

                }
            });
        });
        $("#delete").click(function () {
            var myTable = $("#myTable");
            var jsonArray = myTable.bootstrapTable('getSelections');
            if (jsonArray.length < 1) {
                initMessage("请至少选择一条记录!", 'error');
            } else {
                var ids = '';
                for (var i = 0; i < jsonArray.length; i++)
                    ids += jsonArray[i]["id"] + ',';
                $.ajax({
                    type: 'POST',
                    url: '${path}/classroomArrange/deleteClassroomArrange',
                    data: {
                        'id': ids
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data['result'] > 0) {
                            initMessage("删除成功！", 'success');
                            myTable.bootstrapTable('refresh');
                        } else {
                            initMessage("删除失败！", 'error');
                        }
                    }
                });
            }
        });
         $("#submitButton").click(function () {
             var seatNumber=$("#seatNumber").val();
             var classroomId= $("#classroom1").val();
             var classroomObject=getClassroomObject();
             var number;
             for(var i=0;i<classroomObject.length;i++){
                 if(classroomObject[i].id==classroomId){
                     number=classroomObject[i].number;
                     break;
                 }
             }
            if(seatNumber.length>0&&!isNaN(seatNumber)){
                 seatNumber=parseInt(seatNumber);
            }
            if(seatNumber.length===0){
                initMessage("请填写座位号!","error");
            }else if(isNaN(seatNumber)){
                initMessage("座位号要为数字!","error");
            }else if(seatNumber>number||seatNumber<0){
                initMessage("座位号不在考场可安排人数范围!","error");
            }else{
                var myTable = $("#myTable");
                var jsonArray = myTable.bootstrapTable('getSelections');
                var paramData={};
                paramData.id=jsonArray[0].id;
                paramData.seatNumber=seatNumber;
                paramData.classroomId=classroomId;
                paramData.competitionId=jsonArray[0].competitionId;
                $.ajax({
                    type: 'POST',
                    url: '${path}/classroomArrange/updateClassroomArrange',
                    data: paramData,
                    dataType: "json",
                    success: function (data) {
                        var result = data['result'];
                        if (!isNaN(result)) {
                            var resultNum = parseInt(result);
                            if (resultNum > 0) {
                                initMessage("修改成功！", 'success');
                                myTable.bootstrapTable('refresh');
                                $("#myDiv").show();
                                $("#myBox").hide();
                            } else {
                                initMessage("修改失败！", 'error');
                            }
                            return
                        }
                        initMessage(result, 'error');
                    }
                });
            }


         });
        $("#competition").change(function () {//竞赛名称改变监听
            var competitionGroup = $("#competitionGroup");
            var selectValue = $("#competition").val();
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
            //$("#myTable").bootstrapTable("destroy");
            //freshTable();
        });

    });


</script>


</body>
</html>


