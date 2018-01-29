/**
 * Created by single on 2018/1/23.
 */
function initTable(table, url, params, titles, hasCheckbox) {
    $(table).bootstrapTable({
        url: url,//请求后台的url
        method: 'post',
        contentType: "application/x-www-form-urlencoded",//发送到服务器的数据编码类型
        dataType: "json", //服务器返回的数据类型
        striped: true,  //是否显示行间隔色
        cache: false,//是否使用缓存，默认为true
        pagination: true,//是否显示分页
        sortable: false,//是否启用排序
        sortOrder: "asc",//排序方式
      //  sortClass:"username",
        //sortName:"username",
        // toolbar: toolbar,//一个jQuery 选择器，指明自定义的toolbar
        queryParams: function (params) { //传递参数
            //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            var temp = {
                limit: params.limit,                         //页面大小
                offset: (params.offset / params.limit) + 1   //页码
            };
            return temp;
        },
        sidePagination: "server",//设置分页方式
        pageNumber: 1,//初始化加载第一页，默认第一页
        pageSize: 10,  //每页显示记录数
        pageList: [5, 10, 15],//可选择每页显示记录数
        search: false, //是否显示表格搜索，为客户端搜索
        strictSearch: false,//设置是否精确查询
        searchOnEnterKey: false,//设置是否回车响应搜索
        clickToSelect: true,//是否启用点击选中行
        minimumCountColumns: 2,//最少允许的列数
        //uniqueId: "username",//每一行的唯一标识，一般为主键列
        showToggle: false,//是否显示详细视图和列表视图的切换按钮
        cardView: false,//是否显示详细视图
        detailView: false,//是否显示父子表
        columns: createCols(params, titles, hasCheckbox)//列配置项
    });
    function createCols(params, titles, hasCheckbox) {
        if (params.length != titles.length)
            return null;
        var arr = [];
        if (hasCheckbox) {
            var obj = {};
            obj.checkbox = true;
            arr.push(obj);
        }
        for (var i = 0; i < params.length; i++) {
            var obje = {};
            obje.field = params[i];
            obje.title = titles[i];
            obje.align = 'center';
            arr.push(obje);
        }
        return arr;
    }
}
function initMessage(message,state) {
    $.globalMessenger().post({
        message: message,//提示信息
        type: state,//消息类型。error、info、success
        hideAfter: 3,//多长时间消失
        showCloseButton: true,//是否显示关闭按钮
        hideOnNavigate: true //是否隐藏导航
    });
}
function showTable() {
    $("#myBox").hide();
    $("#myDiv").show();
}
function initUpdateInformation(titleOne,titleTwo,inputFields,deleteUrl,id) {
    $("#add").click(function () {
        $("#myBoxTitle").text(titleOne);
        for(var i=0;i<inputFields.length;i++)
            $('#'+inputFields[i]).val("");
        $('#'+inputFields[0]).attr("disabled",false);
        $("#myDiv").hide();
        $("#myBox").show();
    });
    $("#update").click(function () {
        var jsonArray=$("#myTable").bootstrapTable('getSelections');
        if (jsonArray.length < 1) {
          initMessage("请选择一条数据!",'error');
        } else if (jsonArray.length > 1) {
           initMessage("请选择一条数据,不要多选!",'error');
        } else {
            $("#myBoxTitle").text(titleTwo);
            for(var i=0;i<inputFields.length;i++){
                $('#'+inputFields[i]).val(jsonArray[0][inputFields[i]]);
            }
           // if(inputFields[0]=='username')
            $('#'+inputFields[0]).attr("disabled",true);
            $("#myDiv").hide();
            $("#myBox").show();

        }
    });
    $("#delete").click(function () {
        var jsonArray=$("#myTable").bootstrapTable('getSelections');
        if (jsonArray.length < 1) {
         initMessage("请至少选择一条记录!",'error');
        } else  {
            var ids='';
            for (var i=0;i<jsonArray.length;i++)
                ids+=jsonArray[i][id]+',';
          $.ajax({
              type:'POST',
              url:deleteUrl,
              data:{
                  'username':ids
              },
              dataType:"json",
              success:function (data) {
                  if(data['result']>0){
                      initMessage("删除成功！",'success');
                      $("#myTable").bootstrapTable('refresh');
                  }else{
                      initMessage("删除失败！",'error');
                  }
              }
          });
        }
    });

    $("#quit").click(showTable());
}


