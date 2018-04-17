package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.ExamInfo;
import com.dcms.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/exam")
public class ExamController {
    @Autowired
    ExamService examService;
    @RequestMapping("/getStuExamInfo")
    @ResponseBody
    public String getStuExamInfo(String stuNo,String compId){
        ExamInfo examInfo = examService.getStuExamInfo(stuNo,compId);
        String json  = JSONObject.toJSONStringWithDateFormat(examInfo,"yyyy-MM-dd HH:mm");
        return json;
    }
}
