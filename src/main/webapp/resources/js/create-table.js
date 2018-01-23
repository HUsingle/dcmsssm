/**
 * Created by single on 2018/1/23.
 */
(function () {
    function init(table,url,params,titles,hasCheckbox,toolbar) {
          $(table).bootstrapTable({
              url: url,//请求后台的url
              method: 'post',
              contentType: "application/x-www-form-urlencoded",
              dataType: "json",
              striped: true,  //是否显示行间隔色
              cache: false,//是否使用缓存，默认为true
              pagination: true,//是否显示分页
              sortable: false,//是否启用排序
              sortOrder: "asc",//排序方式
              toolbar:toolbar,//一个jQuery 选择器，指明自定义的toolbar
              queryParams: queryParams,//传递参数
              sidePagination: "server",//设置分页方式
              pageNumber: 1,//初始化加载第一页，默认第一页
              pageSize: 10,  //每页显示记录数
              pageList: [5,10],//可选择每页显示记录数
              search: true, //是否显示表格搜索，为客户端搜索
              strictSearch: false,//设置是否精确查询
              searchOnEnterKey: true,//设置是否回车响应搜索
              clickToSelect: true,//是否启用点击选中行
              minimumCountColumns: 2,//最少允许的列数
              // uniqueId: "username",//每一行的唯一标识，一般为主键列
              showToggle: true,//是否显示详细视图和列表视图的切换按钮
              cardView: false,//是否显示详细视图
              detailView: false,//是否显示父子表
              columns: createCols(params,titles,hasCheckbox)//列配置项
          });
          function createCols(params,titles,hasCheckbox) {
              if(params.length!=titles.length)
                  return null;
              var arr=[];
              if(hasCheckbox){
                  var obj={};
                  obj.checkbox=true;
                  arr.push(obj);
              }
              for(var i=0;i<params.length;i++){
                  var obje={};
                  obje.field=params[i];
                  obje.title=titles[i];
                  arr.push(obje);
              }
              return arr;
          }
        //可发送给服务端的参数：limit->pageSize,offset->pageNumber,
        // search->searchText,sort->sortName(字段),order->sortOrder('asc'或'desc')
          function queryParams(params) {
              return{
                  limit:params.limit,//页面大小
                  offset:params.offset//页码
                 /* limit:params.pageSize,//页面大小
                  offset:params.pageNumber//页码*/
                 /* pageNumber : params.pageNumber,
                  pageSize : params.pageSize*/
              };
          }
        createBootstrapTable = function (table,url,param,titles,hasCheckbox,toolbar) {
            init(table,url,param,titles,hasCheckbox,toolbar);
        }
    }
})();
