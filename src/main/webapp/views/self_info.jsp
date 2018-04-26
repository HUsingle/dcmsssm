<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>个人信息</title>
  	<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.min.css" />

<link href="../resources/css/comp_detail.css" rel="stylesheet">
		<script src="../resources/js/jquery.min.js"></script>
		<script src="../resources/js/bootstrap.min.js"></script>


</head>
<body style="background-color: #ffffff">
<%@ include file="apply_header.jsp" %>
<div id="context" style="height: 1000px;">
		<div class="panel panel-info">
	    <div class="panel-heading">
	        <h3 class="panel-title">个人信息</h3>
	    </div>
	    <div class="panel-body">
			<table class="table table-no-bordered">
			  <tbody>
			    <tr>
			      <td class="fir">姓名</td>
			      <td>name</td>
			    </tr>
			    <tr>
			      <td class="fir">学号</td>
			      <td>sno</td>
			    </tr>
			     <tr>
			      <td class="fir">班级</td>
			      <td>class</td>
			    </tr> <tr>
			      <td class="fir">学院</td>
			      <td>college</td>
			    </tr>
			  </tbody>
			</table>
	    </div>
	    <div class="panel-heading">
	        <h3 class="panel-title">最新报名信息</h3>
	    </div>
	    <div class="panel-body">
	    	<p class="text-danger">&nbsp;&nbsp;暂无报名信息</p>
	        <table class="table table-no-bordered">
			  <tbody>
			    <tr>
			      <td class="fir">竞赛名称</td>
			      <td>124124</td>
			    </tr>
			    <tr>
			      <td class="fir">竞赛日期</td>
			      <td>1241</td>
			    </tr>
			     <tr>
			      <td class="fir">报名日期</td>
			      <td>1515</td>
			     </tr>
			  </tbody>
			</table>
	    </div>
	    <div class="panel-heading">
	        <h3 class="panel-title">最新获奖信息</h3>
	    </div>
	    <div class="panel-body">
	        <p class="text-danger ">&nbsp;&nbsp;无获奖信息</p>
	        <p class="text-success ">&nbsp;&nbsp;一百等奖</p>
	    </div>
		</div>
	
</div>
<%@ include file="apply_footer.jsp" %>
<script type="text/javascript">
	$(function () { 
		
	});
</script>  
</body>
</html>