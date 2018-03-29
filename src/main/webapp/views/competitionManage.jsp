<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <%--<meta charset="utf-8">--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>竞赛管理</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%
        pageContext.setAttribute("path", request.getContextPath());
    %>
    <link rel="stylesheet" href="${path}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="${path}/resources/css/AdminLTE.min.css">
    <link rel="stylesheet" href="${path}/resources/css/fileinput.min.css">
    <link rel="stylesheet" href="${path}/resources/css/bootstrap-table.min.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger.css">
    <link rel="stylesheet" href="${path}/resources/css/messenger-theme-future.css">
    <link rel="stylesheet" href="${path}/resources/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="${path}/resources/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="${path}/resources/css/myCss.css">
</head>
<body>
<div id="myDiv">
    <form class="form-horizontal" style="margin-left: -3px;margin-bottom: 15px;">
        <input id="search" style="display: none;">
        <a class="btn bg-purple bt-flat " id="add"><i class="fa fa-plus"></i> 添加</a>
        <a class="btn bg-purple bt-flat " id="update" data-toggle="modal" data-target="#myModal"><i
                class="fa fa-edit"></i> 修改</a>
        <a class="btn bg-purple bt-flat " id="delete"><i class="fa fa-trash-o"></i> 删除</a>
    </form>
    <table id="myTable">
    </table>
</div>

<div class="box box-default" id="myBox" style="display: none;">
    <div class="box-header with-border">
        <h3 class="box-title" id="myBoxTitle"></h3>
    </div>

    <div class="box-body" >
        <form id="myFrom" class="form-horizontal" method="post" action="##" onsubmit="return false" enctype="multipart/form-data">
            <div class="form-group" style="display:none;">
                <div class="col-sm-1 control-label">id</div>
                <div class="col-sm-4">
                    <input type="text" id="cid" class="form-control" name="cid"/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">竞赛名称</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="name" name="name" placeholder="竞赛名称"/>
                </div>
                <div class="col-sm-1 control-label">竞赛类型</div>
                <div class="col-sm-4">
                    <select class="selectpicker form-control" id="isTeam" name="isTeam">
                        <option value="0">个人赛</option>
                        <option value="1">团体赛</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-1 control-label">举办单位</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="host" name="host" placeholder="举办单位"/>
                </div>
                <div class="col-sm-1 control-label">比赛地点</div>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="place" name="place" placeholder="比赛地点"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label">开始报名</div>
                <div class="col-sm-4">
                    <div class="input-group date form-date" >
                        <input type="text" class="form-control" id="applyStart" name="applyStart" placeholder="报名开始时间" readonly/>
                        <span class="input-group-addon">
                    <i class="glyphicon glyphicon-calendar"></i>
                </span>
                    </div>
                </div>
                <div class="col-sm-1 control-label">截止报名</div>
                <div class="col-sm-4">
                    <div class="input-group date form-date" >
                        <input type="text" class="form-control" id="applyEnd" name="applyEnd" placeholder="报名截止时间" readonly/>
                        <span class="input-group-addon">
                    <i class="glyphicon glyphicon-calendar"></i>
                </span>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label">开始比赛</div>
                <div class="col-sm-4">
                    <div class="input-group date form-date" >
                        <input type="text" class="form-control" id="compeStartTime" name="compeStartTime" placeholder="比赛开始时间" readonly/>
                        <span class="input-group-addon">
                    <i class="glyphicon glyphicon-calendar"></i>
                </span>
                    </div>

                </div>
                <div class="col-sm-1 control-label">比赛结束</div>
                <div class="col-sm-4">
                    <div class="input-group date form-date" >
                        <input type="text" class="form-control" id="compeEndTime" name="compeEndTime" placeholder="比赛结束时间" readonly/>
                        <span class="input-group-addon">
                    <i class="glyphicon glyphicon-calendar"></i>
                </span>
                    </div>

                </div>

            </div>

            <div class="form-group">
                <div class="col-sm-1 control-label">竞赛组别</div>
                <div class="col-sm-4">
                    <select class="selectpicker form-control" title="选择一项或多项" multiple id="group" name="group">
                        <c:forEach items="${competitionGroupList}" var="competitionGroup">
                            <option >${competitionGroup.name}</option>
                        </c:forEach>
                    </select>
                </div>
            <div class="col-sm-1 control-label">负责人</div>
            <div class="col-sm-4">
                <select class="selectpicker form-control" id="tid" name="tid">
                 <c:forEach items="${teacherList}" var="teacher">
                     <option value="${teacher.id}">${teacher.name}</option>
                 </c:forEach>
                </select>
            </div>
    </div>
                <div class="form-group">
                    <div class="col-sm-1 control-label">竞赛附件</div>
                        <div class="col-sm-9">
                            <input type="file" id="compFile" name="compFile"/>
                        </div>
                    </div>

            <div class="form-group">
                <div class="col-sm-1 control-label"></div>
                &nbsp;&nbsp; &nbsp;&nbsp;<button type="button" id="submitButton" class="btn btn bg-purple bt-flat">确定
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
<script src="${path}/resources/js/create-table.js"></script>
<script src="${path}/resources/js/fileinput.min.js"></script>
<script src="${path}/resources/js/zh.js"></script>
<script src="${path}/resources/js/bootstrap-select.min.js"></script>
<script src="${path}/resources/js/defaults-zh_CN.min.js"></script>
<script src="${path}/resources/js/bootstrap-datetimepicker.min.js"></script>
<script src="${path}/resources/js/bootstrap-datetimepicker.zh-CN.js"></script>

<script>
    function intFileInput() {
        var myFile= $("#compFile");
        myFile.fileinput({
            uploadUrl:"",//上传的地址
            uploadAsync: true,              //异步上传
            language: "zh",                 //设置语言
            showCaption: true,              //是否显示标题
            showUpload: false,               //是否显示上传按钮
            showRemove: true,               //是否显示移除按钮
            showPreview: false,             //是否显示预览按钮
            browseClass: "btn bg-purple", //按钮样式
            dropZoneEnabled: false,         //是否显示拖拽区域
            maxFileCount: 1,                        //最大上传文件数限制
            enctype: 'multipart/form-data',
            initialPreviewAsData: true, // defaults markup
            preferIconicPreview: false // 是否优先显示图标  false 即优先显示图片
        });
     /*   myFile.on("fileuploaded", function (event, data, previewId, index) {
            var result = data.response.result;
            if (result === 1) {
                initMessage("添加或者修改成功！", 'success');
                $("#myBox").hide();
                $("#myDiv").show();
            } else {
                initMessage("添加或者修改失败", "error");
            }
        });*/
    }
    function getSelectValue() {//获取多选的值
        var selectValue=[];
        var selectVal="";
        var obj = document.getElementById("group");
        for (var i = 0; i < obj.options.length; i++) {
            if (obj.options[i].selected) {
               selectValue.push(obj.options[i].text);
            }
        }
        for(var j=0;j<selectValue.length;j++){
            if(j%2!==0&&j!==selectValue.length-1){
                selectVal=selectValue+",";
            }
            selectVal=selectValue+selectValue[j];
        }
        return selectValue;
    }
    $(function () {
        initTable('#myTable', "${path}/comp/getCompetitionList",
            ['cid','name','compeStartTime','compeEndTime','host','file','place','applyStart','applyEnd','isTeam','tid','group'],
            ['id', '竞赛名称','比赛开始时间', '比赛结束时间', '举办单位','文件','比赛地点','报名开始时间','报名结束时间','竞赛类型','负责人','竞赛组别'], true, -1);
        $("#myTable").bootstrapTable('hideColumn','cid');
    });
    $("document").ready(
        function () {
           initUpdateInformation("添加竞赛", "修改竞赛", ['cid','name','compeStartTime','compeEndTime','host','file','place','applyStart','applyEnd','isTeam','tid','group'],
               "${path}/comp/deleteCompetition", "cid");
          /*  initAddAndUpdate("{path}/comp/addCompetition", "{path}/comp/deleteCompetition", "cid=",
                "", $("#cid"), "添加竞赛", true);*/
            $(".form-date").datetimepicker({
              format: 'yyyy-mm-dd hh:ii',
              language:  'zh-CN',
              weekStart: 1,
              todayBtn : true,
              todayHighlight: false,
              forceParse:true,
              autoclose: true
          });
            intFileInput();
            $("#quit").click(function () {//点击返回按钮，显示表格，隐藏添加或者修改信息
                $("#myBox").hide();
                $("#myDiv").show();
            });
            $("#submitButton").click(function () {
                var formData = new FormData($("#myFrom")[0]);
                formData.append("groups",getSelectValue());
                if(!("tid" in formData)){
                    formData.append("tid",${teacherList.get(0).id});
                }
                if(!("isTeam" in formData)){
                    formData.append("isTeam","0");
                }
                 if ($("#myBoxTitle").text() ==="添加竞赛" ) {
                     $.ajax({
                         url: '${path}/comp/addCompetition' ,
                         type: 'POST',
                         data: formData,
                         cache: false,
                         contentType: false,
                         processData: false,
                         success: function (result) {
                             if (result['result'] === "1") {
                                 initMessage("添加成功！", 'success');
                                 $("#myTable").bootstrapTable('refresh');
                                 $("#myBox").hide();
                                 $("#myDiv").show();
                             } else{
                                 initMessage(data['result'], 'error');
                             }

                         }
                     });
                   }else{
                    formData.append("cid",$("#cid").val())
                     $.ajax({
                         url: '${path}/comp/updateCompetition' ,
                         type: 'POST',
                         data: formData,
                         cache: false,
                         contentType: false,
                         processData: false,
                         success: function (result) {
                             if (result['result'] === "1") {
                                 initMessage("修改成功！", 'success');
                                 $("#myTable").bootstrapTable('refresh');
                                 $("#myBox").hide();
                                 $("#myDiv").show();
                             } else{
                                 initMessage(data['result'], 'error');
                             }

                         }
                     });
                 }
                }
            );

        }

    );
</script>
</body>
</html>