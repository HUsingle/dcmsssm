/**
 * Created by single on 2018/1/23.
 */
/*function initTable创建表格
 table 表格的id
 url 加载表格数据的url
 params 表格字段的参数名称（英文）
 titles 表格字段的中文标题
 hacheckbox 是否有checkbox
 sortNum 排序的字段下标数
 * */
function initTable(table, url, params, titles, hasCheckbox, sortNum) {
    $(table).bootstrapTable({
        url: url,//请求后台的url
        method: 'post',
        contentType: "application/x-www-form-urlencoded",//发送到服务器的数据编码类型
        dataType: "json", //服务器返回的数据类型
        striped: true,  //是否显示行间隔色
        cache: false,//是否使用缓存，默认为true
        pagination: true,//是否显示分页
        sortable: true,//是否启用排序
        sortOrder: "asc",//排序方式
        //  sortClass:"username",
        //sortName:"username",
        // toolbar: toolbar,//一个jQuery 选择器，指明自定义的toolbar
        queryParams: function (params) { //传递参数
            //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            var temp = {
                limit: params.limit,                         //页面大小
                offset: (params.offset / params.limit) + 1, //页码
                sort: params.order,
                search: $("#search").val()
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
        //showRefresh: true,//是否显示刷新按钮
        cardView: false,//是否显示详细视图
        detailView: false,//是否显示父子表
        columns: createCols(params, titles, hasCheckbox),//列配置项
        onLoadSuccess: function (data) { //加载成功时执行
            if (data.total && !data.rows.length) {
                $(table).bootstrapTable('prevPage').bootstrapTable('refresh');
            }

            if (data["rows"]!==null&&data["rows"].length>0&&("teacher" in data["rows"][0])) {//返回数据有老师这个变量
                var result = data["rows"];
                $.each(result, function (index, content) {//对数组进行循环
                    if (content["isTeam"] === 1) {
                        content["isTeam"] = "团队赛";
                    } else {
                        content["isTeam"] = "个人赛";
                    }
                    content["tid"] = content["teacher"].name;
                   /* if ("file" in content) {
                        if (content["file"].length > 0) {
                            var file = content["file"].split("/");
                            content["file"] = file[file.length - 1];
                        }
                    } else {*/
                        if (!("compeStartTime" in content))
                            content.compeStartTime = "";
                        if (!("compeEndTime" in content))
                            content.compeEndTime = "";
                        if (!("applyStart" in content))
                            content.applyStart = "";
                        if (!("applyEnd" in content))
                            content.applyEnd = "";
                        if (!("file" in content))
                             content.file = "";
                    //}
                });
                $(table).bootstrapTable("load", data);
            }
            return true;//返回值很重要
        }

    });
    //创建表头
    function createCols(params, titles, hasCheckbox) {
        if (params.length !== titles.length)
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
            if (i === sortNum) {
                obje.sortable = true;
            }
            obje.align = 'center';
            arr.push(obje);
        }
        return arr;
    }
}
//初始弹出信息
function initMessage(message, state) {
    $._messengerDefaults = {
        extraClasses: 'messenger-fixed messenger-theme-future messenger-on-top'
    };
    $.globalMessenger().post({
        message: message,//提示信息
        type: state,//消息类型。error、info、success
        hideAfter: 3,//多长时间消失
        id: 2,
        showCloseButton: true,//是否显示关闭按钮
        hideOnNavigate: true //是否隐藏导航
    });
}
/*
 *  function initUpdateInformation初始更新函数
 * titleOne添加信息处的标题
 * titleTwo修改信息处的标题
 * inputFields添加信息输入框的名字，id
 * deleteUrl删除信息的Url
 * id id列
 * */
function initUpdateInformation(titleOne, titleTwo, inputFields, deleteUrl, id) {
    $("#add").click(function () {
        $("#myBoxTitle").text(titleOne);
        for (var i = 0; i < inputFields.length; i++)
            $('#' + inputFields[i]).val("");
        if (inputFields.length === 12) {
            //    $("#group").find("option[text='pxx']").attr("selected",true);
//
            //    $("#group").selectpicker('refresh');

        }
        $('#' + inputFields[0]).attr("disabled", false);
        $("#myDiv").hide();
        $("#myBox").show();
    });
    $("#update").click(function () {
        var jsonArray = $("#myTable").bootstrapTable('getSelections');
        if (jsonArray.length < 1) {
            initMessage("请选择一条数据!", 'error');
        } else if (jsonArray.length > 1) {
            initMessage("请选择一条数据,不要多选!", 'error');
        } else {
            $("#myBoxTitle").text(titleTwo);
            if (inputFields.length < 12) {
                for (var i = 0; i < inputFields.length; i++) {
                    $('#' + inputFields[i]).val(jsonArray[0][inputFields[i]]);
                }
            } else {
                for (var j = 0; j < 8; j++) {
                    $('#' + inputFields[j]).val(jsonArray[0][inputFields[j]]);
                }
               // if (inputFields.length === 12) {
                   /* var isTeam = document.getElementById("isTeam");
                    //alert(jsonArray[0].isTeam);
                    for(var k=0;k<isTeam.options.length;k++){
                        if(jsonArray[0].isTeam===isTeam.options[k].text()){
                            isTeam.options[i].selected=true;
                        }
                    }*/
                    // opts.options[i].selected = 'selected';

                  //$("#isTeam").find("option[text=" + jsonArray[0]['isTeam'] + "]").attr("selected", true);
                    //    $("#group").selectpicker('refresh');
                //}
            }
            $('#' + inputFields[0]).attr("disabled", true);
            $("#myDiv").hide();
            $("#myBox").show();
        }
    });
    $("#delete").click(function () {
        var jsonArray = $("#myTable").bootstrapTable('getSelections');
        if (jsonArray.length < 1) {
            initMessage("请至少选择一条记录!", 'error');
        } else {
            var ids = '';
            for (var i = 0; i < jsonArray.length; i++)
                ids += jsonArray[i][id] + ',';
            $.ajax({
                type: 'POST',
                url: deleteUrl,
                data: {
                    'id': ids
                },
                dataType: "json",
                success: function (data) {
                    if (data['result'] > 0) {
                        initMessage("删除成功！", 'success');
                        $("#myTable").bootstrapTable('refresh');

                    } else {
                        initMessage("删除失败！", 'error');
                    }
                }
            });
        }
    });

    /* $("#quit").click(function () {
     $("#myBox").hide();
     $("#myDiv").show();
     });*/
}
/*
 * function initAddAndUpdate初始添加或者修改信息
 * addUrl 添加信息的url
 * UpdateUrl 修改信息的Url
 * UpdateParams 修改id的参数
 * errorMessage 主键（那个主键）不能为空的错误信息
 * key 主键输入框的id（如$("#username")）
 * addTitle 添加信息的标题
 * isAutoAddId 是否是自增id
 * */
function initAddAndUpdate(addUrl, UpdateUrl, UpdateParams, errorMessage, key, addTitle, isAutoAddId) {
    $("#quit").click(function () {//点击返回按钮，显示表格，隐藏添加或者修改信息
        $("#myBox").hide();
        $("#myDiv").show();
    });
    $("#submitButton").click(function () {
        var id = key.val();
        if (id.length === 0 && !isAutoAddId) {
            initMessage(errorMessage, "error");
        } else {
            // var formData = new FormData(document.getElementById("myForm"));//表单id
            if ($("#myBoxTitle").text() === addTitle) {
                $.ajax({
                    type: "POST",
                    url: addUrl,
                    dataType: "json",
                    data: $("#myFrom").serialize(),
                    //data:fromData,
                    success: function (data) {
                        if (data['result'] > 0) {
                            if (data['result'] === 1) {
                                initMessage("添加成功！", 'success');
                            } else {
                                initMessage("该数据已经存在，更新成功！", 'success');
                            }
                            $("#myTable").bootstrapTable('refresh');
                            $("#myBox").hide();
                            $("#myDiv").show();
                        } else {
                            initMessage("添加失败，插入数据存在错误或者服务器异常！", 'error');
                        }
                    }
                });
            } else {
                $.ajax({
                    type: "POST",
                    url: UpdateUrl,
                    dataType: "json",
                    data: UpdateParams + id + "&" + $("#myFrom").serialize(),
                    success: function (data) {
                        if (data['result'] > 0) {
                            initMessage("修改成功！", 'success');
                            $("#myTable").bootstrapTable('refresh');
                            $("#myBox").hide();
                            $("#myDiv").show();
                        } else {
                            initMessage("修改失败,修改的数据存在错误或者服务器异常！", 'error');
                        }
                    }
                });
            }
        }
    });
}

function refreshTable() {
    $("#myTable").bootstrapTable('refresh');
}


