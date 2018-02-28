package com.dcms.utils;

import com.alibaba.fastjson.JSONObject;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by single on 2017/12/30.
 */
public class Tool {
    public static String result(int result){
        JSONObject resultObject=new JSONObject();
        resultObject.put("result",result);
        return resultObject.toJSONString();
    }
    public static String result(String result){
        JSONObject resultObject=new JSONObject();
        resultObject.put("result",result);
        return resultObject.toJSONString();
    }
    public static boolean isNumber(String text){
        Pattern pattern=Pattern.compile("[0-9]*");
        Matcher matcher=pattern.matcher(text);
        return matcher.matches();
    }
}
