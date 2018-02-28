<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>导入excel</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%
        pageContext.setAttribute("path", request.getContextPath());
    %>

    <link rel="stylesheet" href="${path}/resources/css/fileinput.min.css">

</head>
<body>
<div class="modal-content">
    <div class="modal-header bg-primary">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">导入表格</h4>
    </div>
    <div class="modal-body">
        <div style="text-align:right;padding:5px">
            <a href="#">
                <i class="fa fa-file-excel-o"></i>
                <span style="color:red">学生信息模板.xls</span>
            </a>
        </div>
        <hr/>
        <form id="ffImport" method="post">
            <div title="Excel导入操作" style="padding: 5px">
                <%--<input type="hidden" id="AttachGUID" name="AttachGUID"/>--%>
                <input id="excelFile" type="file" >
            </div>
        </form>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn bg-purple bt-flat">提交</button>
    </div>
</div>

<script src="${path}/resources/js/jquery.min.js"></script>
<script src="${path}/resources/js/bootstrap.min.js"></script>
<script src="${path}/resources/js/fileinput.min.js"></script>
<script src="${path}/resources/js/zh.js"></script>

</body>
</html>
