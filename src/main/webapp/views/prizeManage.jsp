<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>奖项管理</title>
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
        <a class="btn bg-purple bt-flat " id="setPrize"><i class="fa fa-trophy"></i> 设置奖项</a>
        <a class="btn bg-purple bt-flat " id="add"><i class="fa fa-plus"></i> 添加</a>
        <a class="btn bg-purple bt-flat " id="update"><i class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
        <a class="btn bg-purple bt-flat " id="importExcel"><i class="fa fa-upload"></i> 导入表格</a>
        <%--<a class="btn bg-purple bt-flat " href="##"><i class="fa fa-download"></i> 导出学生信息</a>--%>
        <a class="btn bg-purple bt-flat " href="${path}/prize/exportPrizeExcelModel"><i class="fa fa-file-excel-o"></i>
            下载导入模板</a>
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
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false"
              style="margin-left: 2px;">
            <div class="form-group">
                <div class="col-sm-1 control-label">学号</div>
                <div class="col-sm-5">
                    <input type="text" id="username" class="form-control" name="username" placeholder="学生编号/团队名称"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">竞赛名称</div>
                <div class="col-sm-5">
                    <select class="selectpicker form-control" id="competitionId" name="competitionId">
                        <c:forEach items="${competitionList}" var="competition">
                            <option value="${competition.cid}">${competition.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">竞赛奖项</div>
                <div class="col-sm-5">
                    <select class="selectpicker form-control" id="prize" name="prize">
                        <option value="一等奖">一等奖</option>
                        <option value="二等奖">二等奖</option>
                        <option value="三等奖">三等奖</option>

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
</div>

<div class="box box-default" id="mySetPrizeBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="mySetPrizeBoxTitle">设置奖项人数</h3>
    </div>
    <div class="box-body">
        <form id="mySetPrizeFrom" class="form-horizontal" method="post" action="##" onsubmit="return false"
              style="margin-left: 2px;">
            <div class="form-group">
                <div class="col-sm-1 control-label">竞赛名称</div>
                <div class="col-sm-5">
                    <select class="selectpicker form-control" id="competition1" name="competition1">
                        <c:forEach items="${singleCompetition}" var="singleCompetition">
                            <option value="${singleCompetition.cid}">${singleCompetition.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">竞赛组别</div>
                <div class="col-sm-5" >
                    <select class="selectpicker form-control" id="competitionGroup1" name="competitionGroup1">
                        <c:forEach items="${singleCompetition.get(0).group.split(',')}" var="group">
                            <option value="${group}">${group}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">一等奖</div>
                <div class="col-sm-5">
                    <input type="text" id="firstPrize" class="form-control" name="firstPrize" placeholder="获得该奖的人数"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">二等奖</div>
                <div class="col-sm-5">
                    <input type="text" id="secondPrize" class="form-control" name="secondPrize" placeholder="获得该奖的人数"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">三等奖</div>
                <div class="col-sm-5">
                    <input type="text" id="thirdPrize" class="form-control" name="thirdPrize" placeholder="获得该奖的人数"/>
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
    function getCompetitionObject() {//将competitionList转成数组,获取竞赛id,组别和竞赛类型
        var competitionArray = [];
        <c:forEach items="${competitionList}" var="competition">
        var competitionObject = {};
        competitionObject.id = '${competition.cid}';
        competitionObject.name = '${competition.name}';
        competitionObject.group = '${competition.group}';
        competitionObject.isTeam = '${competition.isTeam}';
        competitionArray.push(competitionObject);
        </c:forEach>
        return competitionArray;
    }
    function download() {
        /*  var competitionName;
         var competitionArray=getCompetitionObject();
         for(var i=0;i<competitionArray.length;i++){
         if($("#competition").val()===competitionArray[i].id){
         competitionName=competitionArray[i].name;
         break;
         }
         }
         var url = "
      {path}/prize/exportPrizeExcelModel?competitionName=" + competitionName;
         window.location.href = url;*/
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
    function initMyTable(params, titles, sortNum, sortName) {
        var myTable = $("#myTable");
        myTable.bootstrapTable({
            url: "${path}/prize/getPrizeList",//请求后台的url
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
                    id: $("#competition").val(),
                    groupName: $("#competitionGroup").val()
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
                    $.each(result, function (index, content) {//对数组进行循环
                        content["name"] = content["student"].name;
                        content["class"] = content["student"].studentClass;
                        if (content["isLeader"] > 0) {
                            content["isLeader"] = "组长";
                        } else {
                            content["isLeader"] = "组员";
                        }
                    });
                    myTable.bootstrapTable("load", data);
                    if ("teamName" in data["rows"][0] && data["rows"][0].teamName !== null && data["rows"][0].teamName.length > 0) {
                        mergeTable("teamName", myTable, data["rows"]);
                        mergeTable("grade", myTable, data["rows"]);
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

    function getTeam(competition) {
        var competitionObject = getCompetitionObject();
        var selectValue = $("#" + competition).val();
        var isTeam = 0;
        for (var i = 0; i < competitionObject.length; i++) {
            if (selectValue === competitionObject[i].id) {
                isTeam = competitionObject[i].isTeam;
                break;
            }
        }
        return isTeam;
    }
    function refreshTable() {
        var isTeam = getTeam("competition");
        $("#myTable").bootstrapTable('destroy');
        if (isTeam > 0) {
            initMyTable(['id', 'teamName', 'isLeader', 'username', 'name', 'class', 'prize', 'groupName'],
                ['id', '团队名称', '职称', '学号', '姓名', '班级', '奖项', '报名组别'], 6, 'concat(prize,group_name) ');
        } else {
            initMyTable(['id', 'username', 'name', 'class', 'prize', 'groupName'],
                ['id', '学号', '姓名', '班级', '奖项', '报名组别'], 4, 'prize ');
        }
        $("#myTable").bootstrapTable('hideColumn', 'id');
    }
    $(function () {
        refreshTable();
        $("#quit").click(function () {
            $("#myBox").hide();
            $("#myDiv").show();
        });
        $("#return").click(function () {
            $("#mySetPrizeBox").hide();
            $("#myDiv").show();
        });
        $("#add").click(function () {
            $("#myBoxTitle").text("添加奖项");
            $('#username').attr("disabled", false);
            $("#competitionId").prop('disabled', false);
            $("#competitionId").selectpicker('refresh');
            $("#username").val("");
            $("#grade").val("");
            $("#myDiv").hide();
            $("#myBox").show();
        });
        $("#setPrize").click(function () {
            $("#myDiv").hide();
            $("#mySetPrizeBox").show();
        });
        $("#commitButton").click(function () {
            var firstPrize = $("#firstPrize").val();
            var secondPrize = $("#secondPrize").val();
            var thirdPrize = $("#thirdPrize").val();
            if (firstPrize === "" || secondPrize === "" || thirdPrize === "") {
                initMessage("不可以有空项!", 'error');
                return;
            }
            if (isNaN(firstPrize) || isNaN(secondPrize) || isNaN(thirdPrize)) {
                initMessage("获得奖项人数必须为数字!", 'error');
                return;
            }
            if (parseInt(firstPrize)<0 || parseInt(secondPrize)<0 || parseInt(thirdPrize)<0) {
                initMessage("获得奖项人数不能小于0!", 'error');
                return;
            }
            var prizeNum = [];
            prizeNum.push(firstPrize);
            prizeNum.push(secondPrize);
            prizeNum.push(thirdPrize);
            var paramData = {};
            paramData.competitionId = $("#competition1").val();
            paramData.groupName = $("#competitionGroup1").val();
            paramData.prizeNumber = connectString(prizeNum);
            $.ajax({
                type: 'POST',
                url: "${path}/prize/setPrize",
                data: paramData,
                dataType: "json",
                success: function (data) {
                    var result = data['result'];
                    if (!isNaN(result)) {
                        var resultNum = parseInt(result);
                        if (resultNum > 0) {
                            initMessage("添加成功！", 'success');
                            $("#myTable").bootstrapTable('refresh');
                            $("#mySetPrizeBox").hide();
                            $("#myDiv").show();
                        } else {
                            initMessage("添加失败！", 'error');
                        }
                        return;
                    }
                    initMessage(result, 'error');
                }
            });

        });
        $("#update").click(function () {
            var jsonArray = $("#myTable").bootstrapTable('getSelections');
            if (jsonArray.length < 1) {
                initMessage("请选择一条数据!", 'error');
            } else if (jsonArray.length > 1) {
                initMessage("请选择一条数据,不要多选!", 'error');
            } else {
                $("#myBoxTitle").text("修改奖项");
                var isTeam = getTeam("competition");
                if (isTeam > 0) {
                    $('#username').val(jsonArray[0].teamName);
                } else {
                    $('#username').val(jsonArray[0].username);
                }
                $("#competitionId").selectpicker('val', $("#competition").val());
                $("#myPrize").selectpicker('val', jsonArray[0].prize);
                $("#competitionId").prop('disabled', true);
                $("#competitionId").selectpicker('refresh');
                $('#username').attr("disabled", true);
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
                var text = $("#competition").val();
                for (var i = 0; i < jsonArray.length; i++)
                    ids += jsonArray[i]["id"] + ',';
                $.ajax({
                    type: 'POST',
                    url: "${path}/prize/deletePrize",
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
        $("#importExcel").click(function () {
            var isTeam = getTeam("competition");
            if (isTeam > 0) {
                initMessage("团队赛不支持该功能", 'error');
                return;
            }
            var extraData = {};
            extraData.competitionId = $("#competition").val();
            window.parent.openModel("${path}/prize/importPrizeExcel", "导入表格", extraData);
        });
        $("#submitButton").click(function () {
            var isTeam = getTeam("competitionId");
            var username = $("#username").val();
            var formData = new FormData($("#myFrom")[0]);
            //  var prize = $("#prize").val();
            if ($("#myBoxTitle").text() === "添加奖项") {
                if (username === "") {
                    initMessage("学号(团队名称)不能为空!", "error");
                    return;
                }
                if (isNaN(username) && isTeam == 0) {
                    initMessage("学号为数字!", "error");
                    return;
                }
                formData.append("isTeam", isTeam);
                $.ajax({
                    url: '${path}/prize/addPrize',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        var result = data['result'];
                        if (!isNaN(result)) {
                            var resultNum = parseInt(result);
                            if (resultNum > 0) {
                                initMessage("添加成功！", 'success');
                                $("#myTable").bootstrapTable('refresh');
                                $("#myBox").hide();
                                $("#myDiv").show();
                            } else {
                                initMessage("添加失败！", 'error');
                            }
                            return;
                        }
                        initMessage(result, 'error');

                    }
                });
            } else {
                var jsonArray = $("#myTable").bootstrapTable('getSelections');
                var paramData = {};
                var id;
                paramData.isTeam = isTeam;
                paramData.prize = $("#prize").val();
                if (isTeam > 0) {
                    id = username;
                } else {
                    id = jsonArray[0].id;
                }
                paramData.id = id;
                paramData.competitionId = $("#competitionId").val();
                $.ajax({
                    url: '${path}/prize/updatePrize',
                    type: 'POST',
                    data: paramData,
                    dataType: "json",
                    success: function (data) {
                        var result = data['result'];
                        if (result > 0) {
                            initMessage("修改成功！", 'success');
                            $("#myTable").bootstrapTable('refresh');
                            $("#myBox").hide();
                            $("#myDiv").show();
                        } else {
                            initMessage("修改失败！", 'error');
                        }

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
            refreshTable()
        });
        $("#competition1").change(function () {//竞赛名称改变监听
            var competitionGroup = $("#competitionGroup1");
            var selectValue = $("#competition1").val();
            var group = "";
            var competitionArray = getCompetitionObject();
            var compGroupStartValue = document.getElementById("competitionGroup1");
            for (var j = 0; j < competitionArray.length; j++) {//根据选中的竞赛动态显示竞赛组别
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
                    break;
                }
            }
        });
        $("#competitionGroup").change(function () {//竞赛组别改变监听
            refreshTable()
        });
    });
</script>
</body>
</html>



