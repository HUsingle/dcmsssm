package com.dcms.utils;

import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
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
    //竞赛答案文件路径(upload/comp_key_file/竞赛id/)
    public static final String competition_key_PATH="upload/comp_key_file/";


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
   //下载
    public static void downLoad(String filePath, String fileName, HttpServletResponse response, HttpServletRequest request){
        try {
            String path = request.getSession().getServletContext().getRealPath(filePath);
            //获取输入流
            File file=new File(path,fileName);
            if(!file.exists())
               file.createNewFile();
            InputStream inputStream= new BufferedInputStream(new FileInputStream(file));
            String enFileName = URLEncoder.encode(fileName,"UTF-8");
            //设置文件下载头
            response.setHeader("Content-Disposition", "attachment;filename=" + enFileName);
            //设置文件ContentType类型，这样设置，会自动判断下载文件类型
            response.setContentType("multipart/form-data");
            BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
            int len = 0;
            while((len = inputStream.read()) != -1){
                out.write(len);
                out.flush();
            }
            inputStream.close();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();

        }

    }


}
