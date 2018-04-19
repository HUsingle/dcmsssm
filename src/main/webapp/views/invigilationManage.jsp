<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>安排监考管理</title>
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
        <a class="btn bg-purple bt-flat " id="add"><i class="fa fa-plus"></i>添加</a>
        <a class="btn bg-purple bt-flat " id="update"><i class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
    </form>
    <div class="form-group" style="margin-left: -15px;">
        <div class="col-sm-4" style="margin-bottom: 15px;">
            <select class="selectpicker form-control" id="competition" name="competition">
                <c:forEach items="${competitionList}" var="competition">
                    <option value="${competition.cid}">${competition.name}</option>
                </c:forEach>
            </select>
        </div>

    </div>
    <table id="myTable" >
    </table>
</div>


<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle"></h3>
    </div>

    <div class="box-body">
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false">
            <div class="form-group">
                <div class="col-sm-1 control-label">监考竞赛</div>
                <div class="col-sm-4">
                    <select class="selectpicker form-control" id="competition1" name="competition1">
                        <c:forEach items="${competitionList}" var="competition">
                            <option value="${competition.cid}">${competition.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label">监考教室</div>
                <div class="col-sm-4">
                    <select class="selectpicker form-control" id="classroom" name="classroom">
                        <c:forEach items="${classroomList}" var="classroom">
                            <option value="${classroom.id}">${classroom.site}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">监考老师</div>
                <div class="col-sm-4">
                    <select class="selectpicker form-control" id="teacher" name="teacher" multiple title="选择1项或多项">
                        <c:forEach items="${teacherList}" var="teacher">
                            <option value="${teacher.id}">${teacher.name}</option>
                        </c:forEach>
                    </select>
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
        function getTeacherObject() {//将competitionList转成数组,获取竞赛id,组别和竞赛类型
            var teacherArray = [];
            <c:forEach items="${teacherList}" var="teacher">
            var teacherObject = {};
            teacherObject.id = '${teacher.id}';
            teacherObject.name = '${teacher.name}';
            teacherArray.push(teacherObject);
            </c:forEach>
            return teacherArray;
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
                url: "${path}/invigilation/getInvigilationList",//请求后台的url
                method: 'post',
                contentType: "application/x-www-form-urlencoded",
                dataType: "json",
                striped: true,
                cache: false,
                pagination: true,
                sortable: true,
                queryParams: function (params) {
                    var isSelectAll = 1;
                    var arrays = $("#classroom").val();
                    if (arrays[0] === "0") {
                        isSelectAll = 0;
                    }
                    var temp = {
                        limit: params.limit,
                        offset: (params.offset / params.limit) + 1,
                        id: $("#competition").val()
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
                        var classroomArrays = getClassroomObject();
                        var competitionArrays=getCompetitionObject();
                        $.each(result, function (index, content) {//对数组进行循环
                            content["teacherId"] = content["teacher"].name;
                            content["phone"] = content["teacher"].phone;
                            for (var i = 0; i < competitionArrays.length; i++) {
                                if (content["competitionId"] == competitionArrays[i].id) {
                                    content["competitionId"] = competitionArrays[i].name;
                                    break;
                                }
                            }
                            for (var i = 0; i < classroomArrays.length; i++) {
                                if (content["classroomId"] ==classroomArrays[i].id) {
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
            initMyTable(['id', 'classroomId', 'teacherId', 'phone',  'competitionId'],
                ['id', '监考考场', '监考老师','电话号码',  '监考竞赛']);
            $("#myTable").bootstrapTable('hideColumn', 'id');
            $("#add").click(function () {
                $("#myBoxTitle").text("添加监考信息");
                $("#competition1").prop('disabled', false);
                $("#competition1").selectpicker('refresh');
                $("#myDiv").hide();
                $("#myBox").show();
            });
            $("#update").click(function () {
                var myTable = $("#myTable");
               /* if (myTable.is(':hidden')) {
                    initMessage("没有记录不能进行该操作!", 'error');
                    return;
                }*/
               $("#myBoxTitle").text("修改监考信息");
                var jsonArray = myTable.bootstrapTable('getSelections');
                if (jsonArray.length < 1) {
                    initMessage("请选择一条记录!", 'error');
                } else if (jsonArray.length > 1) {
                    initMessage("仅且能选择一条记录!", 'error');
                } else {
                    var classroomObject = getClassroomObject();
                    var competitionObject=getCompetitionObject();
                    var teacherArrays=getTeacherObject();
                    for (var j = 0; i < competitionObject.length; j++) {
                        if (jsonArray[0].competitionId === competitionObject[j].name) {
                            $("#competition1").selectpicker('val', competitionObject[j].id);
                            break;
                        }
                    }
                    for (var i = 0; i < classroomObject.length; i++) {
                        if (jsonArray[0].classroomId === classroomObject[i].site) {
                            $("#classroom").selectpicker('val', classroomObject[i].id);
                            break;
                        }
                    }
                    for (var k = 0; k < teacherArrays.length; k++) {
                        if (jsonArray[0].teacherId === teacherArrays[k].name) {
                            $("#teacher").selectpicker('val', teacherArrays[k].id);
                            break;
                        }
                    }
                    $("#competition1").prop('disabled', true);
                    $("#competition1").selectpicker('refresh');
                    $("#myDiv").hide();
                    $("#myBox").show();
                }

            });
            $("#quit").click(function () {//点击返回按钮，显示表格，隐藏添加或者修改信息
                $("#myBox").hide();
                $("#myDiv").show();
            });
            $("#delete").click(function () {
                var myTable = $("#myTable");
               // if (myTable.is(':hidden')) {
               /*     initMessage("没有记录不能进行该操作!", 'error');
                    return;
                }*/
                var jsonArray = myTable.bootstrapTable('getSelections');
                if (jsonArray.length < 1) {
                    initMessage("请至少选择一条记录!", 'error');
                } else {
                    var ids = '';
                    for (var i = 0; i < jsonArray.length; i++)
                        ids += jsonArray[i]["id"] + ',';
                    $.ajax({
                        type: 'POST',
                        url: '${path}/invigilation/deleteInvigilation',
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
                var paramData={};
                paramData.competitionId=$("#competition1").val();
                paramData.classroomId=$("#classroom").val();
                var arrays=$("#teacher").val();
                    if ($("#myBoxTitle").text() === "添加监考信息") {

                        paramData.teacherId=connectString(arrays);
                        $.ajax({
                            type: "POST",
                            url: "${path}/invigilation/addInvigilation",
                            dataType: "json",
                            data: paramData,
                            success: function (data) {
                                var result = data['result'];
                                if (!isNaN(result)) {
                                    var resultNum = parseInt(result);
                                    if (resultNum > 0) {
                                        initMessage("添加成功！", 'success');
                                        $("#myTable").bootstrapTable('refresh');
                                    } else {
                                        initMessage("添加失败！", 'error');
                                    }
                                    return
                                }
                                initMessage(result, 'error');
                            }
                        });
                    } else{
                        if(arrays.length>1){
                            initMessage("修改时老师只能选择一项","error");
                            return;
                        }
                        var jsonArray =  $("#myTable").bootstrapTable('getSelections');

                        var teacherArrays=getTeacherObject();
                        var teacherId;
                        var isSame=0;
                        for (var k = 0; k < teacherArrays.length; k++) {
                            if (jsonArray[0].teacherId === teacherArrays[k].name) {
                              teacherId= teacherArrays[k].id;
                                break;
                            }
                        }
                        if(teacherId==arrays[0]){
                            isSame=1;
                        }
                        paramData.teacherId=arrays[0];
                        paramData.id=jsonArray[0].id;
                        paramData.isSame=isSame;
                        $.ajax({
                            type: "POST",
                            url: "${path}/invigilation/updateInvigilation",
                            dataType: "json",
                            data: paramData,
                            success: function (data) {
                                var result = data['result'];
                                if (!isNaN(result)) {
                                    var resultNum = parseInt(result);
                                    if (resultNum > 0) {
                                        initMessage("修改成功！", 'success');
                                        $("#myTable").bootstrapTable('refresh');
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
                $("#myTable").bootstrapTable('destroy');
                initMyTable(['id', 'classroomId', 'teacherId', 'phone',  'competitionId'],
                    ['id', '监考考场', '监考老师', '电话号码',  '监考竞赛']);
                $("#myTable").bootstrapTable('hideColumn', 'id');

            });


        });


    </script>


</body>
</html>


