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
    <a class="btn bg-purple bt-flat " href="javascript:download()"><i class="fa fa-download"></i> 导出参赛名单</a>
</form>
    <div class="form-group" style="margin-left: -15px;">
        <div class="col-sm-4" style="margin-bottom: 15px;">
            <select class="selectpicker form-control" id="competition" name="competition">
                <option value="0">所有竞赛</option>
                <c:forEach items="${competitionList}" var="competition">
                    <option value="${competition.cid}">${competition.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <table id="statTable">
    </table>
</div>




<script src="${path}/resources/js/jquery.min.js"></script>
<script src="${path}/resources/js/bootstrap.min.js"></script>
<script src="${path}/resources/js/bootstrap-table.min.js"></script>
<script src="${path}/resources/js/bootstrap-table-zh-CN.min.js"></script>
<script src="${path}/resources/js/messenger.min.js"></script>
<script src="${path}/resources/js/bootstrap-select.min.js"></script>
<script src="${path}/resources/js/defaults-zh_CN.min.js"></script>
<script>
    /*  function download() {
     var data = $("#myTable").bootstrapTable('getData', true);//获取当前页面所有数据
     if (data.length === 0) {
     initMessage("没有获奖信息不可以导出！", "error");
     return;
     0
     }
     var url = "{path}/prize/exportPrizeExcel?competitionId=" + $("#competition").val();
     window.location.href = url;
     }*/
    function mergeTable(field, mytable, data) {//一列中如果连续相邻相同则合并
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
                mytable.bootstrapTable('mergeCells', {index: ind, field: field, colspan: 1, rowspan: count});
                ind = ind + count;
                temp = data[i][field];
                count = 1;
            }
        }

    }
    function getCompetitionObject() {//将competitionList转成数组,获取竞赛id,组别和竞赛类型
        var competitionArray = [];
        <c:forEach items="${competitionList}" var="competition">
        var competitionObject = {};
        competitionObject.id = '${competition.cid}';
        competitionObject.name = '${competition.name}';
        competitionArray.push(competitionObject);
        </c:forEach>
        return competitionArray;
    }
    function initMyTable(params, titles) {
        var statTable=$("#statTable");
        statTable.bootstrapTable({
            url: "${path}/competitionStat/getCompetitionStatList",
            method: 'post',
            contentType: "application/x-www-form-urlencoded",//发送到服务器的数据编码类型
            dataType: "json", //服务器返回的数据类型
            striped: true,  //是否显示行间隔色
            cache: false,//是否使用缓存，默认为true
            pagination: false,//是否显示分页
            sortable: true,//是否启用排序
            sortOrder: "asc",//排序方式
            queryParams: function (params) { //传递参数
                var temp = {
                    limit: params.limit,                         //页面大小
                    offset: (params.offset / params.limit) + 1, //页码
                    id: $("#competition").val()
                };
                return temp;
            },
            sidePagination: "server",//设置分页方式
            minimumCountColumns: 2,//最少允许的列数
            columns: createCols(params, titles),
            onLoadSuccess: function (data) {
                if (data["rows"] !== null && data["rows"].length > 0) {
                    var competitionObject = getCompetitionObject();
                    var result = data["rows"];
                    $.each(result, function (index, content) {//对数组进行循环
                        for (var i = 0; i < competitionObject.length; i++) {
                            if (competitionObject[i].id == content["competitionId"]) {
                                content["competitionId"] = competitionObject[i].name;
                                break;
                            }
                        }
                    });
                    statTable.bootstrapTable("load", data);
                    mergeTable("competitionId", statTable, data["rows"]);
                }

                return true;
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
                obje.valign = 'middle';
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

    $(function () {
        initMyTable(['competitionId', 'groupName', 'applyNumber', 'average', 'maxGrape', 'minGrape'],
            ['竞赛名称', '组别', '参加人数', '平均分', '最高分', '最低分']);
        $("#competition").change(function () {
            $("#statTable").bootstrapTable("destroy");
            initMyTable(['competitionId', 'groupName', 'applyNumber', 'average', 'maxGrape', 'minGrape'],
                ['竞赛名称', '组别', '参加人数', '平均分', '最高分', '最低分']);
        });

    });
</script>
</body>
</html>



