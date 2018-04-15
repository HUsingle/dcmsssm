<%--
  Created by IntelliJ IDEA.
  User: ZX
  Date: 2018/1/21
  Time: 13:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html >
<head>
    <meta charset="utf-8">
    <meta name="viewport"    content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author"      content="Sergey Pozhilov (GetTemplate.com)">

    <title>Home</title>

    <link rel="stylesheet" href="../resources/css/bootstrap.min.css">
    <link  href="../resources/css/fileinput.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="../resources/css/AdminLTE.min.css">
    <link rel="stylesheet" href="../resources/css/bootstrap-theme.css" media="screen" >

  <%--  <link rel="stylesheet" href="../resources/css/messenger.css">--%>
    <link rel="stylesheet" href="../resources/css/style.css">






    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="../resources/js/html5shiv.js"></script>
    <script src="../resources/js/respond.min.js"></script>
    <![endif]-->
    <!-- Custom styles for our template -->

    <!-- JavaScript libs are placed at the end of the document so the pages load faster -->
    <script src="../resources/js/jquery.min.js"></script>
    <script src="../resources/js/bootstrap.min.js"></script>

    <script src="../resources/js/messenger.min.js"></script>
    <script src="../resources/js/create-table.js"></script>
    <script src="../resources/js/bootstrap-select.min.js"></script>
    <script src="../resources/js/fileinput.min.js"></script>
    <script src="../resources/js/zh.js"></script>
    <script src="../resources/js/defaults-zh_CN.min.js"></script>
    <script src="../resources/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../resources/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="../resources/js/fileUploadInit.js"></script>

    <script>
        var stuNumber;
        $(document).ready(function () {
            function intFileInput() {
                var myFile = $("#compFile");
                 myFile.fileinput({
                    uploadUrl: "${pageContext.request.contextPath}/apply/importApplyTable",//上传的地址
                    uploadAsync: true,              //异步上传
                    language: "zh",                 //设置语言
                    showCaption: true,              //是否显示标题
                    showUpload: true,               //是否显示上传按钮
                    showRemove: true,               //是否显示移除按钮
                    showPreview: false,             //是否显示预览按钮
                    browseClass: "btn  btn-danger", //按钮样式
                    allowedFileExtensions: ['xls', 'xlsx'],//接收的文件后缀
                    dropZoneEnabled: false,         //是否显示拖拽区域
                    maxFileCount: 1,                        //最大上传文件数限制
                    enctype: 'multipart/form-data',
                    initialPreviewAsData: true, // defaults markup
                    preferIconicPreview: false // 是否优先显示图标  false 即优先显示图片
                   /* uploadExtraData:{compId:"2",groupName:"java"}*/
                });
            }
            //获取session
            $.post("${pageContext.request.contextPath}/getSession",
                { sessionName: "account" },function (msg) {
                    if(msg=="ng"){
                        alert("你还没有登陆，请先登录！")
                        window.location.href="login.jsp";
                    }
                    else{
                        //获取学生信息
                        stuNumber =msg;
                        $.post("${pageContext.request.contextPath}/student/qryById",
                            { account: stuNumber },function (data) {
                                $(".selfInfo").html('<span class=\"glyphicon glyphicon-user\"></span>'+data[0].name);
                            },"json");
                    }
                });

           /* $("#applyUpload").click(function () {
              $("#ImportComp").modal("show");
                intFileInput();
            });*/
            //file-caption form-control kv-fileinput-caption
        })
    </script>

</head>

<body class="home">

<!-- Fixed navbar -->
<div class="navbar navbar-inverse navbar-fixed-top headroom" >
    <div class="container">
        <div class="navbar-header">
            <!-- Button for smallest screens -->
            <%--icon--%>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav pull-right">
                <li class="active"><a href="apply_index.jsp">主页</a></li>
                <li><a href="about.html">查询</a></li>
                <li><a href="apply_excel.jsp" id="applyUpload"><i class="fa fa-upload"></i> 上传报名表</a></li>
                <li><a href="contact.html">打印准考证</a></li>
                <li ><a class="selfInfo" href="contact.html"></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!-- /.navbar -->

<%--<!-- 模态框（Modal） -->
<div class="modal fade" id="ImportComp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    导入表格
                </h4>
            </div>
            <div class="modal_context_up">
                <input id="compFile" name="compFile" multiple type="file">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->--%>







<!-- Include all compiled plugins (below), or include individual files as needed -->
<!-- Javascripts
==================================================  -->

</body>
</html>
