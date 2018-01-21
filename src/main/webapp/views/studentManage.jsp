<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>学生管理</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/css/font-awesome.min.css">
  <link rel="stylesheet" href="/resources/css/AdminLTE.min.css">
<style>
    a{
        margin-left: 4px;
        margin-right: 4px;
    }
    </style>
</head>
<body>
<div id="myDiv">
<form class="form-horizontal" >
    <div class="col-sm-3">
    <div class="from-group">
    <input type="text" class="form-control" placeholder="学号/姓名/班级">
   </div>
    </div> 
<a class="btn bg-purple bt-flat " type="submit"><i class="fa fa-search"></i> 查询</a>
<a class="btn bg-purple bt-flat " id="addCourse"><i class="fa fa-plus"></i> 添加</a>
<a class="btn bg-purple bt-flat "><i class="fa fa-edit"></i> 修改</a> 
<a class="btn bg-purple bt-flat "><i class="fa fa-trash-o"></i> 删除</a> 
</form><%--
	<table id="example2" class="table table-bordered table-hover dataTable" role="grid" aria-describedby="example2_info">
		<thead>
		<tr role="row"><th class="sorting_asc" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="渲染引擎: activate to sort column descending">渲染引擎</th><th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="浏览器: activate to sort column ascending">浏览器</th><th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="平台: activate to sort column ascending">平台</th><th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="引擎版本: activate to sort column ascending">引擎版本</th><th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS 等级: activate to sort column ascending">CSS 等级</th></tr>
		</thead>
		<tbody>


	</table>--%>
<div class="row">
	<div class="col-md-12">
		<table class="table table-bordered table-hover dataTable" style="margin-top: 15px;margin-left: 15px;">
			<thread>
			<tr>
				<th class="text-center"><input type="checkbox"></th>
				<th class="text-center">学号</th>
				<th class="text-center">名字</th>
				<th class="text-center">密码</th>
				<th class="text-center">班级</th>
				<th class="text-center">学院</th>
				<th class="text-center">手机号码</th>
				<th class="text-center">电子邮箱</th>
			</tr>
			</thread>
			<tbody>
			<c:forEach items="${studentList}" var="student">
				<tr>
					<th class="text-center"><input type="checkbox"></th>
					<td class="text-center">${student.id}</td>
					<td class="text-center">${student.name}</td>
					<td class="text-center">${student.password}</td>
					<td class="text-center">${student.studentClass}</td>
					<td class="text-center">${student.college}</td>
					<td class="text-center">${student.phone}</td>
					<td class="text-center">${student.email}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>
	<!-- 分页 -->
	<div class="row" style="margin-left: 0px;">
		<%--<div class="col-md-6">
			当前${pageInfo.pageNum }页，总共${pageInfo.pages }页，总共${pageInfo.total }条记录
		</div>--%>
		<div class="col-md-6">
			<nav aria-lable="Page navigation">
				<ul class="pagination" style="margin-top: -10px;">

					<li><a href="/student/getAllStudent?pageNow=1">首页</a></li>
                     <%--  是否有前一页--%>
					<c:if test="${pageInfo.hasPreviousPage}">
						<li>
							<a href="/student/getAllStudent?pageNow=${pageInfo.pageNum-1}" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
					</c:if>

                    <%--所有导航页号 int[] navigatepageNums，pageNum为当前页--%>
					<c:forEach items="${pageInfo.navigatepageNums}" var="page">
						<%--如果是当前页，则显示背景为紫色--%>
						<c:if test="${page==pageInfo.pageNum}">
							<li class="active" ><a href="/student/getAllStudent?pageNow=${page}">${page}</a></li>
						</c:if>
						<%--如果不是当前页，则背景为白色--%>
						<c:if test="${page!=pageInfo.pageNum}">
							<li><a href="/student/getAllStudent?pageNow=${page}">${page}</a></li>
						</c:if>
					</c:forEach>
                    <%--是否有下一页--%>
					<c:if test="${pageInfo.hasNextPage }">
						<li>
							<a href="/student/getAllStudent?pageNow=${pageInfo.pageNum+1}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:if>
                            <%--pages为总页数--%>
					<li><a href="/student/getAllStudent?pageNow=${pageInfo.pages}">末页</a></li>

				</ul>
			</nav>
		</div>
	</div>

</div>
<div class="box box-default" id="myBox" style="display: none;">
            <div class="box-header with-border">
              <h3 class="box-title">添加学生</h3>

             
            </div>
            <!-- /.box-header -->
            <div class="box-body">
         <form class="form-horizontal">
			<div class="form-group">
			   	<div class="col-sm-1 control-label">学号</div>
			   	<div class="col-sm-3">
			      <input type="text" class="form-control"  placeholder="学生编号"/>
			    </div>
			</div>
			<div class="form-group">
			   	<div class="col-sm-1 control-label">姓名</div>
			   	<div class="col-sm-3">
			      <input type="text" class="form-control"  placeholder="姓名"/>
			    </div>
			</div>
			 <div class="form-group">
				 <div class="col-sm-1 control-label">密码</div>
				 <div class="col-sm-3">
					 <input type="text" class="form-control"  placeholder="密码"/>
				 </div>
			 </div>
			<div class="form-group">
			   	<div class="col-sm-1 control-label">学院</div>
			   	<div class="col-sm-3">
			      <input type="text" class="form-control"  placeholder="学院"/>
			    </div>
			</div>
			<div class="form-group">
			   	<div class="col-sm-1 control-label">手机号</div>
			   	<div class="col-sm-3">
			      <input type="text" class="form-control" placeholder="手机号"/>
			    </div>
			</div>
			<div class="form-group">
			   	<div class="col-sm-1 control-label">专业班级</div>
			   	<div class="col-sm-3">
			      <input type="text" class="form-control" placeholder="专业班级"/>
			    </div>
			</div>
        <div class="form-group">
			   	<div class="col-sm-1 control-label">电子邮箱</div>
			   	<div class="col-sm-3">
			      <input type="text" class="form-control" placeholder="电子邮箱"/>
			    </div>
			</div>
		
			<div class="form-group">
				<div class="col-sm-1 control-label"></div> 
                &nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn bg-purple bt-flat" >确定</button>
                &nbsp;&nbsp;<button type="button" class="btn btn bg-purple bt-flat" id="quit" >取消</button>
				&nbsp;&nbsp;<button type="button" class="btn btn bg-purple bt-flat" >导入表格</button>
			</div>
		</form>
            </div>
            <!-- /.box-body -->
          </div>
    
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function () {
		$("#addCourse").click(function () {
			$("#myDiv").hide();
			$("#myBox").show();
        });
        $("#quit").click(function () {
            $("#myBox").hide();
            $("#myDiv").show();
        });
    });

</script>

</body>
</html>