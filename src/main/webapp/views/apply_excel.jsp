<%--
  Created by IntelliJ IDEA.
  User: zx
  Date: 2018/4/10
  Time: 19:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>集体报名</title>
    <link rel="stylesheet" href="../resources/css/apply_excel.css">
    <link rel="stylesheet" href="../resources/css/messenger.css">
    <link rel="stylesheet" href="../resources/css/messenger-theme-future.css">
    <link rel="stylesheet" href="../resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/fileinput.min.css">
</head>
<body>
<%@include file="apply_header.jsp"%>

    <div id="excel_body">

            <div class="panel panel-success" style="">
                <div class="panel-heading">
                    <h3 class="panel-title">上传报名表</h3>
                </div>
                <div class="panel-body" style="height:370px;margin-bottom: 200px;">
                    <a  class="down_file" >
                        <span class="glyphicon glyphicon-circle-arrow-down" ></span>
                        <span class="file_name" >竞赛报名表模板（上传的报名表格式必须和此模板格式相同，否则无法上传）</span>
                    </a>
                    <input id="compFile" name="compFile" multiple type="file">


                </div>
            </div>
            <div class="panel panel-danger errorListBlock" style="display: none;">
                <div class="panel-heading">
                    <h3 class="panel-title">失败列表</h3>
                </div>
                <div class="panel-body errorList">

                </div>
            </div>

        </div>

    <%@include file="apply_footer.jsp"%>
<script>
    function intFileInput(cid,groupName) {
        var myFile= $("#compFile");
        myFile.fileinput({
            uploadUrl:"${pageContext.request.contextPath}/apply/importApplyTable",//上传的地址
            uploadAsync: true,              //异步上传
            language: "zh",                 //设置语言
            showCaption: true,              //是否显示标题
            showUpload: true,               //是否显示上传按钮
            showRemove: true,               //是否显示移除按钮
            showPreview: true,             //是否显示预览按钮
            browseClass: "btn bg-purple", //按钮样式
            dropZoneEnabled: true,         //是否显示拖拽区域
            allowedFileExtensions: ["xls", "xlsx"], //接收的文件后缀
            maxFileCount: 1,                        //最大上传文件数限制
            enctype: 'multipart/form-data',
            //previewFileIcon: '<i class="fa fa-file"></i>',
            initialPreviewAsData: true, // defaults markup
            preferIconicPreview: false ,// 是否优先显示图标  false 即优先显示图片
            layoutTemplates :{
                actionDelete:'', //去除上传预览的缩略图中的删除图标
                actionUpload:'',//去除上传预览缩略图中的上传图片；
                actionZoom:''   //去除上传预览缩略图中的查看详情预览的缩略图标。
            },
        });

    }

    $(document).ready(function () {
        $.post("${pageContext.request.contextPath}/comp/getLatestComp", function(data){
            if (""!=data[0].group&&data[0].group!=undefined){
                $(".down_file").attr("href", "${pageContext.request.contextPath}/fileOperate/downApplyTable?filename=竞赛报名表2.xls");   //设置下载链接
            }else {
                $(".down_file").attr("href", "${pageContext.request.contextPath}/fileOperate/downApplyTable?filename=竞赛报名表1.xls");
            }
        });

        intFileInput("1","aaasd");
        $('#compFile').on('fileerror', function(event, data, msg) {
            initMessage(msg, "error");
        });
        $('#compFile').on('fileuploaded', function(event, data, msg) {
            var result = data.response.result;
            if (result === "导入成功!") {
                var er = data.response.errors;
                result+="&nbsp;&nbsp;失败："+er.length;
                result+="&nbsp;&nbsp;成功："+data.response.success.length;
                initMessage(result, "success");
                if (er.length>0){
                    $(".errorListBlock").show();
                    $(".errorList").empty();
                }


                $.each(er,function (i) {
                    $(".errorList").append("<a href=\"#\" class=\"list-group-item\">"+"学号:"+er[i].username+"   姓名"+er[i].student.name+"</a>");
                })

            } else {
              initMessage(result, "error");
            }
        });
        $("#excel_body").children().find(".form-control").css({"height":"40px","line-height":"27px"});

        function initMessage(message, state) {
            $._messengerDefaults = {
                extraClasses: 'messenger-fixed messenger-theme-future  messenger-on-right'
            };
            $.globalMessenger().post({
                message: message,//提示信息
                type: state,//消息类型。error、info、success
                hideAfter: 4,//多长时间消失
                id: 1, //：唯一的ID。 如果提供，则一次只显示一个带有该ID的消息。
                showCloseButton: true//是否显示关闭按钮
            });
        }
    })

</script>
        <script src="../resources/js/jquery.min.js"></script>
        <script src="../resources/js/bootstrap.min.js"></script>
        <script src="../resources/js/bootstrap-table.min.js"></script>
        <script src="../resources/js/bootstrap-table-zh-CN.min.js"></script>
        <script src="../resources/js/messenger.min.js"></script>
        <script src="../resources/js/create-table.js"></script>
        <script src="../resources/js/bootstrap-select.min.js"></script>
        <script src="../resources/js/fileinput.min.js"></script>
        <script src="../resources/js/zh.js"></script>
        <script src="../resources/js/defaults-zh_CN.min.js"></script>
        <script src="../resources/js/bootstrap-datetimepicker.min.js"></script>
        <script src="../resources/js/bootstrap-datetimepicker.zh-CN.js"></script>
</body>
</html>
