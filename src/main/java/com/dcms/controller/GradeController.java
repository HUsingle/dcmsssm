package com.dcms.controller;

import com.alibaba.fastjson.JSONArray;
import com.dcms.dao.GradeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by single on 2018/4/19.
 */
@Controller
@RequestMapping(value = "/grade")
public class GradeController {
    @Autowired
    private GradeMapper gradeMapper;

    @ResponseBody
    @RequestMapping(value = "/test", produces = "application/json;charset=UTF-8")
    public String test() {
        return JSONArray.toJSONString(gradeMapper.findAllGradeByCidOrGroupName());
    }
}
