<%--
  Created by IntelliJ IDEA.
  User: zx
  Date: 2018/4/7
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>团队报名</title>
    <link href="../resources/css/comp_detail.css" rel="stylesheet">
    <link rel="stylesheet" href="../resources/css/sweet-alert.css">
    <script src="../resources/js/jquery.min.js"></script>
    <script src="../resources/js/sweet-alert.min.js"></script>

</head>
<body style="background-color: #ffffff">

<%@ include file="apply_header.jsp" %>
<div id="context">
    <div class="btn-group " style="margin-bottom: 10px;">
        <button type="button" class="btn btn-success on_apply">报名进行中</button>
        <button type="button" class="btn btn-danger end_apply">已结束</button>
        <button type="button" class="btn btn-warning no_Start">未开始</button>
        <button type="button" class="btn btn-info reLoad">刷新</button>
    </div>
    <div class="panel-group" id="accordion">
            <%--动态添加--%>
    </div>
    <ul class="pagination pagination-lg" style="float: right;">
        <li><a href="#" id="first">首页</a></li>
        <li><a href="#" id="before">上一页</a></li>
        <li><a href="#" id="next">下一页</a></li>
        <li><a href="#" id="last">尾页</a></li>
    </ul>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var offset=1;
        var limit = 5;
        var totalPage = 1;
        var on,end,noStart;  //
        qryData();
        $(".pagination").on("click","a",function () {
            var text =  $(this).attr("id");
            switch(text) {
                case "first":
                    offset = 1;
                    break;

                case "before":
                    if (offset==1){
                        break;
                    }
                    offset--;
                    break;


                case "next":
                    if (offset==totalPage){
                        break;
                    }
                      offset ++;
                    break;

                case "last":
                    offset = totalPage;
                    break;

                default:
                    break;
            }
            console.log(offset);
            qryData();
        });
        $(".on_apply").click(function(){
            on="not empty";  //设为非空
            qryData();
            on=null;
        });
        $(".end_apply").click(function(){
            end="not empty";  //设为非空
            qryData();
            end=null;
        });
        $(".no_Start").click(function(){
            noStart="not empty";  //设为非空
            qryData();
            noStart=null;
        });
        $(".reLoad").click(function(){
            window.location.reload();
        });
        function qryData() {
            $.post("${pageContext.request.contextPath}/comp/qryByPage",{offset:offset,limit:limit,on:on,end:end,noStart:noStart},function(msg){
                if (msg.total%limit==0){
                    totalPage= msg.total/limit;
                }else {
                    totalPage= parseInt(msg.total/limit)+1;
                }
                console.log(msg)
                $("#accordion").empty();
                var data=msg.rows;
                $.each(data,function (i) {
                    var panelObj;
                    var start = new Date(data[i].applyStart).getTime();
                    var end = new Date(data[i].applyEnd).getTime();
                    var now = new Date().getTime();
                    if(now>end){
                        panelObj = $("<div class=\"panel panel-danger\">");   //结束
                    }else if(now >start){
                        panelObj = $("<div class=\"panel panel-info\">");   //进行
                    }else {
                        panelObj = $("<div class=\"panel panel-warning\">");   //结束
                    }

                    var header = $("<div class=\"panel-heading\">");
                    var h4 =$("<a data-toggle=\"collapse\" data-parent=\"#accordion\"  id=\"panel-title\"\n" +
                        " href=\"#collapsebody\">");
                    h4.append(data[i].name+"</a>");
                    header.append(h4);
                    panelObj.append(header);
                    var panelBody =$("<div id=\"collapseOne\" class=\"panel-collapse collapse\">");
                    var bodyTitle = $("<div class=\"panel-body\">");
                    var bodytable = $("<table class=\"table\">");
                    var tBody = $("<tbody>");
                    var trObj = $("<tr>")
                    trObj.append("<td class=\"fir\">竞赛时间</td>");
                    trObj.append("<td>"+data[i].compeStartTime+"~"+data[i].compeEndTime+"</td>");
                    tBody.append(trObj);
                    trObj = $("<tr>");
                    trObj.append("<td class=\"fir\">报名时间</td>");
                    trObj.append("<td>"+data[i].applyStart+"~"+data[i].applyEnd+"</td>");
                    tBody.append(trObj);
                    trObj = $("<tr>");
                    trObj.append("<td class=\"fir\">附件</td>");
                    var tdObj = $("<td>")
                    var base = "${pageContext.request.contextPath}";
                    tdObj.append("<a href=\""+base+"/fileOperate/download?filename="+data[i].file+"\">"+data[i].file+"</a>")
                    trObj.append(tdObj);
                    tBody.append(trObj);
                    bodytable.append(tBody);
                    bodyTitle.append(bodytable);
                    panelBody.append(bodyTitle);
                    panelObj.append(panelBody);
                    $("#accordion").append(panelObj);
                })
            },"json");

        }

    });
    $(function () {
        $("#accordion").on("click","a",function(){
            var obj = $(this).parent().siblings();
            obj.collapse('toggle');
        })

    });
</script>
</body>
</html>
