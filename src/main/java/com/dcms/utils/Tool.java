package com.dcms.utils;

import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Component;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by single on 2017/12/30.
 */
@Component
public class Tool {
    //竞赛附件保存路径
    public static final String saveCompAffixPath="upload/comp_affix_file/";
    //竞赛文件保存路径
    public static final String saveCompFilePath="upload/comp_file/";
    //报名表路径
    public static final String APPLY_TABLE_PATH="upload/apply_table/";


    //返回一个带int结果的json
    public static String result(int result){
        JSONObject resultObject=new JSONObject();
        resultObject.put("result",result);
        return resultObject.toJSONString();
    }
    //返回一个带string结果的json
    public static String result(String result){
        JSONObject resultObject=new JSONObject();
        resultObject.put("result",result);
        return resultObject.toJSONString();
    }
    //判断是否都是数字
    public static boolean isNumber(String text){
        Pattern pattern=Pattern.compile("[0-9]*");
        Matcher matcher=pattern.matcher(text);
        return matcher.matches();
    }
    //将ids转变为int数组
    public static Integer[] getInteger(String id){
        String[] idString = id.split(",");
        Integer[] idArray = new Integer[idString.length];
        for (int i = 0; i < idString.length; i++)
            idArray[i] = Integer.parseInt(idString[i]);
        return idArray;
    }
    //将ids转变为long数组
    public static Long[] getLong(String id){
        String[] idString = id.split(",");
        Long[] idArray = new Long[idString.length];
        for (int i = 0; i < idString.length; i++)
            idArray[i] = Long.parseLong(idString[i]);
        return idArray;
    }

}
