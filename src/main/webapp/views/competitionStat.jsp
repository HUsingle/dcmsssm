<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>竞赛统计</title>
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
        <a class="btn bg-orange bt-flat " id="statTable"><i class="fa fa-trophy"></i> 统计表格</a>
        <a class="btn bg-orange bt-flat " id="barGraph"><i class="fa fa-th"></i> 柱状图</a>
        <a class="btn bg-purple bt-flat " href="javascript:"><i class="fa fa-download"></i> 导出参赛名单</a>
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
        var data = $("#myTable").bootstrapTable('getData', true);//获取当前页面所有数据
        if(data.length===0){
            initMessage("没有获奖信息不可以导出！","error");
            return;0
        }
        var url = "${path}/prize/exportPrizeExcel?competitionId=" + $("#competition").val();
        window.location.href = url;
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
            url: "${path}/",//请求后台的url
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



    });
</script>
</body>
</html>



