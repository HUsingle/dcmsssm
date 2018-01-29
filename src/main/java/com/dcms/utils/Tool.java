package com.dcms.utils;

import com.alibaba.fastjson.JSONObject;

/**
 * Created by single on 2017/12/30.
 */
public class Tool {
    public static String result(int result){
        JSONObject resultObject=new JSONObject();
        resultObject.put("result",result);
        return resultObject.toJSONString();
    }
}
