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
    <script src="../resources/js/jQuery.print.js"></script>
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

     
            var cccid="";
            $.post("${pageContext.request.contextPath}/comp/getLatestComp",function (msg) {
                cccid = msg[0].cid;

            },"json");
            //打印模态框
            $(".printExamTicket").click(function () {
                $.post("${pageContext.request.contextPath}/exam/getStuExamInfo",{stuNo:stuNumber,compId:cccid},function (msg) {
                    console.log(msg);
                    $(".examName").text(msg.apply.student.name);
                    $(".examSno").text(msg.apply.username);
                    $(".examSite").text(msg.classroom.site);
                    $(".examTime").text(msg.apply.competition.compeStartTime+"~"+msg.apply.competition.compeEndTime);
                    $(".seatNo").text(msg.seatNo);
                    $("#printModal").modal('show');

                },"json");
            });
            //打印按钮点击事件
            $(".printModal_submit").click(function () {
                $("#printModal").print({
                    globalStyles:true,//是否包含父文档的样式，默认为true
                    mediaPrint:false,//是否包含media='print'的链接标签。会被globalStyles选项覆盖，默认为false
                    stylesheet:null,//外部样式表的URL地址，默认为null
                    noPrintSelector:".noPrint",//不想打印的元素的jQuery选择器，默认为".no-print"
                    iframe:true,//是否使用一个iframe来替代打印表单的弹出窗口，true为在本页面进行打印，false就是说新开一个页面打印，默认为true
                    append:null,//将内容添加到打印内容的后面
                    prepend:null,//将内容添加到打印内容的前面，可以用来作为要打印内容
                    deferred:
                    $.Deferred()//回调函数
                });

            })
        });
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
                <li><a class="printExamTicket" href="#">打印准考证</a></li>
                <li ><a class="selfInfo" href="contact.html"></a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<!-- /.navbar -->

<!-- 模态框（Modal） -->
<div class="modal fade" id="printModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header noPrint">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
                </button>
                <h4 class="modal-title " >
                    打印准考证
                </h4>
            </div>
            <div class="print_context">
                <table class="table table-bordered">
                    <caption class="text-center "><strong>广西民族大学2018第一届程序设计竞赛</strong></caption>
                    <caption class="text-center "><strong>准&nbsp;&nbsp;考&nbsp;&nbsp;证</strong></caption>

                    <tbody>
                    <tr>
                        <td>姓名：</td>
                        <td class="examName">Bangalore</td>
                    </tr>
                    <tr>
                        <td>学号：</td>
                        <td class="examSno">Mumbai</td>
                    </tr>
                    <tr>
                        <td>考场：</td>
                        <td class="examSite">Mumbai</td>
                    </tr>
                    <tr>
                        <td>考试时间：</td>
                        <td class="examTime">2018-4-28 15：30 ~2018-4-4 15：23</td>
                    </tr>
                    <tr>
                        <td>座位号</td>
                        <td class="seatNo">114583010105</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default noPrint" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary printModal_submit noPrint" data-dismiss="modal" >
                    打印
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>
